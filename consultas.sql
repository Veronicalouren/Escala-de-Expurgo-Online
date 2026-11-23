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