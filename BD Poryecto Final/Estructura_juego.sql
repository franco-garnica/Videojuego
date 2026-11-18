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
