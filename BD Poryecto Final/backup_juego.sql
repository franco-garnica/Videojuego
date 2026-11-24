CREATE DATABASE BattleTankRetro;
GO
USE BattleTankRetro;
GO

CREATE TABLE Jugador (
    id_jugador INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL
);

CREATE TABLE Skin (
    id_skin INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    archivo_imagen VARCHAR(150) NOT NULL,
    faccion VARCHAR(20) NOT NULL,

    CHECK (faccion IN ('Eje', 'Aliados'))
);


CREATE TABLE Mapa (
    id_mapa INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    archivo_imagen VARCHAR(150) NOT NULL,
    escala DECIMAL(6,2) NOT NULL,

    CHECK (escala > 0)
);


CREATE TABLE Bot (
    id_bot INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    velocidad DECIMAL(5,2) NOT NULL,
    vidas INT NOT NULL,

    CHECK (velocidad > 0),
    CHECK (vidas > 0)
);


CREATE TABLE PowerUp (
    id_powerup INT IDENTITY(1,1) PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    duracion INT NOT NULL,

    CHECK (duracion >= 0)
);


CREATE TABLE Partida (
    id_partida INT IDENTITY(1,1) PRIMARY KEY,

    id_jugador INT NOT NULL,
    id_mapa INT NOT NULL,
    id_skin INT NOT NULL,

    hora_inicio DATETIME NOT NULL,
    hora_fin DATETIME NULL,

    resultado VARCHAR(20) NOT NULL,
    puntuacion INT NOT NULL,
    vidas_restantes INT NOT NULL,

    FOREIGN KEY (id_jugador)
        REFERENCES Jugador(id_jugador),

    FOREIGN KEY (id_mapa)
        REFERENCES Mapa(id_mapa),

    FOREIGN KEY (id_skin)
        REFERENCES Skin(id_skin),

    CHECK (puntuacion >= 0),
    CHECK (vidas_restantes >= 0),

    CHECK (resultado IN (
        'En curso',
        'Victoria',
        'Derrota',
        'Abandonada'
    ))
);


CREATE TABLE PartidaBot (
    id_partida INT NOT NULL,
    id_bot INT NOT NULL,

    PRIMARY KEY (id_partida, id_bot),

    FOREIGN KEY (id_partida)
        REFERENCES Partida(id_partida),

    FOREIGN KEY (id_bot)
        REFERENCES Bot(id_bot)
);


CREATE TABLE PartidaPowerUp (
    id_partida INT NOT NULL,
    id_powerup INT NOT NULL,

    PRIMARY KEY (id_partida, id_powerup),

    FOREIGN KEY (id_partida)
        REFERENCES Partida(id_partida),

    FOREIGN KEY (id_powerup)
        REFERENCES PowerUp(id_powerup)
);



USE BattleTankRetro;
GO

INSERT INTO Jugador (nombre)
VALUES
('Jugador 1'),
('Jugador 2'),
('Jugador 3');

INSERT INTO Skin (nombre, archivo_imagen, faccion)
VALUES
('Tanque Eje', 'TanqueEje.png', 'Eje'),
('Tanque Aliados', 'TanqueAliados.png', 'Aliados');

INSERT INTO Mapa (nombre, archivo_imagen, escala)
VALUES
('Mapa Clasico', 'MapaClasico.png', 50),
('Mapa Bosque', 'MapaBosque.png', 50),
('Mapa Desierto', 'MapaDesierto.png', 50);


INSERT INTO Bot (nombre, velocidad, vidas)
VALUES
('Bot Basico', 2.0, 2),
('Bot Rapido', 3.5, 1),
('Bot Resistente', 1.5, 4);

INSERT INTO PowerUp (tipo, duracion)
VALUES
('Vida Extra', 0),
('Atanque Aereo', 10),
('Inmunidad', 5);

INSERT INTO Partida (
    id_jugador,
    id_mapa,
    id_skin,
    hora_inicio,
    hora_fin,
    resultado,
    puntuacion,
    vidas_restantes
)
VALUES
(1, 1, 1, '2026-11-10 15:00:00',
 '2026-11-10 15:08:00', 'Victoria', 500, 2),

(2, 2, 2, '2026-11-11 16:00:00',
 '2026-11-11 16:05:00', 'Derrota', 150, 0),

(1, 3, 2, '2026-11-12 17:00:00',
 '2026-11-12 17:12:00', 'Victoria', 800, 1),

(3, 1, 1, '2026-11-13 18:00:00',
 NULL, 'En curso', 100, 3);


INSERT INTO PartidaBot (id_partida, id_bot)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(4, 1);

INSERT INTO PartidaPowerUp (id_partida, id_powerup)
VALUES
(1, 1),

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
(1, 2),
(2, 3),
(3, 1),
(3, 2),
(4, 3);
