CREATE DATABASE WARGAME;

CREATE TABLE Usuário (
    Nome CHAR(10) NOT NULL,
    Idade INT UNSIGNED,
    Sexo CHAR(1),
    Ranking INT UNSIGNED NOT NULL,
    ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PartidasGanhas INT UNSIGNED NOT NULL,
    PartidasJogadas INT UNSIGNED NOT NULL,
    TempoJogado TIME NOT NULL
);

CREATE TABLE Jogador (
    ID INT UNSIGNED NOT NULL,
    Cor CHAR(10) NOT NULL,
    QuantidadeDeTropas INT UNSIGNED NOT NULL
);

CREATE TABLE Grupo (
    Nome VARCHAR(30) NOT NULL,
    Descrição VARCHAR(50),
    QuantidadeDeMembros INT UNSIGNED NOT NULL,
    IDCriador INT UNSIGNED NOT NULL
);

CREATE TABLE Partida (
    ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    NúmeroDeJogadores INT NOT NULL,
    TempoPartida TIME,
    DataHora DATETIME NOT NULL,
    Vencedor INT UNSIGNED,
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    IDUsuário3 INT UNSIGNED NOT NULL,
    IDUsuário4 INT UNSIGNED,
    IDUsuário5 INT UNSIGNED,
    IDUsuário6 INT UNSIGNED
);

CREATE TABLE Carta (
    Nome INT NOT NULL,
    Tipo CHAR(9) NOT NULL
);

CREATE TABLE Objetivo (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL
);

CREATE TABLE ObjetivoTerritório (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL,
    QtdTerritório INT NOT NULL
);

CREATE TABLE ObjetivoJogador (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL,
    ExércitoAlvo CHAR(8) NOT NULL
);

CREATE TABLE ObjetivoContinente (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL
);

CREATE TABLE Território (
    Nome INT NOT NULL,
    TropasPresentes INT UNSIGNED NOT NULL
);

CREATE TABLE Continente
(
Nome VARCHAR(20) NOT NULL,
QuantidadeDeTerritórios INT UNSIGNED NOT NULL,
);

CREATE TABLE AmigoDe (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL
);

CREATE TABLE TrocaMensagens (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IUsuárioD2 INT UNSIGNED NOT NULL,
    Texto VARCHAR(240) NOT NULL,
    DataHoraEnvio DATETIME NOT NULL
);

CREATE TABLE Participa (
    IDUsuário INT UNSIGNED NOT NULL,
    IDGrupo VARCHAR(30) NOT NULL
);

CREATE TABLE EnviaMSG (
    Texto VARCHAR(240) NOT NULL,
    IDUsuário INT UNSIGNED NOT NULL,
    IDGrupo VARCHAR(30) NOT NULL
);

CREATE TABLE Ocupa (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    NomeTerritório INT NOT NULL
);

CREATE TABLE FazFronteira (
    NomeTerritório1 INT NOT NULL,
    NomeTerritório2 INT NOT NULL
);

CREATE TABLE Compoẽ (
    NomeTerritório INT NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL
);

CREATE TABLE Conquista (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL
);

CREATE TABLE Joga (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    IDPartida INT UNSIGNED NOT NULL
);

CREATE TABLE EliminaJogador (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    CorJogador1 CHAR(8) NOT NULL,
    CorJogador1 CHAR(8) NOT NULL
);

CREATE TABLE DominaContinentes (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL
);