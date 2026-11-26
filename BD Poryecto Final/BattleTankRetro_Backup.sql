IF DB_ID('BattleTankRetro') IS NULL
BEGIN
    EXEC('CREATE DATABASE BattleTankRetro');
END;
GO

USE BattleTankRetro;
GO

CREATE TABLE Faccion (
    IdFaccion INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Skin (
    IdSkin INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    IdFaccion INT NOT NULL,
    ArchivoTanque VARCHAR(100),
    ArchivoTorreta VARCHAR(100),
    FOREIGN KEY (IdFaccion) REFERENCES Faccion(IdFaccion)
);
GO

CREATE TABLE Mapa (
    IdMapa INT IDENTITY(1,1) PRIMARY KEY,
    NumeroMapa INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    ArchivoFondo VARCHAR(100),
    ArchivoPared VARCHAR(100)
);
GO

CREATE TABLE MapaPared (
    IdMapaPared INT IDENTITY(1,1) PRIMARY KEY,
    IdMapa INT NOT NULL,
    ColumnaInicio INT,
    FilaInicio INT,
    AnchoCasilleros INT,
    AltoCasilleros INT,
    FOREIGN KEY (IdMapa) REFERENCES Mapa(IdMapa)
);
GO

CREATE TABLE RecursoVisual (
    IdRecurso INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Archivo VARCHAR(100)
);
GO

CREATE TABLE Jugador (
    IdJugador INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL,
    FechaRegistro DATE DEFAULT GETDATE()
);
GO

CREATE TABLE Campania (
    IdCampania INT IDENTITY(1,1) PRIMARY KEY,
    IdJugador INT NOT NULL,
    IdSkinJugador INT NOT NULL,
    FechaInicio DATE DEFAULT GETDATE(),
    FechaFin DATE,
    NumeroMapaActual INT DEFAULT 1,
    VidasRestantes INT DEFAULT 3,
    Estado VARCHAR(20) DEFAULT 'En curso',
    FOREIGN KEY (IdJugador) REFERENCES Jugador(IdJugador),
    FOREIGN KEY (IdSkinJugador) REFERENCES Skin(IdSkin)
);
GO

CREATE TABLE Partida (
    IdPartida INT IDENTITY(1,1) PRIMARY KEY,
    IdCampania INT NOT NULL,
    IdMapa INT NOT NULL,
    FechaInicio DATETIME DEFAULT GETDATE(),
    FechaFin DATETIME,
    Resultado VARCHAR(20) DEFAULT 'En curso',
    FOREIGN KEY (IdCampania) REFERENCES Campania(IdCampania),
    FOREIGN KEY (IdMapa) REFERENCES Mapa(IdMapa)
);
GO

CREATE TABLE ParticipantePartida (
    IdParticipante INT IDENTITY(1,1) PRIMARY KEY,
    IdPartida INT NOT NULL,
    TipoParticipante VARCHAR(20),
    IdSkin INT NOT NULL,
    VidasFinales INT,
    FOREIGN KEY (IdPartida) REFERENCES Partida(IdPartida),
    FOREIGN KEY (IdSkin) REFERENCES Skin(IdSkin)
);
GO

INSERT INTO Faccion (Nombre)
VALUES ('Eje'), ('Aliados');
GO

INSERT INTO Skin (Nombre, IdFaccion, ArchivoTanque, ArchivoTorreta)
VALUES
('Tanque Eje', 1, 'TanqueEje.png', 'TorretaEje.png'),
('Tanque Aliados', 2, 'TanqueAliados.png', 'TorretaAliados.png');
GO

INSERT INTO Mapa (NumeroMapa, Nombre, ArchivoFondo, ArchivoPared)
VALUES
(1, 'Desierto', 'Desierto.png', 'ParedDesierto.png'),
(2, 'Pueblo', 'Pueblo.png', 'ParedPueblo.png'),
(3, 'Nieve', 'Nieve.png', 'ParedNieve.png'),
(4, 'Bosque', 'Bosque.png', 'ParedBosque.png'),
(5, 'Urbano', 'Urbano.png', 'ParedUrbano.png');
GO

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
GO

CREATE VIEW vw_Mapas AS
SELECT NumeroMapa, Nombre, ArchivoFondo, ArchivoPared
FROM Mapa;
GO

CREATE VIEW vw_DistribucionParedes AS
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
    Partida.FechaFin,
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
    Skin.Nombre AS TanqueElegido,
    Campania.NumeroMapaActual,
    Campania.VidasRestantes,
    Campania.Estado
FROM Campania
INNER JOIN Jugador
    ON Campania.IdJugador = Jugador.IdJugador
INNER JOIN Skin
    ON Campania.IdSkinJugador = Skin.IdSkin;
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
    DECLARE @NumeroMapa INT;
    DECLARE @IdMapa INT;
    DECLARE @IdSkinJugador INT;
    DECLARE @IdSkinBot INT;
    DECLARE @IdPartida INT;

    SELECT
        @NumeroMapa = NumeroMapaActual,
        @IdSkinJugador = IdSkinJugador
    FROM Campania
    WHERE IdCampania = @IdCampania;

    SELECT @IdMapa = IdMapa
    FROM Mapa
    WHERE NumeroMapa = @NumeroMapa;

    SELECT TOP 1 @IdSkinBot = IdSkin
    FROM Skin
    WHERE IdFaccion <> (
        SELECT IdFaccion
        FROM Skin
        WHERE IdSkin = @IdSkinJugador
    )
    ORDER BY IdSkin;

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
