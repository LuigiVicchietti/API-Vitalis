IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'vitalisDB')
BEGIN
    CREATE DATABASE vitalisDB;
END
GO

USE vitalisDB;
GO

CREATE TABLE midia (
    id_midia INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100) NOT NULL,
    caminho VARCHAR(500) NOT NULL,
    extensao VARCHAR(10) NOT NULL
);
GO

CREATE TABLE meta (
    id_meta INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100)
);
GO

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY IDENTITY,
    tipo TINYINT NOT NULL, 
    nickname VARCHAR(20) NOT NULL,
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(200) NOT NULL,
    dt_nasc DATE NOT NULL,
    sexo CHAR(3),
    email VARCHAR(100) NOT NULL,
    email_recuperacao VARCHAR(100),
    senha VARCHAR(100) NOT NULL,
    midia_id INT,
    personal_id INT,
    FOREIGN KEY (midia_id) REFERENCES midia(id_midia),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE contrato (
    id_contrato INT IDENTITY,
    usuario_id INT,
    personal_id INT,
    afiliacao TINYINT NOT NULL CHECK (afiliacao IN (0, 1, 2)),
    inicio_contrato DATE,
    fim_contrato DATE,
    PRIMARY KEY (id_contrato, usuario_id, personal_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY IDENTITY,
    personal_id INT,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    complemento VARCHAR(100),
    cep CHAR(8),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE chat (
    id_chat INT IDENTITY,
    usuario_id INT,
    personal_id INT,
    ativo TINYINT,
    PRIMARY KEY (id_chat),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE mensagem (
    id_mensagem INT PRIMARY KEY IDENTITY,
    chat_id INT,
    remetente_id INT,
    destinatario_id INT,
    assunto VARCHAR(255),
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (chat_id) REFERENCES chat(id_chat),
    FOREIGN KEY (remetente_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (destinatario_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE especialidade (
    id_especialidade INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100) NOT NULL
);
GO

CREATE TABLE especialidade_por_personal (
    id_especialidade_personal INT IDENTITY,
    personal_id INT,
    especialidade_id INT,
    dt_formacao DATE NOT NULL,
    PRIMARY KEY (id_especialidade_personal, personal_id, especialidade_id),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id_especialidade)
);
GO

CREATE TABLE especialidade_por_meta (
    id_especialidade_meta INT IDENTITY,
    especialidade_id INT,
    meta_id INT,
    PRIMARY KEY (id_especialidade_meta, especialidade_id, meta_id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id_especialidade),
    FOREIGN KEY (meta_id) REFERENCES meta(id_meta)
);
GO

CREATE TABLE tag (
    id_tag INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100) NOT NULL
);
GO

CREATE TABLE exercicio (
    id_exercicio INT PRIMARY KEY IDENTITY,
    midia_id INT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(250),
    FOREIGN KEY (midia_id) REFERENCES midia(id_midia)
);
GO

CREATE TABLE tag_exercicio (
    id_tag_exercicio INT IDENTITY,
    tag_id INT,
    exercicio_id INT,
    PRIMARY KEY (id_tag_exercicio, tag_id, exercicio_id),
    FOREIGN KEY (tag_id) REFERENCES tag(id_tag),
    FOREIGN KEY (exercicio_id) REFERENCES exercicio(id_exercicio)
);
GO

CREATE TABLE rotina_usuario (
    id_rotina_usuario INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    meta_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (meta_id) REFERENCES meta(id_meta)
);
GO

CREATE TABLE rotina_mensal (
    id_rotina_mensal INT PRIMARY KEY IDENTITY,
    rotina_usuario_id INT,
	mes INT CHECK (mes IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)),
    ano INT,
    concluido TINYINT,
    FOREIGN KEY (rotina_usuario_id) REFERENCES rotina_usuario(id_rotina_usuario)
);
GO

CREATE TABLE rotina_semanal (
    id_rotina_semanal INT PRIMARY KEY IDENTITY,
    rotina_mensal_id INT,
    concluido TINYINT,
    FOREIGN KEY (rotina_mensal_id) REFERENCES rotina_mensal(id_rotina_mensal)
);
GO

CREATE TABLE rotina_diaria (
    id_rotina_diaria INT PRIMARY KEY IDENTITY,
    rotina_semanal_id INT,
	dia INT CHECK (dia IN (1, 2, 3, 4, 5, 6, 7)),
    concluido TINYINT,
    FOREIGN KEY (rotina_semanal_id) REFERENCES rotina_semanal(id_rotina_semanal)
);
GO

CREATE TABLE treino (
    id_treino INT PRIMARY KEY IDENTITY,
    exercicio_id INT,
    rotina_diaria_id INT,
    concluido TINYINT,
    repeticao INT NOT NULL,
    serie INT NOT NULL,
    tempo TIME NOT NULL,
    FOREIGN KEY (exercicio_id) REFERENCES exercicio(id_exercicio),
    FOREIGN KEY (rotina_diaria_id) REFERENCES rotina_diaria(id_rotina_diaria)
);
GO

CREATE TABLE dieta (
    id_dieta INT PRIMARY KEY IDENTITY,
    meta_id INT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    FOREIGN KEY (meta_id) REFERENCES meta(id_meta)
);
GO

CREATE TABLE refeicao (
    id_refeicao INT PRIMARY KEY IDENTITY,
    midia_id INT,
    nome VARCHAR(100) NOT NULL,
    preparo VARCHAR(250),
    FOREIGN KEY (midia_id) REFERENCES midia(id_midia)
);
GO

CREATE TABLE refeicao_diaria (
    id_refeicao_diaria INT PRIMARY KEY IDENTITY,
    refeicao_id INT,
    rotina_diaria_id INT,
    concluido TINYINT,
    FOREIGN KEY (refeicao_id) REFERENCES refeicao(id_refeicao),
    FOREIGN KEY (rotina_diaria_id) REFERENCES rotina_diaria(id_rotina_diaria)
);
GO

CREATE TABLE refeicao_por_dieta (
    id_refeicao_dieta INT PRIMARY KEY IDENTITY,
    refeicao_id INT,
    dieta_id INT,
    FOREIGN KEY (refeicao_id) REFERENCES refeicao(id_refeicao),
    FOREIGN KEY (dieta_id) REFERENCES dieta(id_dieta)
);
GO

CREATE TABLE alimento (
    id_alimento INT PRIMARY KEY IDENTITY,
    midia_id INT,
    nome VARCHAR(100) NOT NULL,
    carboidrato FLOAT NOT NULL,
    proteina FLOAT NOT NULL,
    gordura FLOAT NOT NULL,
    FOREIGN KEY (midia_id) REFERENCES midia(id_midia)
);
GO

CREATE TABLE metrica (
    id_metrica INT PRIMARY KEY IDENTITY,
    metrica VARCHAR(100)
);
GO

CREATE TABLE alimento_por_refeicao (
    id_alimento_refeicao INT PRIMARY KEY IDENTITY,
    refeicao_id INT,
    alimento_id INT,
    metrica_id INT,
    qtdAlimento INT NOT NULL,
    FOREIGN KEY (refeicao_id) REFERENCES refeicao(id_refeicao),
    FOREIGN KEY (alimento_id) REFERENCES alimento(id_alimento),
    FOREIGN KEY (metrica_id) REFERENCES metrica(id_metrica)
);
GO

CREATE TABLE assinatura (
    id_assinatura INT PRIMARY KEY IDENTITY,
    nome VARCHAR(100) NOT NULL,
    valor FLOAT NOT NULL
);
GO

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    assinatura_id INT,
    data_pagamento DATE NOT NULL,
    tipo VARCHAR(100) CHECK (tipo IN ('Cart�o de d�bito', 'Cart�o de cr�dito', 'PIX')) NOT NULL, 
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (assinatura_id) REFERENCES assinatura(id_assinatura)
);
GO

CREATE TABLE denuncia (
    id_denuncia INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    personal_id INT,
    motivo VARCHAR(255) NOT NULL,
    data_denuncia DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE ficha (
    id_ficha INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    rotina_usuario_id INT,
    peso FLOAT,
    altura FLOAT,
	problemas_caridiacos TINYINT,
	dor_peito_atividade TINYINT,
	dor_peito_ultimo_mes TINYINT,
	problema_osseo_articular TINYINT,
	medicamento_pressao_coracao TINYINT,
	impedimento_atividade TINYINT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (rotina_usuario_id) REFERENCES rotina_usuario(id_rotina_usuario)
);
GO

CREATE TABLE mural (
    id_mural INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    personal_id INT,
    titulo VARCHAR(255) NOT NULL,
    conteudo VARCHAR(1000) NOT NULL,
    data_postagem DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE lembrete (
    id_lembrete INT PRIMARY KEY IDENTITY,
    usuario_id INT,
    personal_id INT,
    descricao VARCHAR(1000) NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (personal_id) REFERENCES usuario(id_usuario)
);
GO