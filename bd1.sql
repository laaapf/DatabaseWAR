DROP DATABASE WARGAME;

CREATE DATABASE IF NOT EXISTS WARGAME;

USE WARGAME;

CREATE TABLE IF NOT EXISTS NOME_CARTAS (
    Código INT NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CHECK (Código >= 0 AND Código <= 42),
    CONSTRAINT PKNOME_CARTAS PRIMARY KEY (Código)
);

CREATE TABLE IF NOT EXISTS DESC_OBJETIVOS (
    Código INT NOT NULL,
    Descrição VARCHAR(152) NOT NULL,
    CHECK (Código >= 0 AND Código <= 13),
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
    CHECK(Nome >= 0 AND Nome <= 42),
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
    CHECK(Nome <= 41 AND Nome >= 0),
    CONSTRAINT PKTerritório PRIMARY KEY (Nome),
    CONSTRAINT FKTerritório 
    FOREIGN KEY (Nome) REFERENCES NOME_CARTAS(Código)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ocupa (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador ENUM('VERDE','VERMELHO','AMARELO','PRETO','BRANCO','AZUL') NOT NULL,
    NomeTerritório INT NOT NULL,
    TropasPresentes INT UNSIGNED NOT NULL,
    CHECK(NomeTerritório <= 41 AND NomeTerritório >= 0),
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
    CHECK(NomeTerritório1 <= 41 AND NomeTerritório2 <= 41 AND NomeTerritório1 >= 0 AND NomeTerritório2 >= 0),
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
    CHECK(NomeTerritório <= 41 AND NomeTerritório >= 0),
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
    CHECK (NomeCarta >= 0 AND NomeCarta <= 42),
    CONSTRAINT PKPossui PRIMARY KEY (NomeCarta , IDUsuário , CorJogador),
    CONSTRAINT FK1Possui FOREIGN KEY (NomeCarta)
        REFERENCES Carta (Nome)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT FK2Possui FOREIGN KEY (IDUsuário , CorJogador)
        REFERENCES Jogador (ID , Cor)
        ON UPDATE RESTRICT ON DELETE CASCADE
);


INSERT INTO NOME_CARTAS (Código,Nome) VALUES (0,'África do Sul');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (1,'Alaska');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (2,'Alemanha');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (3,'Aral');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (4,'Argélia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (5,'Argentina');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (6,'Austrália');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (7,'Bolívia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (8,'Bornéu');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (9,'Brasil');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (10,'Califórnia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (11,'China');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (12,'Congo');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (13,'Dudinka');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (14,'Egito');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (15,'França');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (16,'Groenlândia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (17,'Índia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (18,'Inglaterra');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (19,'Islândia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (20,'Japão');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (21,'Labrador');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (22,'Mackenzie');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (23,'Madagascar');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (24,'México');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (25,'Mongólia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (26,'Moscou');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (27,'Nova Guiné');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (28,'Nova York');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (29,'Omsk');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (30,'Oriente Médio');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (31,'Ottawa');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (32,'Polônia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (33,'Sibéria');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (34,'Sudão');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (35,'Suécia');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (36,'Sumatra');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (37,'Tchita');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (38,'Vancouver');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (39,'Venezuela');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (40,'Vietnã');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (41,'Vladivostok');
INSERT INTO NOME_CARTAS (Código,Nome) VALUES (42,'Curinga');

INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (0,'Destruir totalmente os Exércitos Azuis. Se voce é que possui os exércitos AZUIS ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (1,'Destruir totalmente os Exércitos Amarelos. Se voce é que possui os exércitos AMALORES ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (2,'Destruir totalmente os Exércitos Brancos. Se voce é que possui os exércitos BRANCOS ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (3,'Destruir totalmente os Exércitos Verdes. Se voce é que possui os exércitos VERDES ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (4,'Destruir totalmente os Exércitos Pretos. Se voce é que possui os exércitos PRETOS ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (5,'Destruir totalmente os Exércitos Vermelhos. Se voce é que possui os exércitos VERMELHOS ou se o jogador que o possui for eliminado por um outro jogador.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (6,'Conquistar na totalidade a América do Norte e a África.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (7,'Conquistar na totalidade a Conquistar na totalidade a Ásia e a África.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (8,'Conquistar na totalidade a América do Norte e a Oceania.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (9,'Conquistar na totalidade a Europa, a América do Sul e mais um continente à sua escolha.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (10,'Conquistar na totalidade a Ásia e a América do Sul.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (11,'Conquistar na totalidade a Europa, a Oceania e mais um terceiro continente à sua escolha.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (12,'Conquistar 18 territórios e ocupar cada um deles com pelo menos 2 exércitos.');
INSERT INTO DESC_OBJETIVOS (Código,Descrição) VALUES (13,'Conquistar 24 territórios à sua escolha.');

INSERT INTO Compõe VALUES (9,'AMÉRICA DO SUL');
INSERT INTO Compõe VALUES (5,'AMÉRICA DO SUL');
INSERT INTO Compõe VALUES (39,'AMÉRICA DO SUL');
INSERT INTO Compõe VALUES (7,'AMÉRICA DO SUL');
INSERT INTO Compõe VALUES (24,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (10,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (28,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (31,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (38,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (21,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (22,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (1,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (16,'AMÉRICA DO NORTE');
INSERT INTO Compõe VALUES (19,'EUROPA');
INSERT INTO Compõe VALUES (18,'EUROPA');
INSERT INTO Compõe VALUES (15,'EUROPA');
INSERT INTO Compõe VALUES (2,'EUROPA');
INSERT INTO Compõe VALUES (32,'EUROPA');
INSERT INTO Compõe VALUES (35,'EUROPA');
INSERT INTO Compõe VALUES (26,'EUROPA');
INSERT INTO Compõe VALUES (4,'ÁFRICA');
INSERT INTO Compõe VALUES (14,'ÁFRICA');
INSERT INTO Compõe VALUES (34,'ÁFRICA');
INSERT INTO Compõe VALUES (12,'ÁFRICA');
INSERT INTO Compõe VALUES (0,'ÁFRICA');
INSERT INTO Compõe VALUES (23,'ÁFRICA');
INSERT INTO Compõe VALUES (30,'ÁSIA');
INSERT INTO Compõe VALUES (20,'ÁSIA');
INSERT INTO Compõe VALUES (17,'ÁSIA');
INSERT INTO Compõe VALUES (3,'ÁSIA');
INSERT INTO Compõe VALUES (29,'ÁSIA');
INSERT INTO Compõe VALUES (41,'ÁSIA');
INSERT INTO Compõe VALUES (37,'ÁSIA');
INSERT INTO Compõe VALUES (25,'ÁSIA');
INSERT INTO Compõe VALUES (33,'ÁSIA');
INSERT INTO Compõe VALUES (11,'ÁSIA');
INSERT INTO Compõe VALUES (40,'ÁSIA');
INSERT INTO Compõe VALUES (6,'OCEANIA');
INSERT INTO Compõe VALUES (8,'OCEANIA');
INSERT INTO Compõe VALUES (27,'OCEANIA');
INSERT INTO Compõe VALUES (36,'OCEANIA');
INSERT INTO FazFronteira VALUES (0,12);
INSERT INTO FazFronteira VALUES (0,23);
INSERT INTO FazFronteira VALUES (1,21);
INSERT INTO FazFronteira VALUES (1,22);
INSERT INTO FazFronteira VALUES (1,41);
INSERT INTO FazFronteira VALUES (2,15);
INSERT INTO FazFronteira VALUES (2,18);
INSERT INTO FazFronteira VALUES (2,32);
INSERT INTO FazFronteira VALUES (3,11);
INSERT INTO FazFronteira VALUES (3,17);
INSERT INTO FazFronteira VALUES (3,29);
INSERT INTO FazFronteira VALUES (3,30);
INSERT INTO FazFronteira VALUES (4,9);
INSERT INTO FazFronteira VALUES (4,12);
INSERT INTO FazFronteira VALUES (4,14);
INSERT INTO FazFronteira VALUES (4,15);
INSERT INTO FazFronteira VALUES (4,34);
INSERT INTO FazFronteira VALUES (5,7);
INSERT INTO FazFronteira VALUES (5,9);
INSERT INTO FazFronteira VALUES (6,8);
INSERT INTO FazFronteira VALUES (6,27);
INSERT INTO FazFronteira VALUES (6,36);
INSERT INTO FazFronteira VALUES (7,5);
INSERT INTO FazFronteira VALUES (7,9);
INSERT INTO FazFronteira VALUES (7,39);
INSERT INTO FazFronteira VALUES (8,6);
INSERT INTO FazFronteira VALUES (8,40);
INSERT INTO FazFronteira VALUES (9,4);
INSERT INTO FazFronteira VALUES (9,5);
INSERT INTO FazFronteira VALUES (9,7);
INSERT INTO FazFronteira VALUES (9,40);
INSERT INTO FazFronteira VALUES (10,24);
INSERT INTO FazFronteira VALUES (10,28);
INSERT INTO FazFronteira VALUES (10,31);
INSERT INTO FazFronteira VALUES (10,38);
INSERT INTO FazFronteira VALUES (11,3);
INSERT INTO FazFronteira VALUES (11,17);
INSERT INTO FazFronteira VALUES (11,20);
INSERT INTO FazFronteira VALUES (11,25);
INSERT INTO FazFronteira VALUES (11,40);
INSERT INTO FazFronteira VALUES (12,0);
INSERT INTO FazFronteira VALUES (12,4);
INSERT INTO FazFronteira VALUES (12,34);
INSERT INTO FazFronteira VALUES (13,25);
INSERT INTO FazFronteira VALUES (13,29);
INSERT INTO FazFronteira VALUES (13,33);
INSERT INTO FazFronteira VALUES (13,37);
INSERT INTO FazFronteira VALUES (14,4);
INSERT INTO FazFronteira VALUES (14,15);
INSERT INTO FazFronteira VALUES (14,32);
INSERT INTO FazFronteira VALUES (14,34);
INSERT INTO FazFronteira VALUES (15,2);
INSERT INTO FazFronteira VALUES (15,4);
INSERT INTO FazFronteira VALUES (15,14);
INSERT INTO FazFronteira VALUES (15,18);
INSERT INTO FazFronteira VALUES (15,32);
INSERT INTO FazFronteira VALUES (16,19);
INSERT INTO FazFronteira VALUES (16,21);
INSERT INTO FazFronteira VALUES (16,22);
INSERT INTO FazFronteira VALUES (17,3);
INSERT INTO FazFronteira VALUES (17,11);
INSERT INTO FazFronteira VALUES (17,30);
INSERT INTO FazFronteira VALUES (17,36);
INSERT INTO FazFronteira VALUES (17,40);
INSERT INTO FazFronteira VALUES (18,2);
INSERT INTO FazFronteira VALUES (18,15);
INSERT INTO FazFronteira VALUES (18,19);
INSERT INTO FazFronteira VALUES (18,35);
INSERT INTO FazFronteira VALUES (19,16);
INSERT INTO FazFronteira VALUES (19,18);
INSERT INTO FazFronteira VALUES (20,11);
INSERT INTO FazFronteira VALUES (20,41);
INSERT INTO FazFronteira VALUES (21,16);
INSERT INTO FazFronteira VALUES (21,28);
INSERT INTO FazFronteira VALUES (21,31);
INSERT INTO FazFronteira VALUES (22,1);
INSERT INTO FazFronteira VALUES (22,16);
INSERT INTO FazFronteira VALUES (22,38);
INSERT INTO FazFronteira VALUES (23,0);
INSERT INTO FazFronteira VALUES (23,34);
INSERT INTO FazFronteira VALUES (24,10);
INSERT INTO FazFronteira VALUES (24,28);
INSERT INTO FazFronteira VALUES (24,39);
INSERT INTO FazFronteira VALUES (25,3);
INSERT INTO FazFronteira VALUES (25,11);
INSERT INTO FazFronteira VALUES (25,13);
INSERT INTO FazFronteira VALUES (25,29);
INSERT INTO FazFronteira VALUES (25,37);
INSERT INTO FazFronteira VALUES (26,29);
INSERT INTO FazFronteira VALUES (26,32);
INSERT INTO FazFronteira VALUES (26,35);
INSERT INTO FazFronteira VALUES (27,6);
INSERT INTO FazFronteira VALUES (27,8);
INSERT INTO FazFronteira VALUES (28,10);
INSERT INTO FazFronteira VALUES (28,21);
INSERT INTO FazFronteira VALUES (28,24);
INSERT INTO FazFronteira VALUES (28,31);
INSERT INTO FazFronteira VALUES (29,3);
INSERT INTO FazFronteira VALUES (29,13);
INSERT INTO FazFronteira VALUES (29,26);
INSERT INTO FazFronteira VALUES (30,3);
INSERT INTO FazFronteira VALUES (30,17);
INSERT INTO FazFronteira VALUES (31,10);
INSERT INTO FazFronteira VALUES (31,21);
INSERT INTO FazFronteira VALUES (31,28);
INSERT INTO FazFronteira VALUES (31,38);
INSERT INTO FazFronteira VALUES (32,2);
INSERT INTO FazFronteira VALUES (32,15);
INSERT INTO FazFronteira VALUES (32,26);
INSERT INTO FazFronteira VALUES (33,13);
INSERT INTO FazFronteira VALUES (33,37);
INSERT INTO FazFronteira VALUES (33,41);
INSERT INTO FazFronteira VALUES (34,4);
INSERT INTO FazFronteira VALUES (34,12);
INSERT INTO FazFronteira VALUES (34,14);
INSERT INTO FazFronteira VALUES (34,23);
INSERT INTO FazFronteira VALUES (35,18);
INSERT INTO FazFronteira VALUES (35,26);
INSERT INTO FazFronteira VALUES (36,6);
INSERT INTO FazFronteira VALUES (36,17);
INSERT INTO FazFronteira VALUES (37,13);
INSERT INTO FazFronteira VALUES (37,25);
INSERT INTO FazFronteira VALUES (37,33);
INSERT INTO FazFronteira VALUES (37,41);
INSERT INTO FazFronteira VALUES (38,1);
INSERT INTO FazFronteira VALUES (38,10);
INSERT INTO FazFronteira VALUES (38,22);
INSERT INTO FazFronteira VALUES (38,31);
INSERT INTO FazFronteira VALUES (39,7);
INSERT INTO FazFronteira VALUES (39,9);
INSERT INTO FazFronteira VALUES (39,24);
INSERT INTO FazFronteira VALUES (40,8);
INSERT INTO FazFronteira VALUES (40,11);
INSERT INTO FazFronteira VALUES (40,17);
INSERT INTO FazFronteira VALUES (41,1);
INSERT INTO FazFronteira VALUES (41,11);
INSERT INTO FazFronteira VALUES (41,20);
INSERT INTO FazFronteira VALUES (41,33);
INSERT INTO FazFronteira VALUES (41,31);


SELECT * FROM FazFronteira


