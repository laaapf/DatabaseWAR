USE WARGAME;

INSERT INTO Usuário (Nome) VALUES ('Vitor');
INSERT INTO Usuário (Nome) VALUES ('Carlos');
INSERT INTO Usuário (Nome) VALUES ('Joao');
INSERT INTO Usuário (Nome) VALUES ('Vitor');
INSERT INTO Usuário (Nome) VALUES ('Cesar');
INSERT INTO Usuário (Nome) VALUES ('Lucas');
INSERT INTO Usuário (Nome) VALUES ('Vitoria');
INSERT INTO Usuário (Nome) VALUES ('Maria');
INSERT INTO Usuário (Nome) VALUES ('Jose');
INSERT INTO Usuário (Nome) VALUES ('Gabriel');
INSERT INTO Usuário (Nome) VALUES ('Gabriel');

INSERT INTO Jogador  VALUES ('VERMELHO',1);
INSERT INTO Jogador VALUES ('PRETO',2);
INSERT INTO Jogador VALUES ('AZUL',3);
INSERT INTO Jogador  VALUES ('VERMELHO',4);
INSERT INTO Jogador  VALUES ('PRETO',5);
INSERT INTO Jogador  VALUES ('AZUL',6);
INSERT INTO Jogador  VALUES ('VERDE',7);

INSERT INTO AmigoDe VALUES (1,2);
INSERT INTO AmigoDe VALUES (2,1);
INSERT INTO AmigoDe VALUES (1,3);
INSERT INTO AmigoDe VALUES (3,1);
INSERT INTO AmigoDe VALUES (2,3);
INSERT INTO AmigoDe VALUES (3,2);
INSERT INTO AmigoDe VALUES (4,5);
INSERT INTO AmigoDe VALUES (5,4);

INSERT INTO Grupo VALUES ("Clan","Jogadores de War Profissionais",1,6);
INSERT INTO Grupo VALUES ("Warmigos","Todos lindos",3,3);

INSERT INTO Participa VALUES (5,"Warmigos");
INSERT INTO Participa VALUES (1,"Warmigos");
INSERT INTO Participa VALUES (3,"Warmigos");
INSERT INTO Participa VALUES (5,"Clan");
INSERT INTO Participa VALUES (1,"Clan");
INSERT INTO Participa VALUES (3,"Clan");
INSERT INTO Participa VALUES (4,"Clan");
INSERT INTO Participa VALUES (7,"Clan");
INSERT INTO Participa VALUES (2,"Clan");

INSERT INTO Partida (NúmeroDeJogadores, DataHora,IDUsuário1, IDUsuário2, IDUsuário3) VALUES (3,'2019-5-5 20:03:11', 1, 5,6);
INSERT INTO Partida (NúmeroDeJogadores, DataHora,IDUsuário1, IDUsuário2, IDUsuário3,IDUsuário4) VALUES (4,'2019-5-5 20:03:11', 2, 3,4,7);

INSERT INTO Joga VALUES (5, 'PRETO', 1);
INSERT INTO Joga VALUES (6, 'AZUL', 1);
INSERT INTO Joga VALUES (1, 'VERMELHO', 1);
INSERT INTO Joga VALUES (2, 'PRETO', 2);
INSERT INTO Joga VALUES (3, 'AZUL', 2);
INSERT INTO Joga VALUES (4, 'VERMELHO', 2);
INSERT INTO Joga VALUES (7, 'VERDE', 2);


