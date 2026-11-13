--- BANCO DE DADOS: ESCALA DE EXPURGO ONLINE

CREATE DATABASE IF NOT EXISTS escala_expurgo;

USE escala_expurgo;


CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(100) NOT NULL,
    pode_editar BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE unidade (
    id_unidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);


CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_admissao DATE NOT NULL,
    foto_perfil VARCHAR(255),

    id_cargo INT NOT NULL,
    id_unidade INT NOT NULL,

    FOREIGN KEY (id_cargo)
        REFERENCES cargo(id_cargo),

    FOREIGN KEY (id_unidade)
        REFERENCES unidade(id_unidade)
);


CREATE TABLE escala (
    id_escala INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    edicao_bloqueada BOOLEAN NOT NULL DEFAULT FALSE,

    id_unidade INT NOT NULL,

    FOREIGN KEY (id_unidade)
        REFERENCES unidade(id_unidade)
);


CREATE TABLE plantao (
    id_plantao INT AUTO_INCREMENT PRIMARY KEY,
    data_plantao DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Agendado',

    id_escala INT NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_escala)
        REFERENCES escala(id_escala),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);


CREATE TABLE disponibilidade (
    id_disponibilidade INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NOT NULL,
    motivo VARCHAR(255),

    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);
Banco de dados: Escala de Expurgo 

CREATE TABLE documento (
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    arquivo VARCHAR(255) NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    id_disponibilidade INT NOT NULL UNIQUE,

    FOREIGN KEY (id_disponibilidade)
        REFERENCES disponibilidade(id_disponibilidade)
);

CREATE TABLE troca_plantao (
    id_troca INT AUTO_INCREMENT PRIMARY KEY,
    data_solicitacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',

    id_plantao_origem INT NOT NULL,
    id_plantao_destino INT NOT NULL,
    id_solicitante INT NOT NULL,
    id_destinatario INT NOT NULL,

    FOREIGN KEY (id_plantao_origem)
        REFERENCES plantao(id_plantao),

    FOREIGN KEY (id_plantao_destino)
        REFERENCES plantao(id_plantao),

    FOREIGN KEY (id_solicitante)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_destinatario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE notificacao (
    id_notificacao INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(255) NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    visualizada BOOLEAN NOT NULL DEFAULT FALSE,

    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE chat (
    id_chat INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,

    id_unidade INT NOT NULL UNIQUE,

    FOREIGN KEY (id_unidade)
        REFERENCES unidade(id_unidade)
);

CREATE TABLE mensagem (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    conteudo TEXT NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    id_chat INT NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_chat)
        REFERENCES chat(id_chat),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- INSERÇÃO DE DADOS PARA TESTES

INSERT INTO cargo (nome_cargo, pode_editar) VALUES
('Administrador', TRUE),
('Enfermeiro Responsável', TRUE),
('Técnico de Enfermagem', FALSE);


INSERT INTO unidade (nome, endereco, telefone) VALUES
('Hospital Santa Clara', 'Rua Central, 100', '(48) 3333-1111'),
('Clínica Vida', 'Rua das Flores, 250', '(48) 3333-2222');


INSERT INTO usuario
(nome_completo, data_nascimento, cpf, email, senha,
 data_admissao, id_cargo, id_unidade)
VALUES
('Ana Souza', '1990-05-12', '11111111111',
 'ana@email.com', 'hash_teste_ana',
 '2022-03-10', 1, 1),

('Carlos Mendes', '1985-08-20', '22222222222',
 'carlos@email.com', 'hash_teste_carlos',
 '2021-06-15', 2, 1),

('Mariana Lima', '1998-11-03', '33333333333',
 'mariana@email.com', 'hash_teste_mariana',
 '2023-01-20', 3, 1),

('Pedro Alves', '1992-02-18', '44444444444',
 'pedro@email.com', 'hash_teste_pedro',
 '2022-09-05', 3, 2);


INSERT INTO escala
(nome, data_inicio, data_fim, edicao_bloqueada, id_unidade)
VALUES
('Escala Novembro 2026', '2026-11-01', '2026-11-30', FALSE, 1),
('Escala Novembro 2026 - Clínica', '2026-11-01', '2026-11-30', FALSE, 2);


INSERT INTO plantao
(data_plantao, horario_inicio, horario_fim, status,
 id_escala, id_usuario)
VALUES
('2026-11-12', '07:00:00', '19:00:00', 'Agendado', 1, 1),
('2026-11-13', '07:00:00', '19:00:00', 'Agendado', 1, 2),
('2026-11-14', '19:00:00', '07:00:00', 'Agendado', 1, 3),
('2026-11-15', '07:00:00', '19:00:00', 'Agendado', 2, 4);


INSERT INTO disponibilidade
(data_inicio, data_fim, motivo, id_usuario)
VALUES
('2026-11-20 07:00:00', '2026-11-21 19:00:00',
 'Compromisso pessoal', 3),

('2026-11-25 00:00:00', '2026-11-26 23:59:00',
 'Indisponibilidade temporária', 2);


INSERT INTO documento
(tipo, arquivo, id_disponibilidade)
VALUES
('Atestado médico', 'atestados/atestado_mariana.pdf', 1);


INSERT INTO troca_plantao
(status, id_plantao_origem, id_plantao_destino,
 id_solicitante, id_destinatario)
VALUES
('Pendente', 1, 2, 1, 2);



INSERT INTO notificacao
(mensagem, visualizada, id_usuario)
VALUES
('Você possui uma nova solicitação de troca de plantão.', FALSE, 2),

('Sua escala de novembro foi atualizada.', TRUE, 1);


INSERT INTO chat (nome, id_unidade) VALUES
('Chat - Hospital Santa Clara', 1),
('Chat - Clínica Vida', 2);



INSERT INTO mensagem (conteudo, id_chat, id_usuario) VALUES
('Olá! Alguém gostaria de trocar o plantão do dia 12?',
 1, 1),

('Tenho interesse na troca. Podemos conversar!',
 1, 2),

('Precisamos organizar a escala da próxima semana.',
 1, 3),

('Bom dia! Vamos organizar os plantões da clínica.',
 2, 4);

