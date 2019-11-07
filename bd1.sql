DROP DATABASE WARGAME;

CREATE DATABASE IF NOT EXISTS WARGAME;

USE WARGAME;

CREATE TABLE IF NOT EXISTS NOME_CARTAS (
    Código INT NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CONSTRAINT PKNOME_CARTAS PRIMARY KEY (Código)
);

CREATE TABLE IF NOT EXISTS DESC_OBJETIVOS (
    Código INT NOT NULL,
    Descrição VARCHAR(152) NOT NULL,
    CONSTRAINT PKDESC_OBJETIVOS PRIMARY KEY (Código)
);

CREATE TABLE IF NOT EXISTS Usuário (
    Nome CHAR(10) NOT NULL,
    Idade INT UNSIGNED,
    Sexo ENUM('M','F'),
    Ranking INT UNSIGNED NOT NULL,
    ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PartidasGanhas INT UNSIGNED NOT NULL,
    PartidasJogadas INT UNSIGNED NOT NULL,
    TempoJogado TIME NOT NULL,
    CONSTRAINT PKUsuário PRIMARY KEY (ID),
    CHECK(Idade <= 100 AND Idade >= 6)
);

CREATE TABLE IF NOT EXISTS Objetivo (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL,
    CONSTRAINT PKObjetivo PRIMARY KEY (Descrição),
    CONSTRAINT FKObjetivo
    FOREIGN KEY (Descrição) REFERENCES DESC_OBJETIVOS(Código)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Jogador (
    Cor ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    ID INT UNSIGNED NOT NULL,
    DescriçãoObjetivo INT NOT NULL,
    CONSTRAINT PKJogador PRIMARY KEY (ID , Cor),
    CONSTRAINT FK1Jogador FOREIGN KEY (ID)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Jogador FOREIGN KEY (DescriçãoObjetivo)
        REFERENCES Objetivo (Descrição)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS Grupo (
    Nome VARCHAR(30) NOT NULL,
    Descrição VARCHAR(50),
    QuantidadeDeMembros INT UNSIGNED NOT NULL,
    IDCriador INT UNSIGNED NOT NULL,
    CONSTRAINT PKGrupo PRIMARY KEY (Nome),
    CONSTRAINT FKGrupo FOREIGN KEY (IDCriador)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Partida (
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
    IDUsuário6 INT UNSIGNED,
    CHECK(NúmeroDeJogadores <=6 AND NúmeroDeJogadores >=3),
    CONSTRAINT PKPartida PRIMARY KEY (ID),
    CONSTRAINT FK1Partida FOREIGN KEY (IDUsuário1)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Partida FOREIGN KEY (IDUsuário2)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK3Partida FOREIGN KEY (IDUsuário3)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK4Partida FOREIGN KEY (IDUsuário4)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK5Partida FOREIGN KEY (IDUsuário5)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK6Partida FOREIGN KEY (IDUsuário6)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK7Partida FOREIGN KEY (Vencedor)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Carta (
    Nome INT NOT NULL,
    Tipo ENUM('TRIANGULO','QUADRADO','CIRCULO','CURINGA') NOT NULL,
    CONSTRAINT PKCarta PRIMARY KEY (Nome),
    CONSTRAINT FKCarta
    FOREIGN KEY (Nome) REFERENCES NOME_CARTAS(Código) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS ObjetivoTerritório (
    Descrição INT NOT NULL,
    QtdTerritório INT NOT NULL,
    CHECK(QtdTerritório = 18 OR QtdTerritório = 24),
    CONSTRAINT PKObjTerritório PRIMARY KEY (Descrição),
    CONSTRAINT FKObjTerritório FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);



CREATE TABLE IF NOT EXISTS ObjetivoJogador (
    Descrição INT NOT NULL,
    ExércitoAlvo ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    CONSTRAINT PKObjJogador PRIMARY KEY (Descrição , ExércitoAlvo),
    CONSTRAINT FKObjJogador FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS ObjetivoContinente (
    Descrição INT NOT NULL,
    CONSTRAINT PKObjContinente PRIMARY KEY (Descrição),
    CONSTRAINT FKObjContinente FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Território (
    Nome INT NOT NULL,
    TropasPresentes INT UNSIGNED NOT NULL,
    CONSTRAINT PKTerritório PRIMARY KEY (Nome),
    CONSTRAINT FKTerritório 
    FOREIGN KEY (Nome) REFERENCES NOME_CARTAS(Código)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ocupa (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    NomeTerritório INT NOT NULL,
    CONSTRAINT PKOcupa PRIMARY KEY (IDUsuário , CorJogador , NomeTerritório),
    CONSTRAINT FK1Ocupa FOREIGN KEY (IDUsuário , CorJogador)
        REFERENCES Jogador (ID , Cor)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT FK2Ocupa FOREIGN KEY (NomeTerritório)
        REFERENCES Território (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Continente (
    Nome ENUM('ÁSIA','ÁFRICA','AMÉRICA DO SUL','AMÉRICA DO NORTE','EUROPA','OCEANIA') NOT NULL,
    QuantidadeDeTerritórios INT UNSIGNED NOT NULL,
    CONSTRAINT PKContinente PRIMARY KEY (Nome)
);

CREATE TABLE IF NOT EXISTS AmigoDe (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    CONSTRAINT PKAmigoDe PRIMARY KEY (IDUsuário1 , IDUsuário2),
    CONSTRAINT FK1AmigoDe FOREIGN KEY (IDUsuário1)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2AmigoDe FOREIGN KEY (IDUsuário2)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS TrocaMensagens (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    Texto VARCHAR(240) NOT NULL,
    DataHoraEnvio DATETIME NOT NULL,
    CONSTRAINT PKTrocaMensagens PRIMARY KEY (IDUsuário1 , IDUsuário2 , DataHoraEnvio),
    CONSTRAINT FK1TrocaMensagens FOREIGN KEY (IDUsuário1)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2TrocaMensagens FOREIGN KEY (IDUsuário2)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Participa (
    IDUsuário INT UNSIGNED NOT NULL,
    NomeGrupo VARCHAR(30) NOT NULL,
    CONSTRAINT PKParticipa PRIMARY KEY (IDUsuário),
    CONSTRAINT FK1Participa FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Participa FOREIGN KEY (NomeGrupo)
        REFERENCES Grupo (Nome)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EnviaMSG (
    Texto VARCHAR(240) NOT NULL,
    IDUsuário INT UNSIGNED NOT NULL,
    NomeGrupo VARCHAR(30) NOT NULL,
    DataHoraEnvio DATETIME NOT NULL,
    CONSTRAINT PKEnviaMSG PRIMARY KEY (IDUsuário , NomeGrupo , DataHoraEnvio),
    CONSTRAINT FK1EnviaMSG FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2EnviaMSG FOREIGN KEY (NomeGrupo)
        REFERENCES Grupo (Nome)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FazFronteira (
    NomeTerritório1 INT NOT NULL,
    NomeTerritório2 INT NOT NULL,
    CONSTRAINT PKFazFronteira PRIMARY KEY (NomeTerritório1 , NomeTerritório2),
    CONSTRAINT FK1FazFronteira FOREIGN KEY (NomeTerritório1)
        REFERENCES Território (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2FazFronteira FOREIGN KEY (NomeTerritório2)
        REFERENCES Território (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Compõe (
    NomeTerritório INT NOT NULL,
    NomeContinente ENUM('ÁSIA','ÁFRICA','AMÉRICA DO SUL','AMÉRICA DO NORTE','EUROPA','OCEANIA') NOT NULL,
    CONSTRAINT PKCompõe PRIMARY KEY (NomeTerritório),
    CONSTRAINT FK1Compõe FOREIGN KEY (NomeTerritório)
        REFERENCES Território (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Compõe FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Conquista (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    NomeContinente ENUM('ÁSIA','ÁFRICA','AMÉRICA DO SUL','AMÉRICA DO NORTE','EUROPA','OCEANIA') NOT NULL,
    CONSTRAINT PKConquista PRIMARY KEY (IDUsuário , CorJogador , NomeContinente),
    CONSTRAINT FK1Conquista FOREIGN KEY (IDUsuário , CorJogador)
        REFERENCES Jogador (ID , Cor)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT FK3Conquista FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Joga (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    IDPartida INT UNSIGNED NOT NULL,
    CONSTRAINT PKJoga PRIMARY KEY (IDUsuário , CorJogador , IDPartida),
    CONSTRAINT FK1Joga FOREIGN KEY (IDUsuário , CorJogador)
        REFERENCES Jogador (ID , Cor)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT FK2Joga FOREIGN KEY (IDPartida)
        REFERENCES Partida (ID)
        ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DominaContinentes (
    Descrição INT NOT NULL,
    NomeContinente ENUM('ÁSIA','ÁFRICA','AMÉRICA DO SUL','AMÉRICA DO NORTE','EUROPA','OCEANIA') NOT NULL,
    CONSTRAINT PKDominaContinentes PRIMARY KEY (Descrição , NomeContinente),
    CONSTRAINT FK1DominaContinentes FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2DominaContinentes FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Possui (
    NomeCarta INT NOT NULL,
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    CONSTRAINT PKPossui PRIMARY KEY (NomeCarta , IDUsuário , CorJogador),
    CONSTRAINT FK1Possui FOREIGN KEY (NomeCarta)
        REFERENCES Carta (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Possui FOREIGN KEY (IDUsuário , CorJogador)
        REFERENCES Jogador (ID , Cor)
        ON UPDATE RESTRICT ON DELETE CASCADE
);
