CREATE DATABASE bancointelliMetrics;

USE bancointelliMetrics;

DROP DATABASE bancointelliMetrics;

CREATE TABLE usuarios(
	pk_idUsuario int PRIMARY KEY AUTO_INCREMENT,
    nome varchar(60) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    senha varchar(20) NOT NULL DEFAULT "Suiclab123",
    cargo enum("gestor", "tecnico") NOT NULL,
    status enum("ativo", "inativo") NOT NULL DEFAULT "ativo"
);

CREATE TABLE clientes(
	pk_idCliente int PRIMARY KEY AUTO_INCREMENT,
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

CREATE TABLE recebidos(
	pk_idRecebimento int PRIMARY KEY AUTO_INCREMENT,
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
    pessoaContatada varchar(60),
    dataContatada date,
    
    FOREIGN KEY(fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idUsuario) REFERENCES usuarios(pk_idUsuario)
);

CREATE TABLE categorias(
	pk_idCategoria int  PRIMARY KEY AUTO_INCREMENT,
    nome varchar(30) NOT NULL
);

CREATE TABLE instrumentos(
	pk_idInstrumento int PRIMARY KEY AUTO_INCREMENT,
    fk_idCliente int NOT NULL,
    fk_idOs int NOT NULL,
    fk_idCategoria int NOT NULL,
    nome varchar(60) NOT NULL,
    nSerie int NOT NULL,
    identificacaoCliente varchar(50) NOT NULL,
    fabricante varchar(60) NOT NULL,
    faixaNominalNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25") NOT NULL,
    faixaNominalUni enum("mm", "pol") NOT NULL,
    divisaoResolucaoNum decimal(4,2) NOT NULL,
    divisaoResolucaoUni enum("mm", "pol") NOT NULL,
    orgaoResponsavel varchar(60),
    
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente),
    FOREIGN KEY(fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idCategoria) REFERENCES categorias(pk_idCategoria)
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
    vp1 decimal(6,3) NOT NULL,
    vp1_1 decimal(6,3) NOT NULL,
    vp1_2 decimal(6,3) NOT NULL,
    vp1_3 decimal(6,3) NOT NULL,
    vp2 decimal(6,3) NOT NULL,
    vp2_1 decimal(6,3) NOT NULL,
    vp2_2 decimal(6,3) NOT NULL,
    vp2_3 decimal(6,3) NOT NULL,
    vp3 decimal(6,3) NOT NULL,
    vp3_1 decimal(6,3) NOT NULL,
    vp3_2 decimal(6,3) NOT NULL,
    vp3_3 decimal(6,3) NOT NULL,
    vp4 decimal(6,3) NOT NULL,
    vp4_1 decimal(6,3) NOT NULL,
    vp4_2 decimal(6,3) NOT NULL,
    vp4_3 decimal(6,3) NOT NULL,
    vp5 decimal(6,3) NOT NULL,
    vp5_1 decimal(6,3) NOT NULL,
    vp5_2 decimal(6,3) NOT NULL,
    vp5_3 decimal(6,3) NOT NULL,
    vp6 decimal(6,3) NOT NULL,
    vp6_1 decimal(6,3) NOT NULL,
    vp6_2 decimal(6,3) NOT NULL,
    vp6_3 decimal(6,3) NOT NULL,
    vp7 decimal(6,3) NOT NULL,
    vp7_1 decimal(6,3) NOT NULL,
    vp7_2 decimal(6,3) NOT NULL,
    vp7_3 decimal(6,3) NOT NULL,
    vp8 decimal(6,3) NOT NULL,
    vp8_1 decimal(6,3) NOT NULL,
    vp8_2 decimal(6,3) NOT NULL,
    vp8_3 decimal(6,3) NOT NULL,
    vp9 decimal(6,3) NOT NULL,
    vp9_1 decimal(6,3) NOT NULL,
    vp9_2 decimal(6,3) NOT NULL,
    vp9_3 decimal(6,3) NOT NULL,
    vp10 decimal(6,3) NOT NULL,
    vp10_1 decimal(6,3) NOT NULL,
    vp10_2 decimal(6,3) NOT NULL,
    vp10_3 decimal(6,3) NOT NULL,
    vp11 decimal(6,3) NOT NULL,
    vp11_1 decimal(6,3) NOT NULL,
    vp11_2 decimal(6,3) NOT NULL,
    vp11_3 decimal(6,3) NOT NULL
);

CREATE TABLE resultadosMicrometros(
	pk_idNrCertificado int PRIMARY KEY,
    fk_idControle int NOT NULL,
    fk_idPlaneza int NOT NULL,
    fk_idParalelismoMicro int NOT NULL,
    fk_idInstrumento int NOT NULL,
    fk_idTecnico int NOT NULL,
    fk_idResponsavel int NOT NULL,
    faixaCalibradaNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25") NOT NULL,
    faixaCalibradaUni enum("mm", "pol") NOT NULL,
    dataCalibracao date NOT NULL,
    inspecao enum("ok", "nok") NOT NULL,
    tipoEscala enum("analogico", "digital") NOT NULL,
    versaoMetodo int NOT NULL,
    tempInicial decimal(4,2) NOT NULL,
    tempFinal decimal(4,2) NOT NULL,
    
    FOREIGN KEY(fk_idControle) REFERENCES controleDimensional(pk_idControle),
    FOREIGN KEY(fk_idPlaneza) REFERENCES planeza(pk_idPlaneza),
    FOREIGN KEY(fk_idParalelismoMicro) REFERENCES paralelismoMicro(pk_idParalelismoMicro),
    FOREIGN KEY(fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento),
    FOREIGN KEY(fk_idTecnico) REFERENCES usuarios(pk_idUsuario),
    FOREIGN KEY(fk_idResponsavel) REFERENCES usuarios(pk_idUsuario)
);

