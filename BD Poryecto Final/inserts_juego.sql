
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
(1, 2),
(2, 3),
(3, 1),
(3, 2),
(4, 3);
