USE BattleTankRetro;
GO

CREATE PROCEDURE sp_IniciarCampania
    @NombreUsuario VARCHAR(50),
    @IdSkin INT
AS
BEGIN
    DECLARE @IdJugador INT;

    SELECT @IdJugador = IdJugador
    FROM Jugador
    WHERE NombreUsuario = @NombreUsuario;

    IF @IdJugador IS NULL
    BEGIN
        INSERT INTO Jugador (NombreUsuario)
        VALUES (@NombreUsuario);

        SET @IdJugador = SCOPE_IDENTITY();
    END;

    INSERT INTO Campania (IdJugador, IdSkinJugador)
    VALUES (@IdJugador, @IdSkin);
END;
GO

CREATE PROCEDURE sp_IniciarPartida
    @IdCampania INT
AS
BEGIN
    DECLARE @IdMapa INT;
    DECLARE @IdSkinJugador INT;
    DECLARE @IdSkinBot INT;
    DECLARE @IdPartida INT;

    SELECT
        @IdMapa = NumeroMapaActual,
        @IdSkinJugador = IdSkinJugador
    FROM Campania
    WHERE IdCampania = @IdCampania;

    SELECT @IdMapa = IdMapa
    FROM Mapa
    WHERE NumeroMapa = @IdMapa;

    SELECT @IdSkinBot = Skin.IdSkin
    FROM Skin
    WHERE Skin.IdFaccion <> (
        SELECT IdFaccion
        FROM Skin
        WHERE IdSkin = @IdSkinJugador
    );

    INSERT INTO Partida (IdCampania, IdMapa)
    VALUES (@IdCampania, @IdMapa);

    SET @IdPartida = SCOPE_IDENTITY();

    INSERT INTO ParticipantePartida
    (IdPartida, TipoParticipante, IdSkin)
    VALUES
    (@IdPartida, 'Jugador', @IdSkinJugador),
    (@IdPartida, 'Bot', @IdSkinBot);
END;
GO

CREATE PROCEDURE sp_FinalizarPartida
    @IdPartida INT,
    @Resultado VARCHAR(20)
AS
BEGIN
    DECLARE @IdCampania INT;
    DECLARE @NumeroMapa INT;

    UPDATE Partida
    SET Resultado = @Resultado
    WHERE IdPartida = @IdPartida;

    SELECT
        @IdCampania = Campania.IdCampania,
        @NumeroMapa = Campania.NumeroMapaActual
    FROM Partida
    INNER JOIN Campania
    ON Partida.IdCampania = Campania.IdCampania
    WHERE Partida.IdPartida = @IdPartida;

    IF @Resultado = 'Victoria'
    BEGIN
        IF @NumeroMapa < 5
        BEGIN
            UPDATE Campania
            SET NumeroMapaActual = NumeroMapaActual + 1
            WHERE IdCampania = @IdCampania;
        END
        ELSE
        BEGIN
            UPDATE Campania
            SET Estado = 'Completada',
                FechaFin = GETDATE()
            WHERE IdCampania = @IdCampania;
        END;
    END;

    IF @Resultado = 'Derrota'
    BEGIN
        UPDATE Campania
        SET VidasRestantes = 3
        WHERE IdCampania = @IdCampania;
    END;
END;
GO

CREATE TRIGGER tr_FinalizarPartida
ON Partida
AFTER UPDATE
AS
BEGIN
    UPDATE Partida
    SET FechaFin = GETDATE()
    WHERE IdPartida IN (
        SELECT IdPartida
        FROM inserted
        WHERE Resultado IN ('Victoria', 'Derrota')
        AND FechaFin IS NULL
    );
END;
GO

CREATE TRIGGER tr_ControlarVidas
ON Campania
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE VidasRestantes < 0
        OR VidasRestantes > 3
    )
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'La cantidad de vidas debe estar entre 0 y 3';
    END;
END;
GO