CREATE TABLE medicoesInternas(
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
	pk_idParalelismoPaq int PRIMARY KEY AUTO_INCREMENT,
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
	vn1 decimal(6,3) NOT NULL,
    vn1_1 decimal(6,3) NOT NULL,
    vn1_2 decimal(6,3) NOT NULL,
    vn1_3 decimal(6,3) NOT NULL,
    vn2 decimal(6,3) NOT NULL,
    vn2_1 decimal(6,3) NOT NULL,
    vn2_2 decimal(6,3) NOT NULL,
    vn2_3 decimal(6,3) NOT NULL,
    vn3 decimal(6,3) NOT NULL,
    vn3_1 decimal(6,3) NOT NULL,
    vn3_2 decimal(6,3) NOT NULL,
    vn3_3 decimal(6,3) NOT NULL,
    vn4 decimal(6,3) NOT NULL,
    vn4_1 decimal(6,3) NOT NULL,
    vn4_2 decimal(6,3) NOT NULL,
    vn4_3 decimal(6,3) NOT NULL,
    vn5 decimal(6,3) NOT NULL,
    vn5_1 decimal(6,3) NOT NULL,
    vn5_2 decimal(6,3) NOT NULL,
    vn5_3 decimal(6,3) NOT NULL,
    vn6 decimal(6,3) NOT NULL,
    vn6_1 decimal(6,3) NOT NULL,
    vn6_2 decimal(6,3) NOT NULL,
    vn6_3 decimal(6,3) NOT NULL,
    vn7 decimal(6,3) NOT NULL,
    vn7_1 decimal(6,3) NOT NULL,
    vn7_2 decimal(6,3) NOT NULL,
    vn7_3 decimal(6,3) NOT NULL,
    vnExtra1 decimal(6,3),
    vnExtra1_1 decimal(6,3),
    vnExtra1_2 decimal(6,3),
    vnExtra1_3 decimal(6,3),
    vnExtra2 decimal(6,3),
    vnExtra2_1 decimal(6,3),
    vnExtra2_2 decimal(6,3),
    vnExtra2_3 decimal(6,3),
    vnExtra3 decimal(6,3),
    vnExtra3_1 decimal(6,3),
    vnExtra3_2 decimal(6,3),
    vnExtra3_3 decimal(6,3)
);

CREATE TABLE resultadosPaquimetros(
	pk_idNrCertificado int PRIMARY KEY,
    fk_idInstrumento int NOT NULL,
    fk_idParalelismoPaq int NOT NULL,
    fk_idMedicaoExterna int NOT NULL,
    fk_idMedicaoInterna int NOT NULL,
    fk_idMedicaoRessalto int NOT NULL,
    fk_idMedicaoProfundidade int NOT NULL,
    fk_idTecnico int NOT NULL,
    fk_idResponsavel int NOT NULL,
    dataCalibracao date NOT NULL,
    inspecao enum("ok", "nok") NOT NULL,
    tipoEscala enum("analogico", "digital") NOT NULL,
    versaoMetodo int NOT NULL,
    tempInicial decimal(4,2) NOT NULL,
    tempFinal decimal(4,2) NOT NULL,
    
    FOREIGN KEY(fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento),
    FOREIGN KEY(fk_idParalelismoPaq) REFERENCES paralelismoPaq(pk_idParalelismoPaq),
    FOREIGN KEY(fk_idMedicaoExterna) REFERENCES medicoesExternas(pk_idMedicaoExterna),
    FOREIGN KEY(fk_idMedicaoInterna) REFERENCES medicoesInternas(pk_idMedicaoInterna),
    FOREIGN KEY(fk_idMedicaoRessalto) REFERENCES medicoesRessaltos(pk_idMedicaoRessalto),
    FOREIGN KEY(fk_idMedicaoProfundidade) REFERENCES medicoesProfundidades(pk_idMedicaoProfundidade),
    FOREIGN KEY(fk_idTecnico) REFERENCES usuarios(pk_idUsuario),
    FOREIGN KEY(fk_idResponsavel) REFERENCES usuarios(pk_idUsuario)
);

CREATE TABLE pecas(
	pk_idPeca int PRIMARY KEY AUTO_INCREMENT,
    fk_idOs int NOT NULL,
    fk_idCliente int NOT NULL,
	nome varchar(60) NOT NULL,
    material varchar(60) NOT NULL,
    nDesenho int NOT NULL,
    descricao varchar(300),
    
    FOREIGN KEY (fk_idOs) REFERENCES ordensServico(pk_idOs),
    FOREIGN KEY(fk_idCliente) REFERENCES clientes(pk_idCliente)
);

CREATE TABLE relatorio(
	pk_idRelatorio int PRIMARY KEY,
    fk_idInstrumento int NOT NULL,
    fk_idUsuario int NOT NULL,
    fk_idPeca int NOT NULL,
    inicio time(0) NOT NULL,	-- o 'time(o)' faz com que a coluna receba apenas valores de hora e minuto. Devem ser inseridos dentro de aspas: '09:00'
    termino time(0) NOT NULL,
    tempoTotal time(0) NOT NULL,
    temperaturaC varchar(20) NOT NULL,
    umidadeRelativa varchar(20) NOT NULL,
    observacoes varchar(300),
    localDaMedicao varchar(100) NOT NULL,
    dia date NOT NULL,
    assinatura varchar(100) NOT NULL,
    
    FOREIGN KEY (fk_idInstrumento) REFERENCES instrumentos(pk_idInstrumento),
    FOREIGN KEY(fk_idUsuario) REFERENCES usuarios(pk_idUsuario),
    FOREIGN KEY(fk_idPeca) REFERENCES pecas(pk_idPeca)
);