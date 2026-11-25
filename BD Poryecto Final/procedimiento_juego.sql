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