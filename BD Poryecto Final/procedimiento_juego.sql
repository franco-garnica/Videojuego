--Crear partida

USE BattleTankRetro;
GO

CREATE PROCEDURE CrearPartida

    @id_jugador INT,
    @id_mapa INT,
    @id_skin INT

AS
BEGIN

    INSERT INTO Partida (
        id_jugador,
        id_mapa,
        id_skin,
        hora_inicio,
        resultado,
        puntuacion,
        vidas_restantes
    )

    VALUES (
        @id_jugador,
        @id_mapa,
        @id_skin,
        GETDATE(),
        'En curso',
        0,
        3
    );

END;
GO

--Ejecutacion
EXEC CrearPartida
    @id_jugador = 1,
    @id_mapa = 1,
    @id_skin = 1;
GO

--Comprobacion
SELECT * FROM Partida;
GO
