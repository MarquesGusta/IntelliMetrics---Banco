CREATE DATABASE bancointelliMetrics;

USE bancointelliMetrics;

DROP DATABASE bancointelliMetrics;

CREATE TABLE usuarios(
	pk_idUsuario int PRIMARY KEY AUTO_inCREMENT,
    nome varchar(60) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    senha varchar(10) NOT NULL DEFAULT "Suiclab123",
    cargo enum("gestor", "tecnico") NOT NULL,
    status enum("ativo", "inativo") NOT NULL DEFAULT "ativo"
);

CREATE TABLE clientes(
	pk_idCliente int PRIMARY KEY AUTO_inCREMENT,
    nomeEmpresa varchar(60) NOT NULL,
    representante varchar(60) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    telefone varchar(11) NOT NULL UNIQUE,
    endereco varchar(100) NOT NULL,
    cnpj char(14) NOT NULL UNIQUE,
    status enum("ativo", "inativo") NOT NULL DEFAULT "ativo"
);

CREATE TABLE ordensCalibracao(
	pk_idOsCalibracao int PRIMARY KEY,
    fk_idCliente int NOT NULL,
    fk_idUsuario int NOT NULL,
    titulo varchar(30) NOT NULL,
    descricao varchar(150),
    dataInicio date NOT NULL,
    dataTermino date NOT NULL,
    contratante varchar(60) NOT NULL,
	email varchar(60) NOT NULL,
    telefone varchar(11) NOT NULL,
    status enum("em espera", "concluida") NOT NULL DEFAULT "em espera",
    
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
    nome varchar(30) NOT NULL UNIQUE
);

