CREATE DATABASE BattleTankRetro;
GO

USE BattleTankRetro;
GO

CREATE TABLE Faccion (
    IdFaccion INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Skin (
    IdSkin INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    IdFaccion INT NOT NULL,
    ArchivoTanque VARCHAR(100),
    ArchivoTorreta VARCHAR(100),
    FOREIGN KEY (IdFaccion) REFERENCES Faccion(IdFaccion)
);

CREATE TABLE Mapa (
    IdMapa INT IDENTITY(1,1) PRIMARY KEY,
    NumeroMapa INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    ArchivoFondo VARCHAR(100),
    ArchivoPared VARCHAR(100)
);

CREATE TABLE MapaPared (
    IdMapaPared INT IDENTITY(1,1) PRIMARY KEY,
    IdMapa INT NOT NULL,
    ColumnaInicio INT,
    FilaInicio INT,
    AnchoCasilleros INT,
    AltoCasilleros INT,
    FOREIGN KEY (IdMapa) REFERENCES Mapa(IdMapa)
);

CREATE TABLE Jugador (
    IdJugador INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL,
    FechaRegistro DATE DEFAULT GETDATE()
);

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

CREATE TABLE ParticipantePartida (
    IdParticipante INT IDENTITY(1,1) PRIMARY KEY,
    IdPartida INT NOT NULL,
    TipoParticipante VARCHAR(20),
    IdFaccion INT NOT NULL,
    IdSkin INT NOT NULL,
    VidasFinales INT,
    FOREIGN KEY (IdPartida) REFERENCES Partida(IdPartida),
    FOREIGN KEY (IdFaccion) REFERENCES Faccion(IdFaccion),
    FOREIGN KEY (IdSkin) REFERENCES Skin(IdSkin)
);