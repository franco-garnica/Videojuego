USE BattleTankRetro;
GO

CREATE VIEW vw_Mapas AS
SELECT *
FROM Mapa;
GO

CREATE VIEW vw_Paredes AS
SELECT
    Mapa.Nombre,
    MapaPared.ColumnaInicio,
    MapaPared.FilaInicio,
    MapaPared.AnchoCasilleros,
    MapaPared.AltoCasilleros
FROM Mapa
INNER JOIN MapaPared
ON Mapa.IdMapa = MapaPared.IdMapa;
GO

CREATE VIEW vw_HistorialPartidas AS
SELECT
    Jugador.NombreUsuario,
    Mapa.Nombre AS Mapa,
    Partida.FechaInicio,
    Partida.Resultado
FROM Partida
INNER JOIN Campania
ON Partida.IdCampania = Campania.IdCampania
INNER JOIN Jugador
ON Campania.IdJugador = Jugador.IdJugador
INNER JOIN Mapa
ON Partida.IdMapa = Mapa.IdMapa;
GO

CREATE VIEW vw_ProgresoCampanias AS
SELECT
    Jugador.NombreUsuario,
    Campania.NumeroMapaActual,
    Campania.VidasRestantes,
    Campania.Estado
FROM Campania
INNER JOIN Jugador
ON Campania.IdJugador = Jugador.IdJugador;
GO