INSERT INTO Ocupa  VALUES (5, 'PRETO', 2, 3);
INSERT INTO Ocupa  VALUES (5, 'PRETO', 9, 3);
INSERT INTO Ocupa  VALUES (5, 'PRETO', 4, 3);
INSERT INTO Ocupa  VALUES (5, 'PRETO', 5, 3);
INSERT INTO Ocupa  VALUES (5, 'PRETO', 7, 3);
INSERT INTO Ocupa  VALUES (5, 'PRETO', 1, 3);
INSERT INTO Ocupa  VALUES (7, 'VERDE', 21, 3);
INSERT INTO Ocupa  VALUES (7, 'VERDE', 22, 3);
INSERT INTO Ocupa  VALUES (7, 'VERDE', 27, 3);
INSERT INTO Ocupa  VALUES (7, 'VERDE', 29, 3);
INSERT INTO Ocupa VALUES (2, 'PRETO', 6, 10);
INSERT INTO Ocupa VALUES (7, 'VERDE', 12, 1);
INSERT INTO Ocupa VALUES (4, 'VERMELHO', 25, 3);
INSERT INTO Ocupa VALUES (6, 'AZUL', 21, 6);
INSERT INTO Ocupa VALUES (3, 'AZUL', 18,9);
INSERT INTO Ocupa VALUES (3, 'AZUL', 10,5);

INSERT INTO Conquista VALUES (6, 'AZUL', 'AMÉRICA DO NORTE');
INSERT INTO Conquista VALUES (1, 'VERMELHO', 'AMÉRICA DO SUL');
INSERT INTO Conquista VALUES (2, 'PRETO', 'OCEANIA');
INSERT INTO Conquista VALUES (7, 'VERDE', 'EUROPA');
INSERT INTO Conquista VALUES (3, 'AZUL', 'ÁFRICA');



INSERT INTO EnviaMSG VALUES ('Só tem lindo aqui',2, 'Clan', '2019-5-5 20:03:11');
INSERT INTO EnviaMSG VALUES ('didico muito lindo',7, 'Clan', '2019-5-5 20:03:12');
INSERT INTO EnviaMSG VALUES ('Bonde do mengao sem freio',2, 'Clan', '2019-5-5 20:03:13');
INSERT INTO EnviaMSG VALUES ('Gerson joker do war mané',7, 'Clan', '2019-5-5 20:03:14');
INSERT INTO EnviaMSG VALUES ('Thiago galhardo melhor que arrascaeta',3, 'Warmigos', '2019-5-5 20:03:11');
INSERT INTO EnviaMSG VALUES ('Arrascaeta come so comida quente',1, 'Warmigos', '2019-5-5 20:03:12');
INSERT INTO EnviaMSG VALUES ('BBBB',5, 'Warmigos', '2019-5-5 20:03:13');
INSERT INTO EnviaMSG VALUES ('AAAAA',1, 'Warmigos', '2019-5-5 20:03:14');

INSERT INTO TrocaMensagens VALUES (5,4,'Vamos jogar a noite?', '2019-5-5 15:12:15');
INSERT INTO TrocaMensagens VALUES (5,4,'Jéssica me deixa ver o Enzo, ele precisa de um pai', '2019-5-5 15:12:20');
INSERT INTO TrocaMensagens VALUES (2,3,'Topa fazer um grupo', '2019-2-2 1:12:20');

INSERT INTO Possui VALUES(42, 5, 'PRETO');
INSERT INTO Possui VALUES(41, 5, 'PRETO');
INSERT INTO Possui VALUES(2, 5, 'PRETO');
INSERT INTO Possui VALUES(6, 7, 'VERDE');
INSERT INTO Possui VALUES(43, 7, 'VERDE');
INSERT INTO Possui VALUES(29, 7, 'VERDE');

INSERT INTO Cumpre VALUES (5, 'PRETO', 13);
INSERT INTO Cumpre VALUES(6, 'AZUL', 10);
INSERT INTO Cumpre VALUES (1, 'VERMELHO', 7);
INSERT INTO Cumpre VALUES (2, 'PRETO', 6);
INSERT INTO Cumpre VALUES (3, 'AZUL', 9);
INSERT INTO Cumpre VALUES (4, 'VERMELHO', 4);
INSERT INTO Cumpre VALUES (7, 'VERDE', 12);
