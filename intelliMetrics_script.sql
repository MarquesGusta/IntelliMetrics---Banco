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

CREATE TABLE ordensServico(
	pk_idOs int PRIMARY KEY,
    fk_idCliente int NOT NULL,
    fk_idUsuario int NOT NULL,
    titulo varchar(30) NOT NULL,
    tipo enum("calibracao", "medicao") NOT NULL,
    descricao varchar(300),
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
    fk_idOs int NOT NULL,
    fk_idUsuario int NOT NULL,
    setor varchar(30) NOT NULL,
    nProposta int NOT NULL,
    nNotaFiscal int NOT NULL,
    dataDeRecebimento date NOT NULL,
    recebidoNaPrevisao enum("sim", "nao") NOT NULL,
    previsaoInicio date,
    previsaoTermino date,
    clienteConcorda enum("sim", "nao") NOT NULL,
    dataAssinatura date NOT NULL,
    
    FOREIGN KEY(fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idUsuario) REFERENCES usuarios(pk_idUsuario)
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
    fk_idOs int NOT NULL,
    fk_idTipo int NOT NULL,
    nSerie int NOT NULL,
    identificacaoCliente varchar(50) NOT NULL,
    fabricante varchar(60) NOT NULL,
    faixaNominalNum decimal(3,2) NOT NULL,
    faixaNominalUni enum("mm", "pol") NOT NULL,
    faixaCalibradaNum decimal(3,2) NOT NULL,
    faixaCalibradaUni enum("mm", "pol") NOT NULL,
    divisaoResolucaoNum decimal(3,2) NOT NULL,
    divisaoResolucaoUni enum("mm", "pol") NOT NULL,
    
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente),
    FOREIGN KEY(fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idTipo) REFERENCES tipos(pk_idTipo)
);

CREATE TABLE planeza(
	pk_idPlaneza int PRIMARY KEY AUTO_INCREMENT,
    cMovel1 decimal(6,3) NOT NULL,
    cMovel2 decimal(6,3) NOT NULL,
    cMovel3 decimal(6,3) NOT NULL,
    cFixo1 decimal(6,3) NOT NULL,
    cFixo2 decimal(6,3) NOT NULL,
    cFixo3 decimal(6,3) NOT NULL
);

CREATE TABLE paralelismoMicro(
	pk_idParalelismoMicro int PRIMARY KEY AUTO_INCREMENT,
    valorNominal1 decimal(6,3) NOT NULL,
    valorNominal2 decimal(6,3) NOT NULL,
    valorNominal3 decimal(6,3) NOT NULL,
    valorNominal4 decimal(6,3) NOT NULL,
    cMovelcFixo1 decimal(6,3) NOT NULL,
    cMovelcFixo2 decimal(6,3) NOT NULL,
    cMovelcFixo3 decimal(6,3) NOT NULL,
    cMovelcFixo4 decimal(6,3) NOT NULL,
    cMovelcFixo5 decimal(6,3) NOT NULL
);

CREATE TABLE controleDimensional(
	pk_idControle int PRIMARY KEY AUTO_INCREMENT,
    vp0_0_1 decimal(6,3) NOT NULL,
    vp0_0_2 decimal(6,3) NOT NULL,
    vp0_0_3 decimal(6,3) NOT NULL,
    vp2_5_1 decimal(6,3) NOT NULL,
    vp2_5_2 decimal(6,3) NOT NULL,
    vp2_5_3 decimal(6,3) NOT NULL,
    vp5_1_1 decimal(6,3) NOT NULL,
    vp5_1_2 decimal(6,3) NOT NULL,
    vp5_1_3 decimal(6,3) NOT NULL,
    vp7_7_1 decimal(6,3) NOT NULL,
    vp7_7_2 decimal(6,3) NOT NULL,
    vp7_7_3 decimal(6,3) NOT NULL,
    vp10_3_1 decimal(6,3) NOT NULL,
    vp10_3_2 decimal(6,3) NOT NULL,
    vp10_3_3 decimal(6,3) NOT NULL,
    vp12_9_1 decimal(6,3) NOT NULL,
    vp12_9_2 decimal(6,3) NOT NULL,
    vp12_9_3 decimal(6,3) NOT NULL,
    vp15_0_1 decimal(6,3) NOT NULL,
    vp15_0_2 decimal(6,3) NOT NULL,
    vp15_0_3 decimal(6,3) NOT NULL,
    vp17_6_1 decimal(6,3) NOT NULL,
    vp17_6_2 decimal(6,3) NOT NULL,
    vp17_6_3 decimal(6,3) NOT NULL,
    vp20_2_1 decimal(6,3) NOT NULL,
    vp20_2_2 decimal(6,3) NOT NULL,
    vp20_2_3 decimal(6,3) NOT NULL,
    vp22_8_1 decimal(6,3) NOT NULL,
    vp22_8_2 decimal(6,3) NOT NULL,
    vp22_8_3 decimal(6,3) NOT NULL,
    vp25_0_1 decimal(6,3) NOT NULL,
    vp25_0_2 decimal(6,3) NOT NULL,
    vp25_0_3 decimal(6,3) NOT NULL
);

