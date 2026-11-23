--- BANCO DE DADOS: ESCALA DE EXPURGO ONLINE

CREATE DATABASE IF NOT EXISTS escala_expurgo;

USE escala_expurgo;


CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(80) NOT NULL
);

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    id_cargo INT NOT NULL,

    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

CREATE TABLE escala (
    id_escala INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

CREATE TABLE participante_escala (
    id_participante INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_escala INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_escala)
        REFERENCES escala(id_escala),

    UNIQUE (id_usuario, id_escala)
);

CREATE TABLE mensagem (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    texto VARCHAR(1000) NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE atestado (
    id_atestado INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE documento (
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    nome_arquivo VARCHAR(255) NOT NULL,
    caminho_arquivo VARCHAR(500) NOT NULL,
    id_atestado INT NOT NULL,

    FOREIGN KEY (id_atestado)
        REFERENCES atestado(id_atestado)
);


-- INSERÇÃO DE DADOS PARA TESTES

USE escala_expurgo;

INSERT INTO cargo (nome_cargo) VALUES
('Administrador'),
('Enfermeiro'),
('Técnico de Enfermagem');

INSERT INTO usuario
(nome, cpf, email, senha, id_cargo)
VALUES
('Ana Souza', '11111111111', 'ana@email.com', 'hash_ana', 1),
('Carlos Mendes', '22222222222', 'carlos@email.com', 'hash_carlos', 2),
('Mariana Lima', '33333333333', 'mariana@email.com', 'hash_mariana', 3),
('Pedro Alves', '44444444444', 'pedro@email.com', 'hash_pedro', 3);


INSERT INTO escala (data_inicio, data_fim) VALUES
('2026-11-01', '2026-11-30'),
('2026-12-01', '2026-12-31');



INSERT INTO participante_escala
(id_usuario, id_escala)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(1, 2);


INSERT INTO mensagem (texto, id_usuario) VALUES
('Olá! Alguém gostaria de trocar o plantão do dia 15?', 1),
('Tenho disponibilidade para realizar a troca.', 2),
('Precisamos organizar a escala da próxima semana.', 3),
('Alguém pode assumir meu plantão de domingo?', 4);


INSERT INTO atestado
(tipo, data_inicio, data_fim, id_usuario)
VALUES
('Atestado médico', '2026-11-10', '2026-11-12', 1),
('Declaração médica', '2026-11-15', '2026-11-15', 2),
('Atestado médico', '2026-12-03', '2026-12-07', 3);


INSERT INTO documento
(nome_arquivo, caminho_arquivo, id_atestado)
VALUES
('atestado_ana.pdf', '/documentos/atestado_ana.pdf', 1),
('declaracao_carlos.pdf', '/documentos/declaracao_carlos.pdf', 2),
('atestado_mariana.pdf', '/documentos/atestado_mariana.pdf', 3);


-- CONSULTAS SQL
USE escala_expurgo;

SELECT
    usuario.nome,
    usuario.email,
    cargo.nome_cargo
FROM usuario
INNER JOIN cargo
ON usuario.id_cargo = cargo.id_cargo;

SELECT
    usuario.nome,
    escala.id_escala,
    escala.data_inicio,
    escala.data_fim
FROM participante_escala
INNER JOIN usuario
ON participante_escala.id_usuario = usuario.id_usuario
INNER JOIN escala
ON participante_escala.id_escala = escala.id_escala;

SELECT
    usuario.nome,
    mensagem.texto,
    mensagem.data_envio
FROM mensagem
INNER JOIN usuario
ON mensagem.id_usuario = usuario.id_usuario
ORDER BY mensagem.data_envio DESC;

SELECT
    usuario.nome,
    atestado.tipo,
    atestado.data_inicio,
    atestado.data_fim
FROM atestado
INNER JOIN usuario
ON atestado.id_usuario = usuario.id_usuario;

SELECT
    documento.nome_arquivo,
    documento.caminho_arquivo,
    atestado.tipo,
    usuario.nome
FROM documento
INNER JOIN atestado
ON documento.id_atestado = atestado.id_atestado
INNER JOIN usuario
ON atestado.id_usuario = usuario.id_usuario;

SELECT
    id_cargo,
    nome_cargo
FROM cargo
ORDER BY nome_cargo;

SELECT
    id_escala,
    data_inicio,
    data_fim
FROM escala
WHERE data_inicio >= '2026-11-01'
ORDER BY data_inicio;

SELECT
    usuario.nome,
    mensagem.texto,
    mensagem.data_envio
FROM mensagem
INNER JOIN usuario
ON mensagem.id_usuario = usuario.id_usuario
WHERE mensagem.texto LIKE '%trocar%'
ORDER BY mensagem.data_envio DESC;

SELECT
    usuario.nome,
    atestado.tipo,
    atestado.data_inicio,
    atestado.data_fim
FROM atestado
INNER JOIN usuario
ON atestado.id_usuario = usuario.id_usuario
WHERE atestado.data_inicio BETWEEN '2026-11-01' AND '2026-11-30';

SELECT
    id_documento,
    nome_arquivo,
    caminho_arquivo,
    id_atestado
FROM documento
ORDER BY nome_arquivo;