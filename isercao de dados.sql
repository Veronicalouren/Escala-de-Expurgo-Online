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
