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
