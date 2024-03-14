CREATE DATABASE bancointelliMetrics;

USE bancointelliMetrics;

DROP DATABASE bancointelliMetrics;

CREATE TABLE usuarios(
	pk_idUsuario int PRIMARY KEY AUTO_inCREMENT,
    nome varchar(60) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    senha varchar(10) NOT NULL DEFAULT "Suiclab123",
    cargo enum("gestor", "tecnico") NOT NULL
);

CREATE TABLE clientes(
	pk_idCliente int PRIMARY KEY AUTO_inCREMENT,
    nomeEmpresa varchar(60) NOT NULL,
    representante varchar(60) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    telefone varchar(11) NOT NULL UNIQUE,
    endereco varchar(100) NOT NULL,
    cnpj char(14) NOT NULL UNIQUE
);

CREATE TABLE ordensCalibracao(
	pk_idOsCalibracao int PRIMARY KEY,
    fk_idCliente int NOT NULL,
    fk_idUsuario int NOT NULL,
    titulo varchar(30) NOT NULL,
    descricao varchar(150),
    datainicio date NOT NULL,
    dataTermino date NOT NULL,
    contratante varchar(60) NOT NULL,
	email varchar(60) NOT NULL,
    telefne varchar(11) NOT NULL,
    
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente),
    FOREIGN KEY(fk_idUsuario) REFERENCES usuarios(pk_idUsuario)
);

CREATE TABLE instrumentosRecebidos(
	pk_idinstrumentoRecebido int PRIMARY KEY AUTO_inCREMENT,
    fk_idOsCalibracao int NOT NULL,
    setor varchar(30) NOT NULL,
    nProposta int NOT NULL,
    nNotaFiscal int NOT NULL,
    dataDeRecebimento date NOT NULL,
    
    FOREIGN KEY(fk_idOsCalibracao) REFERENCES ordensCalibracao(pk_idOsCalibracao)
);

CREATE TABLE categorias(
	pk_idCategoria int PRIMARY KEY AUTO_inCREMENT,
    nome varchar(30) NOT NULL
);

CREATE TABLE tipos(
	pk_idTipo int PRIMARY KEY AUTO_inCREMENT,
    fk_idCategoria int NOT NULL,
    nome varchar(30) NOT NULL,
    
    FOREIGN KEY(fk_idCategoria) REFERENCES categorias(pk_idCategoria)
);

CREATE TABLE instrumentos(
	pk_idinstrumento int PRIMARY KEY AUTO_inCREMENT,
    fk_idCliente int NOT NULL,
    fk_idOsCalibracao int NOT NULL,
    fk_idTipo int NOT NULL,
    nSerie int NOT NULL,
    fabricante varchar(60) NOT NULL,
    resolucao int NOT NULL,
    unidadeMedida enum("mm", "cm", "pol") NOT NULL,
    faixaNominal varchar(30) NOT NULL,
    
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente),
    FOREIGN KEY(fk_idOsCalibracao) REFERENCES ordensCalibracao(pk_idOsCalibracao),
    FOREIGN KEY(fk_idTipo) REFERENCES tipos(pk_idTipo)
);

-- CREATE TABLE certificados();

CREATE TABLE ordensMedicao(
	pk_idOSMedicao int PRIMARY KEY NOT NULL,
    fk_idCliente int NOT NULL,
    fk_idUsuario int NOT NULL,
    titulo varchar(50) NOT NULL,
    datainicio varchar(20) NOT NULL,
    dataTermino varchar(20) NOT NULL,
    descricao varchar(100) NOT NULL,
    contratante varchar(100) NOT NULL,
    email varchar(50) NOT NULL,
    telefone varchar(15) NOT NULL,
    
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente),
    FOREIGN KEY(fk_idUsuario) REFERENCES usuarios(pk_idUsuario)
    
);

CREATE TABLE pecas(
	pk_idPeca int PRIMARY KEY,
    fk_idOsMedicao int NOT NULL,
    fk_idCliente int NOT NULL,
	nome varchar(50) NOT NULL,
    material varchar(50) NOT NULL,
    nDesenho int NOT NULL,
    
    FOREIGN KEY (fk_idOsMedicao) REFERENCES	ordensMedicao(pk_idOsMedicao),
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente)
);

CREATE TABLE pecasRecebidas(
	pk_idRecebimento int PRIMARY KEY,
	fk_idOsMedicao int NOT NULL,
    setor varchar(50) NOT NULL,
    nProposta int NOT NULL,
    nNotaFiscal int NOT NULL,
    dia DATE NOT NULL,
    
    FOREIGN KEY (fk_idOsMedicao) REFERENCES	ordensMedicao(pk_idOsMedicao)
);

CREATE TABLE relatorio(
	pk_idRelatorio int PRIMARY KEY,
    fk_idOsMedicao int NOT NULL,
    fk_idInstrumento int NOT NULL,
    inicio varchar(20) NOT NULL,
    termino varchar(20) NOT NULL,
    temperaturaC varchar(20) NOT NULL,
    umidadeRelativa varchar(20) NOT NULL,
    notasMedicao varchar(20) NOT NULL,
    dia DATE NOT NULL,
    
    FOREIGN KEY (fk_idOsMedicao) REFERENCES	ordensMedicao(pk_idOsMedicao),
    FOREIGN KEY (fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento)
);

-- FOREIGN KEY() REFERENCES ()