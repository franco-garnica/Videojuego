USE BattleTankRetro;
GO

INSERT INTO Faccion (Nombre)
VALUES ('Eje'), ('Aliados');

INSERT INTO Skin (Nombre, IdFaccion, ArchivoTanque, ArchivoTorreta)
VALUES
('Skin Eje', 1, 'TanqueEje.png', 'TorretaEje.png'),
('Skin Aliados', 2, 'TanqueAliados.png', 'TorretaAliados.png');

INSERT INTO Mapa (NumeroMapa, Nombre, ArchivoFondo, ArchivoPared)
VALUES
(1, 'Desierto', 'Desierto.png', 'ParedDesierto.png'),
(2, 'Pueblo', 'Pueblo.png', 'ParedPueblo.png'),
(3, 'Nieve', 'Nieve.png', 'ParedNieve.png'),
(4, 'Bosque', 'Bosque.png', 'ParedBosque.png'),
(5, 'Base Militar', 'BaseMilitar.png', 'ParedBaseMilitar.png');