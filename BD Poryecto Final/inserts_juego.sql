USE BattleTankRetro;
GO

INSERT INTO Faccion (Nombre)
VALUES
('Eje'),
('Aliados');

INSERT INTO Skin (Nombre, IdFaccion, ArchivoTanque, ArchivoTorreta)
VALUES
('Tanque Eje', 1, 'TanqueEje.png', 'TorretaEje.png'),
('Tanque Aliados', 2, 'TanqueAliados.png', 'TorretaAliados.png');

INSERT INTO Mapa (NumeroMapa, Nombre, ArchivoFondo, ArchivoPared)
VALUES
(1, 'Desierto', 'Desierto.png', 'ParedDesierto.png'),
(2, 'Pueblo', 'Pueblo.png', 'ParedPueblo.png'),
(3, 'Nieve', 'Nieve.png', 'ParedNieve.png'),
(4, 'Bosque', 'Bosque.png', 'ParedBosque.png'),
(5, 'Urbano', 'Urbano.png', 'ParedUrbano.png');

INSERT INTO RecursoVisual (Nombre, Archivo)
VALUES
('Fondo del menu', 'Fondo.png'),
('Proyectil', 'Bala.png'),
('Efecto de disparo', 'Fuego.png'),
('Imagen de vida', 'Engranaje.png');

INSERT INTO MapaPared
(IdMapa, ColumnaInicio, FilaInicio, AnchoCasilleros, AltoCasilleros)
VALUES
(1,1,1,1,6),
(1,4,1,1,6),
(1,7,1,1,4),
(1,10,1,1,4),
(1,13,1,1,6),
(1,7,6,1,1),
(1,10,6,1,1),
(1,1,8,4,1),
(1,7,8,4,3),
(1,12,8,3,1),
(1,1,10,1,5),
(1,4,10,1,4),
(1,13,10,1,5),
(1,7,12,4,3),

(2,3,1,1,5),
(2,6,3,1,6),
(2,9,1,1,5),
(2,12,3,1,6),
(2,1,5,2,1),
(2,4,8,3,1),
(2,9,8,3,1),
(2,13,10,2,1),
(2,2,11,3,1),
(2,6,12,1,3),
(2,10,12,1,3),

(3,2,2,3,1),
(3,7,1,1,4),
(3,11,2,3,1),
(3,1,5,1,4),
(3,4,5,4,1),
(3,10,5,1,4),
(3,13,5,2,1),
(3,3,8,3,1),
(3,7,8,1,4),
(3,11,8,3,1),
(3,2,12,3,1),
(3,10,12,3,1),

(4,3,1,1,7),
(4,7,1,1,5),
(4,11,1,1,7),
(4,1,4,2,1),
(4,4,4,3,1),
(4,8,4,3,1),
(4,12,4,3,1),
(4,1,9,3,1),
(4,5,8,1,5),
(4,8,9,3,1),
(4,12,9,3,1),
(4,3,13,1,2),
(4,9,13,1,2),

(5,2,1,4,1),
(5,8,1,4,1),
(5,13,2,1,4),
(5,1,4,1,4),
(5,4,4,4,1),
(5,9,4,3,1),
(5,3,7,1,4),
(5,6,7,4,1),
(5,11,7,1,4),
(5,13,9,2,1),
(5,1,12,4,1),
(5,6,12,1,3),
(5,9,12,4,1);