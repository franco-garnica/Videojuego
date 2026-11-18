USE BattleTankRetro;
GO

CREATE VIEW VistaHistorialPartidas
AS
SELECT
    Partida.id_partida,
    Jugador.nombre AS Jugador,
    Mapa.nombre AS Mapa,
    Skin.nombre AS Skin,
    Partida.hora_inicio,
    Partida.hora_fin,
    Partida.resultado,
    Partida.puntuacion,
    Partida.vidas_restantes

FROM Partida

INNER JOIN Jugador
ON Partida.id_jugador = Jugador.id_jugador

INNER JOIN Mapa
ON Partida.id_mapa = Mapa.id_mapa

INNER JOIN Skin
ON Partida.id_skin = Skin.id_skin;
GO


-- CONSULTAR EL HISTORIAL

SELECT * FROM VistaHistorialPartidas;
GO
