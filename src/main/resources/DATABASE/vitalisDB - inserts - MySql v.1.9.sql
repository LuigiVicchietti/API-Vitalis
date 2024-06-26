USE vitalisDB;

/* _______________________________________________________________________________ */
/* Sessão de delete e truncate*/

DELETE FROM lembrete WHERE id_lembrete > 0;
DELETE FROM mural WHERE id_mural > 0;
DELETE FROM ficha WHERE id_ficha > 0;
DELETE FROM denuncia WHERE id_denuncia > 0;
DELETE FROM pagamento WHERE id_pagamento > 0;
DELETE FROM assinatura WHERE id_assinatura > 0;
DELETE FROM alimento_por_refeicao WHERE id_alimento_refeicao > 0;
DELETE FROM alimento WHERE id_alimento > 0;
DELETE FROM refeicao_por_dieta WHERE id_refeicao_dieta > 0;
DELETE FROM refeicao_diaria WHERE id_refeicao_diaria > 0;
DELETE FROM refeicao WHERE id_refeicao > 0;
DELETE FROM dieta WHERE id_dieta > 0;
DELETE FROM treino WHERE id_treino > 0;
DELETE FROM rotina_diaria WHERE id_rotina_diaria > 0;
DELETE FROM tag_exercicio WHERE id_tag_exercicio > 0;
DELETE FROM exercicio WHERE id_exercicio > 0;
DELETE FROM tag WHERE id_tag > 0;
DELETE FROM rotina_semanal WHERE id_rotina_semanal > 0;
DELETE FROM rotina_mensal WHERE id_rotina_mensal > 0;
DELETE FROM rotina_usuario WHERE id_rotina_usuario > 0;
DELETE FROM especialidade_por_personal WHERE id_especialidade_personal > 0;
DELETE FROM especialidade_por_meta WHERE id_especialidade_meta > 0;
DELETE FROM especialidade WHERE id_especialidade > 0;
DELETE FROM mensagem WHERE id_mensagem > 0;
DELETE FROM chat WHERE id_chat > 0;
DELETE FROM endereco WHERE id_endereco > 0;
DELETE FROM contrato WHERE id_contrato > 0;
DELETE FROM usuario WHERE id_usuario > 0;
DELETE FROM meta WHERE id_meta > 0;
DELETE FROM midia WHERE id_midia > 0;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE lembrete;
TRUNCATE TABLE mural;
TRUNCATE TABLE ficha;
TRUNCATE TABLE denuncia;
TRUNCATE TABLE pagamento;
TRUNCATE TABLE assinatura;
TRUNCATE TABLE alimento_por_refeicao;
TRUNCATE TABLE alimento;
TRUNCATE TABLE refeicao_por_dieta;
TRUNCATE TABLE refeicao_diaria;
TRUNCATE TABLE refeicao;
TRUNCATE TABLE dieta;
TRUNCATE TABLE treino;
TRUNCATE TABLE rotina_diaria;
TRUNCATE TABLE tag_exercicio;
TRUNCATE TABLE exercicio;
TRUNCATE TABLE tag;
TRUNCATE TABLE rotina_semanal;
TRUNCATE TABLE rotina_mensal;
TRUNCATE TABLE rotina_usuario;
TRUNCATE TABLE especialidade_por_personal;
TRUNCATE TABLE especialidade_por_meta;
TRUNCATE TABLE especialidade;
TRUNCATE TABLE mensagem;
TRUNCATE TABLE chat;
TRUNCATE TABLE endereco;
TRUNCATE TABLE contrato;
TRUNCATE TABLE usuario;
TRUNCATE TABLE meta;
TRUNCATE TABLE midia;
SET FOREIGN_KEY_CHECKS = 1;


/* _______________________________________________________________________________ */
/*							     Sessão de inserts			      		     	   */
/* _______________________________________________________________________________ */

INSERT INTO meta (nome) VALUES
('Emagrecimento'),
('Ganho de Massa Muscular'),
('Melhoria da Resistência Cardiovascular'),
('Redução do Estresse'),
('Aumento da Flexibilidade'),
('Melhoria da Postura'),
('Redução da Pressão Arterial');

INSERT INTO assinatura (nome, valor) VALUES
('Viva Vitalis', 49.99);

/* _______________________________________________________________________________ */
/* Sessão de usuario */

