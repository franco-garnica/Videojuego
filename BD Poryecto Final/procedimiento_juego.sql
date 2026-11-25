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

    SELECT @IdMapa = NumeroMapaActual
    FROM Campania
    WHERE IdCampania = @IdCampania;

    INSERT INTO Partida (IdCampania, IdMapa)
    VALUES (@IdCampania, @IdMapa);
END;
GO

CREATE PROCEDURE sp_FinalizarPartida
    @IdPartida INT,
    @Resultado VARCHAR(20)
AS
BEGIN
    UPDATE Partida
    SET Resultado = @Resultado
    WHERE IdPartida = @IdPartida;

    IF @Resultado = 'Victoria'
    BEGIN
        UPDATE Campania
        SET NumeroMapaActual = NumeroMapaActual + 1
        WHERE IdCampania = (
            SELECT IdCampania
            FROM Partida
            WHERE IdPartida = @IdPartida
        );
    END;

    IF @Resultado = 'Derrota'
    BEGIN
        UPDATE Campania
        SET VidasRestantes = 3
        WHERE IdCampania = (
            SELECT IdCampania
            FROM Partida
            WHERE IdPartida = @IdPartida
        );
    END;
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
    )
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Las vidas no pueden ser negativas';
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
        WHERE Resultado = 'Victoria'
        OR Resultado = 'Derrota'
    );
END;
GO