CREATE TABLE resultadosMicrometros(
	pk_idNrCertificado int PRIMARY KEY,
    fk_idControle int NOT NULL,
    fk_idPlaneza int NOT NULL,
    fk_idParalelismoMicro int NOT NULL,
    fk_idInstrumento int NOT NULL,
    responsavel varchar(60) NOT NULL,
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
    primeiraMedida decimal(6,3) NOT NULL,
    valorNominal1_1 decimal(6,3) NOT NULL,
    valorNominal1_2 decimal(6,3) NOT NULL,
    valorNominal1_3 decimal(6,3) NOT NULL,
    segundaMedida decimal(6,3) NOT NULL,
    valorNominal2_1 decimal(6,3) NOT NULL,
    valorNominal2_2 decimal(6,3) NOT NULL,
    valorNominal2_3 decimal(6,3) NOT NULL,
    terceiraMedida decimal(6,3) NOT NULL,
    valorNominal3_1 decimal(6,3) NOT NULL,
    valorNominal3_2 decimal(6,3) NOT NULL,
    valorNominal3_3 decimal(6,3) NOT NULL
);

CREATE TABLE medicoesRessaltos(
	pk_idMedicaoRessalto int PRIMARY KEY AUTO_INCREMENT,
	primeiraMedida decimal(6,3) NOT NULL,
    valorNominal1_1 decimal(6,3) NOT NULL,
    valorNominal1_2 decimal(6,3) NOT NULL,
    valorNominal1_3 decimal(6,3) NOT NULL,
    segundaMedida decimal(6,3) NOT NULL,
    valorNominal2_1 decimal(6,3) NOT NULL,
    valorNominal2_2 decimal(6,3) NOT NULL,
    valorNominal2_3 decimal(6,3) NOT NULL,
    terceiraMedida decimal(6,3) NOT NULL,
    valorNominal3_1 decimal(6,3) NOT NULL,
    valorNominal3_2 decimal(6,3) NOT NULL,
    valorNominal3_3 decimal(6,3) NOT NULL
);

CREATE TABLE medicoesProfundidades(
	pk_idMedicaoProfundidade int PRIMARY KEY AUTO_INCREMENT,
	primeiraMedida decimal(6,3) NOT NULL,
    valorNominal1_1 decimal(6,3) NOT NULL,
    valorNominal1_2 decimal(6,3) NOT NULL,
    valorNominal1_3 decimal(6,3) NOT NULL,
    segundaMedida decimal(6,3) NOT NULL,
    valorNominal2_1 decimal(6,3) NOT NULL,
    valorNominal2_2 decimal(6,3) NOT NULL,
    valorNominal2_3 decimal(6,3) NOT NULL,
    terceiraMedida decimal(6,3) NOT NULL,
    valorNominal3_1 decimal(6,3) NOT NULL,
    valorNominal3_2 decimal(6,3) NOT NULL,
    valorNominal3_3 decimal(6,3) NOT NULL
);

