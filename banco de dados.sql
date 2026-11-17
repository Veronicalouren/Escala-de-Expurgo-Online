--- BANCO DE DADOS: ESCALA DE EXPURGO ONLINE

CREATE DATABASE IF NOT EXISTS escala_expurgo;

USE escala_expurgo;


CREATE TABLE arquivo (
    id_arquivo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    arquivo BLOB
);


CREATE TABLE perfil (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    cargo VARCHAR(255)
);


CREATE TABLE usuario (
    id_cadastrar INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    email VARCHAR(255),
    cargo VARCHAR(255)
);


CREATE TABLE escala (
    id_escala INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    data_inicio DATE,
    data_fim DATE
);


CREATE TABLE atestado (
    id_atestado INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    tipo VARCHAR(255),
    data_inicio DATE,
    data_fim DATE
);


CREATE TABLE mensagem (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    texto VARCHAR(1000)
);


-- INSERÇÃO DE DADOS PARA TESTES
USE escala_expurgo;


INSERT INTO arquivo (nome, arquivo) VALUES
('atestado_ana.pdf', NULL),
('declaracao_carlos.pdf', NULL),
('atestado_mariana.pdf', NULL);


INSERT INTO perfil (cpf, nome, email, cargo) VALUES
('11111111111', 'Ana Souza', 'ana@email.com', 'Administrador'),
('22222222222', 'Carlos Mendes', 'carlos@email.com', 'Enfermeiro'),
('33333333333', 'Mariana Lima', 'mariana@email.com', 'Técnico de Enfermagem'),
('44444444444', 'Pedro Alves', 'pedro@email.com', 'Técnico de Enfermagem');


INSERT INTO usuario (nome, cpf, email, cargo) VALUES
('Ana Souza', '11111111111', 'ana@email.com', 'Administrador'),
('Carlos Mendes', '22222222222', 'carlos@email.com', 'Enfermeiro'),
('Mariana Lima', '33333333333', 'mariana@email.com', 'Técnico de Enfermagem'),
('Pedro Alves', '44444444444', 'pedro@email.com', 'Técnico de Enfermagem');


INSERT INTO escala (nome, data_inicio, data_fim) VALUES
('Escala Novembro 2026', '2026-11-01', '2026-11-30'),
('Escala Dezembro 2026', '2026-12-01', '2026-12-31'),
('Escala Janeiro 2027', '2027-01-01', '2027-01-31');


INSERT INTO atestado (nome, tipo, data_inicio, data_fim) VALUES
('Ana Souza', 'Atestado médico', '2026-11-10', '2026-11-12'),
('Carlos Mendes', 'Declaração médica', '2026-11-15', '2026-11-15'),
('Mariana Lima', 'Atestado médico', '2026-12-03', '2026-12-07');


INSERT INTO mensagem (nome, texto) VALUES
('Ana Souza', 'Olá! Alguém gostaria de trocar o plantão do dia 15?'),
('Carlos Mendes', 'Tenho disponibilidade para realizar a troca.'),
('Mariana Lima', 'Preciso organizar minha escala da próxima semana.'),
('Pedro Alves', 'Alguém pode assumir meu plantão de domingo?'),
('Ana Souza', 'A escala de novembro foi atualizada!');



-- CONSULTAS SQL
SELECT
    usuario.nome AS usuario,
    usuario.cpf,
    perfil.email,
    perfil.cargo
FROM usuario
INNER JOIN perfil
    ON usuario.cpf = perfil.cpf;


SELECT
    escala.nome AS escala,
    escala.data_inicio,
    escala.data_fim,
    usuario.nome AS responsavel
FROM escala
INNER JOIN usuario
    ON escala.id_usuario = usuario.id_cadastrar;


SELECT
    usuario.nome AS profissional,
    atestado.tipo,
    atestado.data_inicio,
    atestado.data_fim
FROM atestado
INNER JOIN usuario
    ON atestado.id_usuario = usuario.id_cadastrar;


SELECT
    usuario.nome AS remetente,
    mensagem.texto
FROM mensagem
INNER JOIN usuario
    ON mensagem.id_usuario = usuario.id_cadastrar;


SELECT
    arquivo.nome AS nome_arquivo,
    atestado.nome AS profissional,
    atestado.tipo,
    atestado.data_inicio,
    atestado.data_fim
FROM arquivo
INNER JOIN atestado
    ON arquivo.id_atestado = atestado.id_atestado;


SELECT
    id_cadastrar,
    nome,
    cpf,
    email,
    cargo
FROM usuario
ORDER BY nome;


SELECT
    id_escala,
    nome,
    data_inicio,
    data_fim
FROM escala
WHERE data_inicio BETWEEN '2026-11-01' AND '2026-12-31';


SELECT
    id_atestado,
    nome,
    tipo,
    data_inicio,
    data_fim
FROM atestado
ORDER BY data_inicio;


SELECT
    id_mensagem,
    nome,
    texto
FROM mensagem
WHERE texto LIKE '%trocar%';


SELECT
    id_arquivo,
    nome
FROM arquivo
ORDER BY nome;