-- SENHA -> Daniel@23133 (todos)
INSERT INTO usuario (tipo, nickname, cpf, nome, dt_nasc, sexo, email, email_recuperacao, senha, midia_id, personal_id) 
VALUES 
(0, 'ylu1Gi@@', '56438153036', 'Luigi Vicchietti', '2005-01-17', 'M', 'luigi@example.com', 'padrao@nhyira', '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, null),
(1, 'marC@SSilV4', '92865867013', 'Marcos Silva Oliveira Pinto Santos', '1980-12-05', 'M', 'marcos@example.com', 'padrao@nhyira', '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, null);

-- SENHA -> Daniel@23133 (todos)
INSERT INTO usuario (tipo, nickname, cpf, nome, dt_nasc, sexo, email, email_recuperacao, senha, midia_id, personal_id) 
VALUES 
(0, 'w1llSal4d@', '95931984070', 'Will Dantas', '2004-03-31', 'M', 'will@example.com', 'padrao@nhyira', '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, 2),
(1, 'roberTT4F@', '63515811095', 'Roberta Ferreira', '1985-08-25', 'F', 'roberta@example.com', null, '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, null),
(1, 'pedR0G@', '47767654036', 'Pedro Gomes', '1978-06-17', 'M', 'pedro@example.com', null, '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, null),
(1, 'admin1Nhyir@', '29896637032', 'Poliana Micheline Militão', '1999-07-18', 'F', 'admin@example.com', 'padrao@nhyira', '$2a$10$Ix.qCm5U71fFzjkd2/z3T.gKtgr9NzUzpqVOqAXU8uAcvv3ftooWS', null, null);

-- Inserção de contrato para o usuário com id_usuario 2 e personal_id 3
INSERT INTO contrato (usuario_id, personal_id, afiliacao, inicio_contrato, fim_contrato) VALUES
(3, 2, 1, '2024-01-01', '2024-12-31');

INSERT INTO rotina_usuario (usuario_id, meta_id) VALUES
(1, 2),
(2, 1);

/* _______________________________________________________________________________ */
/* Sessão de especialidade */

INSERT INTO especialidade (nome) VALUES
('Emagrecimento'),
('Alta Intensidade (HIIT)'),
('Força e Resistência'),
('Flexibilidade e Mobilidade'),
('Resistência Cardiovascular'),
('Peso Corporal'),
('Alongamento e Relaxamento');

-- Atribuição de usuários personais a especialidades
INSERT INTO especialidade_por_personal (personal_id, especialidade_id, dt_formacao) VALUES
(4, 1, '2010-05-20'),  -- Marcos Silva Oliveira Pinto Santos é especializado em Emagrecimento desde 20 de maio de 2010
(4, 3, '2012-08-15'),  -- Marcos Silva Oliveira Pinto Santos é especializado em Resistência Cardiovascular desde 15 de agosto de 2012
(5, 2, '2015-03-10'),  -- Roberta Ferreira é especializada em Alta Intensidade (HIIT) desde 10 de março de 2015
(5, 4, '2017-06-25'),  -- Roberta Ferreira é especializada em Flexibilidade e Mobilidade desde 25 de junho de 2017
(6, 5, '2011-11-30'),  -- Pedro Gomes é especializado em Resistência Cardiovascular desde 30 de novembro de 2011
(6, 3, '2013-09-18');  -- Pedro Gomes é especializado em Força e Resistência desde 18 de setembro de 2013

-- Inserção de correspondências entre especialidades e metas
INSERT INTO especialidade_por_meta (especialidade_id, meta_id) VALUES
(1, 1),   -- Emagrecimento -> Emagrecimento
(2, 1),   -- Alta Intensidade (HIIT) -> Emagrecimento
(3, 2),   -- Força e Resistência -> Ganho de Massa Muscular
(4, 4),   -- Flexibilidade e Mobilidade -> Melhoria da Postura
(5, 3),   -- Resistência Cardiovascular -> Melhoria da Resistência Cardiovascular
(6, 6),   -- Peso Corporal -> Emagrecimento
(6, 2),   -- Peso Corporal -> Ganho de massa muscular
(7, 7);   -- Alongamento e Relaxamento -> Redução do Estresse

/* _______________________________________________________________________________ */
/* Sessão de treino */

INSERT INTO tag (nome) VALUES
('Peitoral'),
('Pernas'),
('Costas'),
('Ombros'),
('Braços'),
('Abdômen'),
('Glúteos'),
('Trapézio'),
('Deltoides'),
('Bíceps'),
('Tríceps'),
('Quadríceps'),
('Isquiotibiais'),
('Lombar'),
('Oblíquos');
    
INSERT INTO exercicio (midia_id, nome, descricao) VALUES
(NULL, 'Flexão de Braço', 'Exercício que trabalha os músculos peitorais, deltoides e tríceps.'),
(NULL, 'Agachamento Livre', 'Exercício para fortalecimento dos músculos das pernas e glúteos.'),
(NULL, 'Remada Alta', 'Exercício para o desenvolvimento dos músculos das costas e dos ombros.'),
(NULL, 'Abdominal Crunch', 'Exercício para fortalecimento dos músculos abdominais.'),
(NULL, 'Levantamento Terra', 'Exercício composto que trabalha vários grupos musculares, incluindo os glúteos, costas e pernas.'),
(NULL, 'Flexão Lateral do Tronco', 'Exercício para fortalecer os músculos oblíquos.'),
(NULL, 'Rosca Direta', 'Exercício para o desenvolvimento dos músculos dos braços, especialmente os bíceps.'),
(NULL, 'Elevação Frontal', 'Exercício para o desenvolvimento dos músculos dos ombros, principalmente o deltoide anterior.'),
(NULL, 'Prancha Abdominal', 'Exercício estático para fortalecer os músculos abdominais e lombares.'),
(NULL, 'Desenvolvimento de Ombros', 'Exercício para o desenvolvimento dos músculos dos ombros, especialmente o deltoide lateral.'),
(NULL, 'Leg Press', 'Exercício para fortalecimento dos músculos das pernas, especialmente quadríceps e glúteos.'),
(NULL, 'Crucifixo com Halteres', 'Exercício para o desenvolvimento dos músculos do peitoral, especialmente a porção esternal.'),
(NULL, 'Tríceps Pulley', 'Exercício para o desenvolvimento dos músculos tríceps braquial, situados na parte posterior do braço.'),
(NULL, 'Prancha Lateral', 'Exercício estático para fortalecer os músculos abdominais e oblíquos.'),
(NULL, 'Flexão de Pernas', 'Exercício para fortalecimento dos músculos isquiotibiais e glúteos.'),
(NULL, 'Puxada Frontal', 'Exercício para o desenvolvimento dos músculos das costas, especialmente os latíssimos do dorso.'),
(NULL, 'Elevação Lateral', 'Exercício para o desenvolvimento dos músculos dos ombros, principalmente o deltoide médio.'),
(NULL, 'Extensão de Tríceps', 'Exercício para o desenvolvimento dos músculos tríceps braquial, situados na parte posterior do braço.'),
(NULL, 'Prancha Superman', 'Exercício para fortalecer os músculos do core, lombar e glúteos.'),
(NULL, 'Flexão de Braço Inclinada', 'Variação da flexão de braço que trabalha mais intensamente os músculos do peitoral superior.');

-- Associações para o exercício 1 (Flexão de Braço)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(1, 1), -- Peitoral
(9, 1), -- Deltoides
(10, 1); -- Tríceps

-- Associações para o exercício 2 (Agachamento Livre)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(2, 2), -- Pernas
(7, 2); -- Glúteos

-- Associações para o exercício 3 (Remada Alta)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(3, 3), -- Costas
(9, 3); -- Deltoides

-- Associações para o exercício 4 (Abdominal Crunch)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(6, 4); -- Abdômen

-- Associações para o exercício 5 (Levantamento Terra)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(2, 5), -- Pernas
(3, 5), -- Costas
(7, 5); -- Glúteos

-- Associações para o exercício 6 (Flexão Lateral do Tronco)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(15, 6); -- Oblíquos

-- Associações para o exercício 7 (Rosca Direta)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(5, 7); -- Braços

-- Associações para o exercício 8 (Elevação Frontal)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(4, 8), -- Ombros
(9, 8); -- Deltoides

-- Associações para o exercício 9 (Prancha Abdominal)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(6, 9), -- Abdômen
(14, 9); -- Lombar

-- Associações para o exercício 10 (Desenvolvimento de Ombros)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(4, 10), -- Ombros
(9, 10); -- Deltoides

-- Associações para o exercício 11 (Leg Press)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(2, 11), -- Pernas
(12, 11); -- Quadríceps

-- Associações para o exercício 12 (Crucifixo com Halteres)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(1, 12); -- Peitoral

-- Associações para o exercício 13 (Tríceps Pulley)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(10, 13), -- Tríceps
(5, 13); -- Braços

-- Associações para o exercício 14 (Prancha Lateral)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(6, 14), -- Abdômen
(15, 14); -- Oblíquos

-- Associações para o exercício 15 (Flexão de Pernas)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(2, 15), -- Pernas
(13, 15); -- Isquiotibiais

-- Associações para o exercício 16 (Puxada Frontal)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(3, 16), -- Costas
(9, 16); -- Deltoides

-- Associações para o exercício 17 (Elevação Lateral)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(4, 17), -- Ombros
(9, 17); -- Deltoides

-- Associações para o exercício 18 (Extensão de Tríceps)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(10, 18), -- Tríceps
(5, 18); -- Braços

-- Associações para o exercício 19 (Prancha Superman)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(6, 19), -- Abdômen
(14, 19); -- Lombar

-- Associações para o exercício 20 (Flexão de Braço Inclinada)
INSERT INTO tag_exercicio (tag_id, exercicio_id) VALUES
(1, 20), -- Peitoral
(9, 20); -- Deltoides

INSERT INTO rotina_mensal (rotina_usuario_id, mes, ano, concluido) VALUES
(1, 5, 2024, 0),
(2, 5, 2024, 0);

-- Para o mes de MAIO de 2024, tem 5 semanas, logo insert de 5 semanas para cada rotina
INSERT INTO rotina_semanal (rotina_mensal_id, concluido) VALUES
(1, 0),
(1, 0),
(1, 0),
(1, 0),
(1, 0),

(2, 0),
(2, 0),
(2, 0),
(2, 0),
(2, 0);

-- Inserts para a primeira semana de cada rotina mensal
INSERT INTO rotina_diaria (rotina_semanal_id, dia, concluido) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 3, 0),
(1, 4, 0),
(1, 5, 0),

(2, 1, 0),
(2, 2, 0),
(2, 3, 0),
(2, 4, 0),
(2, 5, 0),

(3, 1, 0),
(3, 2, 0),
(3, 3, 0),
(3, 4, 0),
(3, 5, 0),

(6, 1, 0),
(6, 2, 0),
(6, 3, 0),
(6, 4, 0),
(6, 5, 0),

(7, 1, 0),
(7, 2, 0),
(7, 3, 0),
(7, 4, 0),
(7, 5, 0),

(8, 1, 0),
(8, 2, 0),
(8, 3, 0),
(8, 4, 0),
(8, 5, 0);

-- Inserts para a segunda semana de cada rotina mensal
INSERT INTO treino (exercicio_id, rotina_diaria_id, concluido, repeticao, serie, tempo)
VALUES 
(1, 1, 0, 15, 3, '00:01:00'),
(2, 1, 0, 12, 3, '00:02:00'),
(3, 1, 0, 10, 3, '00:01:30'),
(4, 1, 0, 20, 3, '00:01:00'),
(5, 1, 0, 8, 3, '00:02:00'),
(6, 1, 0, 15, 3, '00:01:30'),
(7, 1, 0, 12, 3, '00:01:00'),

(1, 2, 0, 15, 3, '00:01:00'),
(2, 2, 0, 12, 3, '00:02:00'),
(3, 2, 0, 10, 3, '00:01:30'),
(4, 2, 0, 20, 3, '00:01:00'),
(5, 2, 0, 8, 3, '00:02:00'),
(6, 2, 0, 15, 3, '00:01:30'),
(7, 2, 0, 12, 3, '00:01:00'),

(1, 3, 0, 15, 3, '00:01:00'),
(2, 3, 0, 12, 3, '00:02:00'),
(3, 3, 0, 10, 3, '00:01:30'),
(4, 3, 0, 20, 3, '00:01:00'),
(5, 3, 0, 8, 3, '00:02:00'),
(6, 3, 0, 15, 3, '00:01:30'),
(7, 3, 0, 12, 3, '00:01:00'),
--
--
--
--
(5, 16, 0, 8, 3, '00:02:00'),
(2, 16, 0, 12, 3, '00:02:00'),
(10, 16, 0, 10, 3, '00:01:30'),
(7, 16, 0, 12, 3, '00:01:00'),
(16, 16, 0, 10, 3, '00:01:30'),

(5, 17, 0, 8, 3, '00:02:00'),
(2, 17, 0, 12, 3, '00:02:00'),
(10, 17, 0, 10, 3, '00:01:30'),
(7, 17, 0, 12, 3, '00:01:00'),
(16, 17, 0, 10, 3, '00:01:30'),

(5, 18, 0, 8, 3, '00:02:00'),
(2, 18, 0, 12, 3, '00:02:00'),
(10, 18, 0, 10, 3, '00:01:30'),
(7, 18, 0, 12, 3, '00:01:00'),
(16, 18, 0, 10, 3, '00:01:30');

/* _______________________________________________________________________________ */
/* Sessão de dieta */

INSERT INTO metrica (metrica) VALUES
('gramas'),
('quilogramas'),
('miligramas'),
('litros'),
('mililitros'),
('unidade'),
('xícaras'),
('colheres de sopa'),
('colheres de chá');

-- Inserção de refeições
INSERT INTO refeicao (midia_id, nome, preparo) VALUES
(NULL, 'Virada Paulista', 'Refeição típica da culinária paulista, composta por arroz, feijão, carne de porco, linguiça, couve refogada, torresmo, ovo frito e farofa.'),
(NULL, 'Salada de Frango Grelhado', 'Refeição leve e saudável, composta por salada de folhas verdes, peito de frango grelhado, legumes grelhados e iogurte natural desnatado.'),
(NULL, 'Salmão com Quinoa', 'Refeição nutritiva e pouco calórica, composta por salmão assado, quinoa cozida, abacate e omelete de claras.'),
(NULL, 'Frango e batata doce', 'Refeição calórica e rica em proteínas para estimular o crescimento muscular, incluindo frango assado, batata doce assada, arroz branco e feijão preto.'),
(NULL, 'Carne com aveia de flocos', 'Refeição balanceada com carboidratos e proteínas para fornecer energia e promover o ganho de massa muscular, incluindo carne vermelha grelhada, aveia em flocos, ovo cozido e amendoim.');

-- Inserção de alimentos da virada paulista
INSERT INTO alimento (midia_id, nome, carboidrato, proteina, gordura) VALUES
(NULL, 'Arroz Branco', 45.0, 4.0, 0.5),
(NULL, 'Feijão Carioca', 30.0, 7.0, 1.5),
(NULL, 'Carne de Porco', 0.0, 20.0, 5.0),
(NULL, 'Linguiça', 1.0, 18.0, 10.0),
(NULL, 'Couve', 5.0, 2.0, 0.5),
(NULL, 'Torresmo', 2.0, 5.0, 10.0),
(NULL, 'Ovo', 1.0, 7.0, 5.0),						-- Vai ser usado também na refeição Carne com aveia de flocos"
(NULL, 'Farofa', 20.0, 2.0, 10.0);

-- Inserção de alimentos da Salada de Frango Grelhado
INSERT INTO alimento (midia_id, nome, carboidrato, proteina, gordura) VALUES
(NULL, 'Salada de Folhas Verdes', 2.0, 1.0, 0.2),
(NULL, 'Frango', 0.0, 30.0, 3.5),					-- Vai ser usado também na refeição "Frango e batata doce"
(NULL, 'Legumes', 10.0, 2.0, 0.5),
(NULL, 'Iogurte Natural', 4.0, 8.0, 0.2);

-- Inserção de alimentos de Salmão com Quinoa
INSERT INTO alimento (midia_id, nome, carboidrato, proteina, gordura) VALUES
(NULL, 'Salmão Assado', 0.0, 25.0, 12.0),
(NULL, 'Quinoa Cozida', 20.0, 4.0, 1.5),
(NULL, 'Abacate', 1.0, 2.0, 14.0),
(NULL, 'Omelete de Claras', 1.0, 15.0, 3.0);

-- Inserção de alimentos de Frango e batata doce
INSERT INTO alimento (midia_id, nome, carboidrato, proteina, gordura) VALUES
(NULL, 'Batata Doce', 30.0, 2.0, 0.5),
(NULL, 'Feijão Preto', 30.0, 7.0, 1.5);

-- Inserção de alimentos de Carne com aveia de flocos
INSERT INTO alimento (midia_id, nome, carboidrato, proteina, gordura) VALUES
(NULL, 'Carne de vaca', 0.0, 25.0, 10.0),
(NULL, 'Aveia em Flocos', 66.0, 16.9, 7.0),
(NULL, 'Amendoim', 16.0, 26.0, 49.0);

-- Inserção de alimentos por refeição
INSERT INTO alimento_por_refeicao (refeicao_id, alimento_id, metrica_id, qtd_alimento) VALUES
(1, 1, 6, 1),    -- Virada Paulista: Arroz Branco - 1 unidade
(1, 2, 6, 1),    -- Virada Paulista: Feijão Carioca - 1 unidade
(1, 3, 1, 150),  -- Virada Paulista: Carne de Porco - 150 gramas
(1, 4, 6, 1),    -- Virada Paulista: Linguiça - 1 unidade
(1, 5, 1, 100),  -- Virada Paulista: Couve - 100 gramas
(1, 6, 1, 100),  -- Virada Paulista: Torresmo - 100 gramas
(1, 7, 6, 1),    -- Virada Paulista: Ovo - 1 unidade
(1, 8, 1, 50),   -- Virada Paulista: Farofa - 50 gramas

(2, 9, 1, 100),  -- Salada de Frango Grelhado: Salada de Folhas Verdes - 100 gramas
(2, 10, 1, 150), -- Salada de Frango Grelhado: Frango - 150 gramas
(2, 11, 1, 100), -- Salada de Frango Grelhado: Legumes - 100 gramas
(2, 12, 1, 150), -- Salada de Frango Grelhado: Iogurte Natural - 150 gramas

(3, 13, 1, 150), -- Salmão com Quinoa: Salmão Assado - 150 gramas
(3, 14, 1, 100), -- Salmão com Quinoa: Quinoa Cozida - 100 gramas
(3, 15, 6, 1),   -- Salmão com Quinoa: Abacate - 1 unidade
(3, 16, 6, 1),   -- Salmão com Quinoa: Omelete de Claras - 1 unidade

(4, 10, 1, 200), -- Frango e batata doce: Frango - 200 gramas
(4, 17, 1, 200), -- Frango e batata doce: Batata Doce - 200 gramas
(4, 2, 6, 1),    -- Frango e batata doce: Feijão Preto - 1 unidade

(5, 18, 1, 200), -- Carne com aveia de flocos: Carne de vaca - 200 gramas
(5, 7, 1, 50),   -- Carne com aveia de flocos: Aveia em Flocos - 50 gramas
(5, 8, 1, 30);   -- Carne com aveia de flocos: Amendoim - 30 gramas

-- Inserts para refeicao_diaria
INSERT INTO refeicao_diaria (rotina_diaria_id, refeicao_id, concluido) VALUES
-- Associando refeições para a rotina_diaria_id 1
(1, 1, 0),  -- Virada Paulista
(1, 2, 0),  -- Salada de Frango Grelhado
(1, 3, 0),  -- Salmão com Quinoa

-- Associando refeições para a rotina_diaria_id 2
(2, 1, 0),  -- Virada Paulista
(2, 2, 0),  -- Salada de Frango Grelhado
(2, 4, 0),  -- Frango e Batata Doce

-- Associando refeições para a rotina_diaria_id 3
(3, 1, 0),  -- Virada Paulista
(3, 2, 0),  -- Salada de Frango Grelhado
(3, 5, 0),  -- Carne com Aveia de Flocos

-- Associando refeições para a rotina_diaria_id 16
(16, 1, 0),  -- Virada Paulista
(16, 3, 0),  -- Salmão com Quinoa
(16, 4, 0),  -- Frango e Batata Doce

-- Associando refeições para a rotina_diaria_id 17
(17, 2, 0),  -- Salada de Frango Grelhado
(17, 3, 0),  -- Salmão com Quinoa
(17, 5, 0),  -- Carne com Aveia de Flocos

-- Associando refeições para a rotina_diaria_id 18
(18, 1, 0),  -- Virada Paulista
(18, 4, 0),  -- Frango e Batata Doce
(18, 5, 0);  -- Carne com Aveia de Flocos

select * from usuario;