CREATE TABLE paralelismoPaq(
	pk_idParelelismo int PRIMARY KEY AUTO_INCREMENT,
    valorNominalOrelha	decimal(6,3) NOT NULL,
    valorProxOrelha1 decimal(6,3) NOT NULL,
    valorProxOrelha2 decimal(6,3) NOT NULL,
    valorProxOrelha3 decimal(6,3) NOT NULL,
    valorAfasOrelha1 decimal(6,3) NOT NULL,
    valorAfasOrelha2 decimal(6,3) NOT NULL,
    valorAfasOrelha3 decimal(6,3) NOT NULL,
    valorNominalBico decimal(6,3) NOT NULL,
    valorProxBico1 decimal(6,3) NOT NULL,
    valorProxBico2 decimal(6,3) NOT NULL,
    valorProxBico3 decimal(6,3) NOT NULL,
    valorAfasBico1 decimal(6,3) NOT NULL,
    valorAfasBico2 decimal(6,3) NOT NULL,
    valorAfasBico3 decimal(6,3) NOT NULL
);

CREATE TABLE medicoesExternas(
	pk_idMedicaoExterna	int PRIMARY KEY AUTO_INCREMENT,
    vn0_0_1 decimal(6,3) NOT NULL,
    vn0_0_2 decimal(6,3) NOT NULL,
    vn0_0_3 decimal(6,3) NOT NULL,
    vn1_3_1 decimal(6,3) NOT NULL,
    vn1_3_2 decimal(6,3) NOT NULL,
    vn1_3_3 decimal(6,3) NOT NULL,
    vn1_4_1 decimal(6,3) NOT NULL,
    vn1_4_2 decimal(6,3) NOT NULL,
    vn1_4_3 decimal(6,3) NOT NULL,
    vn20_0_1 decimal(6,3) NOT NULL,
    vn20_0_2 decimal(6,3) NOT NULL,
    vn20_0_3 decimal(6,3) NOT NULL,
    vn50_0_1 decimal(6,3) NOT NULL,
    vn50_0_2 decimal(6,3) NOT NULL,
    vn50_0_3 decimal(6,3) NOT NULL,
    vn100_0_1 decimal(6,3) NOT NULL,
    vn100_0_2 decimal(6,3) NOT NULL,
    vn100_0_3 decimal(6,3) NOT NULL,
    vn150_0_1 decimal(6,3) NOT NULL,
    vn150_0_2 decimal(6,3) NOT NULL,
    vn150_0_3 decimal(6,3) NOT NULL,
    vnExtra1_1 decimal(6,3),
    vnExtra1_2 decimal(6,3),
    vnExtra1_3 decimal(6,3),
    vnExtra2_1 decimal(6,3),
    vnExtra2_2 decimal(6,3),
    vnExtra2_3 decimal(6,3),
    vnExtra3_1 decimal(6,3),
    vnExtra3_2 decimal(6,3),
    vnExtra3_3 decimal(6,3)
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

CREATE TABLE pecas(
	pk_idPeca int PRIMARY KEY,
    fk_idOs int NOT NULL,
    fk_idCliente int NOT NULL,
	nome varchar(60) NOT NULL,
    material varchar(60) NOT NULL,
    nDesenho int NOT NULL,
    descricao varchar(300),
    
    FOREIGN KEY (fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente)
);

CREATE TABLE pecasRecebidas(
	pk_idRecebimento int PRIMARY KEY,
	fk_idOs int NOT NULL,
    fk_idUsuario int NOT NULL,
    setor varchar(50) NOT NULL,
    nProposta int NOT NULL,
    nNotaFiscal int NOT NULL,
    dataDeRecebimento date NOT NULL,
    recebidoNaPrevisao enum("sim", "nao") NOT NULL,
    previsaoInicio date, 
    previsaoTermino date,
    clienteConcorda enum("sim", "nao") NOT NULL,
    -- responsavelRecebimento varchar(60) NOT NULL,
    dataAssinatura date NOT NULL,
    
    FOREIGN KEY (fk_idOs) REFERENCES	ordensServico(pk_idOs)
);

CREATE TABLE relatorio(
	pk_idRelatorio int PRIMARY KEY,
    fk_idOs int NOT NULL,
    fk_idInstrumento int NOT NULL,
    inicio varchar(20) NOT NULL,
    termino varchar(20) NOT NULL,
    temperaturaC varchar(20) NOT NULL,
    umidadeRelativa varchar(20) NOT NULL,
    notasMedicao varchar(20) NOT NULL,
    dia DATE NOT NULL,
    
    FOREIGN KEY (fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY (fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento)
);