CREATE TABLE tipos(
	pk_idTipo int PRIMARY KEY AUTO_inCREMENT,
    fk_idCategoria int NOT NULL,
    nome varchar(30) NOT NULL UNIQUE,
    
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

CREATE TABLE planeza(
	pk_idPlaneza int PRIMARY KEY AUTO_INCREMENT,
    cMovel decimal(3,2) NOT NULL,
    cFixo decimal(3,2) NOT NULL
);

CREATE TABLE paralelismoMicro(
	pk_idParalelismoMicro int PRIMARY KEY AUTO_INCREMENT,
    valorNominal decimal(3,2) NOT NULL,
    cMovelcFixo decimal(3,2) NOT NULL
);

CREATE TABLE controleDimensional(
	pk_idControle int PRIMARY KEY AUTO_INCREMENT,
    vp0_0 decimal(3,2) NOT NULL,
    vp2_5 decimal(3,2) NOT NULL,
    vp5_1 decimal(3,2) NOT NULL,
    vp7_7 decimal(3,2) NOT NULL,
    vp10_3 decimal(3,2) NOT NULL,
    vp12_9 decimal(3,2) NOT NULL,
    vp15_0 decimal(3,2) NOT NULL,
    vp17_6 decimal(3,2) NOT NULL,
    vp20_2 decimal(3,2) NOT NULL
);

CREATE TABLE resultadosMicrometros(
	pk_idNrCertificado int PRIMARY KEY,
    fk_idControle int NOT NULL,
    fk_idPlaneza int NOT NULL,
    fk_idParalelismoMicro int NOT NULL,
    fk_idInstrumento int NOT NULL,
    responsável varchar(60) NOT NULL,
    tecnico varchar(60) NOT NULL,
    dataCalibracao date NOT NULL,
    inspecao enum("ok", "nok") NOT NULL,
    tipoEscala enum("analogico", "digital") NOT NULL,
    versaoMetodo int NOT NULL,
    tempInicial int NOT NULL,
    tempFinal int NOT NULL,
    
    FOREIGN KEY(fk_idControle) REFERENCES controleDimensional(pk_idControle),
    FOREIGN KEY(fk_idPlaneza) REFERENCES planeza(pk_idPlaneza),
    FOREIGN KEY(fk_idParalelismoMicro) REFERENCES paralelismoMicro(pk_idParalelismoMicro),
    FOREIGN KEY(fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento)
);

CREATE TABLE medicoesinternas(
	pk_idMedicaointerna	int PRIMARY KEY AUTO_INCREMENT,
    vn1	decimal(3,2) NOT NULL,
    vn2	decimal(3,2) NOT NULL,
    vn3	decimal(3,2) NOT NULL
);

CREATE TABLE medicoesRessaltos(
	pk_idMedicaoRessalto int PRIMARY KEY AUTO_INCREMENT,
	vn1	decimal(3,2) NOT NULL,
    vn2	decimal(3,2) NOT NULL,
    vn3	decimal(3,2) NOT NULL

);

CREATE TABLE medicoesProfundidades(
	pk_idMedicaoProfundidade int PRIMARY KEY AUTO_INCREMENT,
	vn1	decimal(3,2) NOT NULL,
    vn2	decimal(3,2) NOT NULL,
    vn3	decimal(3,2) NOT NULL
);

CREATE TABLE paralelismoPaq(
	pk_idParelelismo int PRIMARY KEY AUTO_INCREMENT,
    valorNominalOrelha	decimal(3,2) NOT NULL,
    valorProxOrelha decimal(3,2) NOT NULL,
    valorAfasOrelha decimal(3,2) NOT NULL,
    valorNominalBico decimal(3,2) NOT NULL,
    valorProxBico decimal(3,2) NOT NULL,
    valorAfasBico decimal(3,2) NOT NULL
);

CREATE TABLE medicoesExternas(
	pk_idMedicaoExterna	int PRIMARY KEY AUTO_INCREMENT,
    vn0_0 decimal(3,2) NOT NULL,
    vn1_3 decimal(3,2) NOT NULL,
    vn1_4 decimal(3,2) NOT NULL,
    vn20_0 decimal(3,2) NOT NULL,
    vn50_0 decimal(3,2) NULL,
    vn100_0 decimal(3,2) NOT NULL,
    vn150_0 decimal(3,2) NOT NULL,
    vnExtra1 decimal(3,2),
    vnExtra2 decimal(3,2),
    vnExtra3 decimal(3,2)
);

CREATE TABLE resultadosPaquimetros(
	pk_idNrCertificado int PRIMARY KEY,
    fk_idInstrumento int NOT NULL,
    fk_idParalelismo int NOT NULL,
	fk_idMedicaoExterna int NOT NULL,
    fk_idMedicaointerna int NOT NULL,
    fk_idMedicaoRessalto int NOT NULL,
    fk_idMedicaoProfundidade int NOT NULL,
    inspecao int NOT NULL,
    tipoEscala	enum("digital","analogico") NOT NULL,
    versapoMetodo int NOT NULL,
    tempInicial	decimal(3,2) NOT NULL,
    tempFinal decimal(3,2) NOT NULL,
    responsavel varchar(50) NOT NULL,
    tecnico varchar(50) NOT NULL,
    
    FOREIGN KEY (fk_idInstrumento) REFERENCES instrumentos(pk_idinstrumento),
    FOREIGN KEY (fk_idParalelismo) REFERENCES paralelismoPaq(pk_idParelelismo),
    FOREIGN KEY (fk_idMedicaoExterna) REFERENCES medicoesExternas(pk_idMedicaoExterna),
    FOREIGN KEY (fk_idMedicaointerna) REFERENCES medicoesinternas(pk_idMedicaointerna),
    FOREIGN KEY (fk_idMedicaoRessalto) REFERENCES medicoesRessaltos(pk_idMedicaoRessalto),
    FOREIGN KEY (fk_idMedicaoProfundidade) REFERENCES medicoesProfundidades(pk_idMedicaoProfundidade)
    
);

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
    status enum("em espera", "concluida") NOT NULL DEFAULT "em espera",
    
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