-- criação de usuário
DELIMITER //
CREATE PROCEDURE criarUsuario(
	IN novoUsuario varchar(60),
    IN emailUsuario varchar(60),
    IN cargoUsuario enum("gestor", "tecnico")
)
BEGIN
	INSERT INTO usuarios(nome, email, cargo)
    VALUES(novoUsuario, emailUsuario, cargoUsuario);
END // 
DELIMITER ;
call criarUsuario("Matheus Aguilar", "theuzinapalaum@gmail.com", "tecnico");
call criarUsuario("Julia Paxeco", "xulinhagamerm@gmail.com", "gestor");


-- redefinição de senha
DELIMITER //
CREATE PROCEDURE redefinirSenha(
	IN emailUsuario varchar(60),
	IN novaSenha varchar(20)
)
BEGIN
	UPDATE usuarios
    SET senha = novaSenha
    WHERE email = emailUsuario;
END // 
DELIMITER ;
call redefinirSenha("theuzinapalaum@gmail.com", "arroz");
call redefinirSenha("xulinhagamerm@gmail.com", "batata");


-- alteração de usuário
DELIMITER //
CREATE PROCEDURE modificarUsuario(
	IN emailUsuario varchar(60),
	IN alterarNome varchar(60),
    IN alterarCargo enum("gestor", "tecnico")
)
BEGIN
	UPDATE usuarios
    SET nome = alterarNome, cargo = alterarCargo
    WHERE email = emailUsuario;
END // 
DELIMITER ;
call modificarUsuario("theuzinapalaum@gmail.com", "Mateus jamilton", "gestor");


-- exclusão de usuário
DELIMITER //
CREATE PROCEDURE excluirUsuario(
	IN emailUsuario varchar(60)
)
BEGIN
	UPDATE usuarios
    SET status = "inativo"
    WHERE email = emailUsuario;
END // 
DELIMITER ;
call excluirUsuario("theuzinapalaum@gmail.com");


-- reativação de usuário
DELIMITER //
CREATE PROCEDURE reativarUsuario(
	IN emailUsuario varchar(60)
)
BEGIN
	UPDATE usuarios
    SET status = "ativo"
    WHERE email = emailUsuario;
END // 
DELIMITER ;
call reativarUsuario("theuzinapalaum@gmail.com");


-- retornar informações do usário
DELIMITER //
CREATE PROCEDURE infosUsuario(
	IN idUsuario INT,
    OUT nomeUsuario VARCHAR(60),
    OUT emailUsuario VARCHAR(60),
    OUT cargoUsuario ENUM('gestor', 'tecnico'),
    OUT statusUsuario ENUM('ativo', 'inativo')
)
BEGIN
    SELECT nome, email, cargo, status
    INTO nomeUsuario, emailUsuario, cargoUsuario, statusUsuario
    FROM usuarios
    WHERE pk_idUsuario = idUsuario;
END//
DELIMITER ;
call infosUsuario(2, @nome, @email, @cargo, @status);
SELECT @nome AS nomeUsuario, @email AS emailUsuario, @cargo AS cargoUsuario, @status AS statusUsuario;


-- criação de cliente
DELIMITER //
CREATE PROCEDURE criarCliente(
	IN novoCliente varchar(60),
    IN novoRepresentante varchar(60),
    IN novoEmail varchar(60),
    IN novoTelefone varchar(11),
    IN novoEndereco varchar(100),
    IN novoCNPJ char(14)
)
BEGIN
	INSERT INTO clientes(nomeEmpresa, representante, email, telefone, endereco, cnpj)
    VALUES (novoCliente, novoRepresentante, novoEmail, novoTelefone, novoEndereco, novoCNPJ);
END // 
DELIMITER ;
call criarCliente("Market Industry", "Roberto Carlos", "robertao2000@gmail.com", "11970449723", "Rua Senador Feijó, 4501, Sé", 12345678904321);


-- alteração de cliente
DELIMITER //
CREATE PROCEDURE modificarCliente(
	IN idCliente int,
	IN alterarNome varchar(60),
    IN alterarRepresentante varchar(60),
    IN alterarEmail varchar(60),
    IN alterarTelefone varchar(11),
    IN alterarEndereco varchar(100),
    IN alterarCNPJ char(14)
)
BEGIN
	UPDATE clientes
    SET nomeEmpresa = alterarNome,
    representante = alterarRepresentante,
    email = alterarEmail,
    telefone = alterarTelefone,
    endereco = alterarEndereco,
    cnpj = alterarCNPJ
    WHERE pk_idCliente = idCliente;
END // 
DELIMITER ;
call modificarCliente(1, "Market Industry", "Carlos Aberto", "carlao2000@gmail.com", "11926670445", "Rua Senador Feijó, 4501, Sé", 12345678904321);


-- exclusão de cliente
DELIMITER //
CREATE PROCEDURE exlcuirCliente(
	IN idCliente int
)
BEGIN
	UPDATE clientes
    SET status = "inativo"
    WHERE pk_idCliente = idCliente;
END // 
DELIMITER ;
call exlcuirCliente(1);


-- reativação de cliente
DELIMITER //
CREATE PROCEDURE reativarCliente(
	IN idCliente int
)
BEGIN
	UPDATE clientes
    SET status = "ativo"
    WHERE pk_idCliente = idCliente;
END // 
DELIMITER ;
call reativarCliente(1);


-- retornar informações do cliente
DELIMITER //
CREATE PROCEDURE infosCliente(
	IN idCliente INT,
    OUT nomeCliente VARCHAR(60),
    OUT representanteCliente VARCHAR(60),
    OUT emailCliente VARCHAR(60),
    OUT telefoneCliente VARCHAR(11),
    OUT enderecoCliente VARCHAR(100),
    OUT cnpjCliente CHAR(14),
    OUT statusCliente ENUM('ativo', 'inativo')
)
BEGIN
    SELECT nomeEmpresa, representante, email, telefone, endereco, cnpj, status
    INTO nomeCliente, representanteCliente, emailCliente, telefoneCliente, enderecoCliente, cnpjCliente, statusCliente
    FROM clientes
    WHERE pk_idCliente = idCliente;
END//
DELIMITER ;
CALL infosCliente(1, @nomeEmpresa, @representante, @email, @telefone, @endereco, @cnpj, @status);
SELECT @nomeEmpresa AS nomeCliente, @representante AS representanteCliente, @email AS emailCliente, @telefone AS telefoneCliente, @endereco AS enderecoCliente, @cnpj AS cnpjCliente, @status AS statusCliente;


-- criação de ordem de serviço
DELIMITER //
CREATE PROCEDURE criarOrdens(
	IN novaOrdem int,
	IN idCliente int,
    IN idUsuario int,
    IN novoTitulo varchar(30),
    IN novoTipo enum("calibracao", "medicao"),
    IN novaDescricao varchar(150),
    IN novaDataInicio date,
    IN novaDataTermino date,
    IN novoContratante varchar(60),
    IN novoEmail varchar(60),
    IN novoTelefone varchar(11),
    IN novoStatus enum("em espera", "concluida")
)
BEGIN
	INSERT INTO ordensServico(pk_idOs, fk_idCliente, fk_idUsuario, titulo, tipo, descricao, dataInicio, dataTermino, contratante, email, telefone, status)
    VALUES (novaOrdem, idCliente, idUsuario, novoTitulo, novoTipo, novaDescricao, novaDataInicio, novaDataTermino, novoContratante, novoEmail, novoTelefone, novoStatus);
END // 
DELIMITER ;
call criarOrdens(556, 1, 1, "Arregaça ai esse paquímetro", "calibracao", "Paquímetro ta com defeito", curdate(), '2024-03-27', "Bill Gates", "gatesbill@gmail.com", 11902345567, "em espera");
call criarOrdens(665, 1, 1, "Arregaça ai esse parafuso", "medicao", "Parafuso torto", curdate(), '2024-04-28', "Bill Gates", "gatesbill@gmail.com", 11902345567, "em espera");


-- alteração de ordem de serviço
DELIMITER //
CREATE PROCEDURE modificarOrdem(
	IN idAntigo int,
	IN alterarOrdem int,
	IN alterarCliente int,
    IN alterarUsuario int,
    IN alterarTitulo varchar(30),
    IN alterarTipo enum("calibracao", "medicao"),
    IN alterarDescricao varchar(150),
    IN alterarDataTermino date,
    IN alterarContratante varchar(60),
    IN alterarEmail varchar(60),
    IN alterarTelefone varchar(11)
)
BEGIN
	UPDATE ordensServico
    SET pk_idOs = alterarOrdem,
    fk_idCliente = alterarCliente,
    fk_idUsuario = alterarUsuario,
    titulo = alterarTitulo,
    tipo = alterarTipo,
    descricao = alterarDescricao,
    dataTermino = alterarDataTermino,
    contratante = alterarContratante,
    email = alterarEmail,
    telefone = alterarTelefone
    WHERE pk_idOs = idAntigo;
END // 
DELIMITER ;
call modificarOrdem(45, 556, 1, 2, "banana", "calibracao", "cabou banana", '2024-04-27', "Bill Gates", "gatesbill@gmail.com", 11902345567);


-- marcar ordem de serviço como concluída
DELIMITER //
CREATE PROCEDURE concluirOrdem(
	IN idOrdem int
)
BEGIN
	UPDATE ordensServico
    SET status = "concluida"
    WHERE pk_idOs = idOrdem;
END // 
DELIMITER ;
call concluirOrdem(556);


-- desmarcar ordem de serviço como concluída
DELIMITER //
CREATE PROCEDURE desmarcarOrdemComoConcluida(
	IN idOrdem int
)
BEGIN
	UPDATE ordensServico
    SET status = "em espera"
    WHERE pk_idOs = idOrdem;
END // 
DELIMITER ;
call desmarcarOrdemComoConcluida(556);


-- retornar informações da ordem de serviço
DELIMITER //
CREATE PROCEDURE infosOrdens(
	IN idOs INT,
    OUT idOsResultado INT,
    OUT fk_idClienteOs INT,
    OUT fk_idUsuarioOs INT,
    OUT tituloOs VARCHAR(30),
    OUT tipoOs ENUM('calibracao', 'medicao'),
    OUT descricaoOs VARCHAR(300),
    OUT dataInicioOs DATE,
    OUT dataTerminoOs DATE,
    OUT contratanteOs VARCHAR(60),
    OUT emailOs VARCHAR(60),
    OUT telefoneOs VARCHAR(11),
    OUT statusOs ENUM('em espera', 'concluida')
)
BEGIN
    SELECT pk_idOs, fk_idCliente, fk_idUsuario, titulo, tipo, descricao, dataInicio, dataTermino, contratante, email, telefone, status
    INTO idOsResultado, fk_idClienteOs, fk_idUsuarioOs, tituloOs, tipoOs, descricaoOs, dataInicioOs, dataTerminoOs, contratanteOs, emailOs, telefoneOs, statusOs
    FROM ordensServico
    WHERE pk_idOs = idOs;
END//
DELIMITER ;
CALL infosOrdens(556, @idOs, @fk_idCliente, @fk_idUsuario, @titulo, @tipo, @descricao, @dataInicio, @dataTermino, @contratante, @email, @telefone, @status);
SELECT @idOs AS idOsResultado, @fk_idCliente AS fk_idClienteOs, @fk_idUsuario AS fk_idUsuarioOs, @titulo AS tituloOs, @tipo AS tipoOs, @descricao AS descricaoOs, @dataInicio AS dataInicioOs, @dataTermino AS dataTerminoOs, @contratante AS contratanteOs, @email AS emailOs, @telefone AS telefoneOs, @status AS statusOs;


-- cadastrar categorias
DELIMITER //
CREATE PROCEDURE cadastrarCategoria(
	IN novaCategoria varchar(30)
)
BEGIN
	INSERT INTO categorias(nome) VALUES (novaCategoria);
END//
DELIMITER ;
call cadastrarCategoria("Paquímetro");


-- alterar categoria
DELIMITER //
CREATE PROCEDURE modificarCategoria(
	IN idCategoria int,
	IN alterarCategoria varchar(30)
)
BEGIN
	UPDATE categorias
    SET nome = alterarCategoria
    WHERE pk_idCategoria = idCategoria;
END//
DELIMITER ;
call modificarCategoria(1, "Paquimero");


-- cadastro de instrumentos
DELIMITER //
CREATE PROCEDURE cadastrarInstrumento(
    IN idCliente int,
    IN idOrdem int,
    IN idCategoria int,
    IN novoNome varchar(60),
    IN novoNSerie int,
    IN novaIdentificacaoCliente varchar(50),
    IN novoFabricante varchar(60),
	IN novaFaixaNominalNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
    IN novaFaixaNominalUnidade enum('mm', 'pol'),
    IN novaDivisaoNum decimal(4,2),
    IN novaDivisaoUni enum('mm', 'pol'),
    IN novoOrgao varchar(60),
	IN novaEmbalagem enum("ruim", "medio", "bom")
)
BEGIN
    INSERT INTO instrumentos(fk_idCliente, fk_idOs, fk_idCategoria, nome, nSerie, identificacaoCliente, fabricante, faixaNominalNum, faixaNominalUni, divisaoResolucaoNum, divisaoResolucaoUni, orgaoResponsavel, estadoEmbalagem)
    VALUES (idCliente, idOrdem, idCategoria, novoNome, novoNSerie, novaIdentificacaoCliente, novoFabricante, novaFaixaNominalNum, novaFaixaNominalUnidade, novaDivisaoNum, novaDivisaoUni, novoOrgao, novaEmbalagem);
END //
DELIMITER ;
call cadastrarInstrumento(1, 556, 1, "Paquímetro universal", 112233, 1222333,  "Martelos e machados", "75-100", "mm", 2.43, "mm", "Martelos wakanda", "medio");


-- alteraçao de instrumentos
DELIMITER //
CREATE PROCEDURE modificarInstrumento(
    IN idInstrumento INT,
    IN idCliente INT,
    IN idOsCalibracao INT,
    IN idCategoria INT,
    IN alterarNome VARCHAR(60),
    IN alterarNSerie INT,
	IN alterarIdentificacaoCliente varchar(50),
    IN alterarFabricante VARCHAR(60),
    IN alterarFaixaNominalNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
    IN alterarFaixaNominalUnidade enum('mm', 'pol'),
    IN alterarDivisaoNum decimal(4,2),
    IN alterarDivisaoUni enum('mm', 'pol'),
    IN alterarOrgao varchar(60),
	IN alterarEmbalagem enum("ruim", "medio", "bom")
)
BEGIN
    UPDATE instrumentos
    SET fk_idCliente = idCliente,
    fk_idOs = idOsCalibracao,
    fk_idCategoria = idCategoria,
    nome = alterarNome,
    nSerie = alterarNSerie,
    identificacaoCliente = alterarIdentificacaoCliente,
	fabricante = alterarFabricante,
    faixaNominalNum = alterarFaixaNominalNum,
    faixaNominalUni = alterarFaixaNominalUnidade,
    divisaoResolucaoNum = alterarDivisaoNum,
    divisaoResolucaoUni = alterarDivisaoUni,
	orgaoResponsavel = alterarOrgao,
	estadoEmbalagem = alterarEmbalagem
    WHERE pk_idinstrumento = idInstrumento;
END //
DELIMITER ;
call modificarInstrumento(1, 1, 556, 1, "Paquímetro cromado", 112233, 111232, "Machados e Martelos", "25-50", "pol", 5.32, "mm", "Martelos Stark", "ruim");


-- retornar informações de instrumento
DELIMITER //
CREATE PROCEDURE infosInstrumento(
	IN idInstrumento INT,
    OUT idCliente INT,
    OUT idOs INT,
    OUT idCategoria INT,
    OUT infoNome varchar(60),
    OUT infoNSerie INT,
    OUT infoIdentificacaoCliente VARCHAR(50),
    OUT infoFabricante VARCHAR(60),
    OUT infoFaixaNominalNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
    OUT infoFaixaNominalUni ENUM('mm', 'pol'),
    OUT infoDivisaoResolucaoNum DECIMAL(4,2),
    OUT infoDivisaoResolucaoUni ENUM('mm', 'pol'),
    OUT infoOrgaoResponsavel VARCHAR(60),
	OUT infoEmbalagem enum("ruim", "medio", "bom")
)
BEGIN
    SELECT fk_idCliente, fk_idOs, fk_idCategoria, nome, nSerie, identificacaoCliente, fabricante, faixaNominalNum, faixaNominalUni, divisaoResolucaoNum, divisaoResolucaoUni, orgaoResponsavel, estadoEmbalagem
    INTO idCliente, idOs, idCategoria, infoNome, infoNSerie, infoIdentificacaoCliente, infoFabricante, infoFaixaNominalNum, infoFaixaNominalUni, infoDivisaoResolucaoNum, infoDivisaoResolucaoUni, infoOrgaoResponsavel, infoEmbalagem
    FROM instrumentos
    WHERE pk_idInstrumento = idInstrumento;
END//
DELIMITER ;
CALL infosInstrumento(1, @fk_idCliente, @fk_idOs, @fk_idCategoria, @nome, @nSerie, @identificacaoCliente, @fabricante, @faixaNominalNum, @faixaNominalUni, @divisaoResolucaoNum, @divisaoResolucaoUni, @orgaoResponsavel, @estadoEmbalagem);
SELECT @fk_idCliente AS idCliente, @fk_idOs AS idOs, @fk_idCategoria AS idCategoria, @nome AS infoNome, @nSerie AS infoIdentificacaoCliente, @identificacaoCliente AS infoIdentificacaoCliente, @fabricante AS infoFabricante, @faixaNominalNum AS infoFaixaNominalNum, @faixaNominalUni AS infoFaixaNominalUni, @divisaoResolucaoNum AS infoDivisaoResolucaoNum, @divisaoResolucaoUni AS infoDivisaoResolucaoUni, @orgaoResponsavel AS infoOrgaoResponsavel, @estadoEmbalagem AS infoEmbalagem;


-- inserção de recebidos
DELIMITER //
CREATE PROCEDURE inserirRecebimento(
    IN idOrdem int,
    IN idUsuario int,
    IN novoSetor varchar(30),
    IN novoNProposta int,
    IN novoNumNotaFiscal int,
    IN novaDataRecebimento date,
    IN novoRecebidoPrevisao enum("sim", "nao"),
    IN novaPrevisaoInicio date,
    IN novaPrevisaoTermino date,
    IN novoClienteConcorda enum("sim", "nao"),
    IN dataAssinatura date,
    IN novaPessoaContatada varchar(60),
    IN novaDataContatada date
)
BEGIN
    INSERT INTO recebidos(fk_idOs, fk_idUsuario, setor, nProposta, nNotaFiscal, dataDeRecebimento, recebidoNaPrevisao, previsaoInicio, previsaoTermino, clienteConcorda, dataAssinatura, pessoaContatada, dataContatada)
    VALUES (idOrdem, idUsuario, novoSetor, novoNProposta, novoNumNotaFiscal, novaDataRecebimento, novoRecebidoPrevisao, novaPrevisaoInicio, novaPrevisaoTermino, novoClienteConcorda, dataAssinatura, novaPessoaContatada, novaDataContatada);
END //
DELIMITER ;
call inserirRecebimento(556, 1, "rh", 12341, 12344563, '2024-03-27', "sim", null, null, "sim", '2024-03-28', null, null);
call inserirRecebimento(665, 2, "financeiro", 33452, 00097612, '2024-03-27', "sim", null, null, "sim", '2024-08-28', null, null);


-- alteração de recebidos
DELIMITER //
CREATE PROCEDURE modificarRecebimento(
	IN idRecebimento int,
	IN idOrdem int,
    IN alterarSetor varchar(30),
    IN alterarNProposta int,
    IN alterarNumNotaFiscal int,
    IN alterarDataRecebimento date,
    IN alterarRecebidoPrevisao enum("sim", "nao"),
    IN alterarPrevisaoInicio date,
    IN alterarPrevisaoTermino date,
    IN alterarClienteConcorda enum("sim", "nao"),
    IN alterarDataAssinatura date,
    IN alterarPessoaContatada varchar(60),
    IN alterarDataContatada date
)
BEGIN
	UPDATE recebidos
    SET fk_idOs = idOrdem,
    setor = alterarSetor,
    nProposta = alterarNProposta,
    nNotaFiscal = alterarNumNotaFiscal,
    dataDeRecebimento = alterarDataRecebimento,
    recebidoNaPrevisao = alterarRecebidoPrevisao,
    previsaoInicio = alterarPrevisaoInicio,
    previsaoTermino = alterarPrevisaoTermino,
    clienteConcorda = alterarClienteConcorda,
    dataAssinatura = alterarDataAssinatura,
    pessoaContatada = alterarPessoaContatada,
    dataContatada = alterarDataContatada
    WHERE pk_idRecebimento = idRecebimento;
END // 
DELIMITER ;
call modificarRecebimento(1, 556, "vendas", 12341, 12344563, '2024-03-27', "sim", '2024-04-25', '2024-05-21', "sim", '2024-03-28', null, null);


-- visualização dos recebidos
DELIMITER //
CREATE PROCEDURE infosRecebidos(
	IN idOrdem int,
    OUT infoTipo enum("calibracao", "medicao"),
    OUT infoContratante varchar(60),
    OUT infoEmail varchar(60),
    OUT infoTelefone varchar(11),
    OUT infoCliente varchar(60)
)
BEGIN
	SELECT os.tipo, os.contratante, os.email, os.telefone, c.nomeEmpresa
    INTO infoTipo, infoContratante, infoEmail, infoTelefone, infoCliente
    FROM ordensServico os
    join clientes c
    on os.fk_idCliente = c.pk_idCliente
    WHERE os.pk_idOs = idOrdem;
END // 
DELIMITER ;
CALL infosRecebidos(556, @tipo, @contratante, @email, @telefone, @cliente);
SELECT @tipo AS infoTipo, @contratante AS contratante, @email AS email, @telefone AS telefone, @cliente AS Cliente;


-- inserção de planeza
DELIMITER //
CREATE PROCEDURE criarPlaneza(
	IN novoCMovel1 decimal(6,3),
	IN novoCMovel2 decimal(6,3),
	IN novoCMovel3 decimal(6,3),
	IN novoCFixo1 decimal(6,3),
	IN novoCFixo2 decimal(6,3),
	IN novoCFixo3 decimal(6,3)
)
BEGIN
	INSERT INTO planeza (cMovel1, cMovel2, cMovel3, cFixo1 , cFixo2, cFixo3 )
    VALUES (novoCMovel1, novoCMovel2, novoCMovel3, novoCFixo1, novoCFixo2, novoCFixo3);
END // 
DELIMITER ;
call criarPlaneza(891.222, 892.322, 893.422, 894.522, 895.622, 896.722);


-- alteração de planeza
DELIMITER //
CREATE PROCEDURE modificarPlaneza(
	IN idPlaneza int,
	IN alterarCMovel1 decimal(6,3),
	IN alterarCMovel2 decimal(6,3),
	IN alterarCMovel3 decimal(6,3),
	IN alterarCFixo1 decimal(6,3),
	IN alterarCFixo2 decimal(6,3),
	IN alterarCFixo3 decimal(6,3)
)
BEGIN
	UPDATE planeza
    SET cMovel1 = alterarCMovel1,
	cMovel2 = alterarCMovel2,
	cMovel3 = alterarCMovel3,
	cFixo1 = alterarCFixo1,
	cFixo2 = alterarCFixo2,
	cFixo3 = alterarCFixo3
    WHERE pk_idPlaneza = idPlaneza;
END // 
DELIMITER ;
call modificarPlaneza(3, 1, 2, 3, 4, 5, 6);


-- inserção de paralelismo do micrômetro
DELIMITER //
CREATE PROCEDURE criarParalelismoMicro(
    IN novovalorNominal1 decimal(6,3),
    IN novovalorNominal2 decimal(6,3),
    IN novovalorNominal3 decimal(6,3),
    IN novovalorNominal4 decimal(6,3),
    IN novocMovelcFixo1 decimal(6,3),
    IN novocMovelcFixo2 decimal(6,3),
    IN novocMovelcFixo3 decimal(6,3),
    IN novocMovelcFixo4 decimal(6,3),
    IN novocMovelcFixo5 decimal(6,3),
	IN novocMovelcFixo6 decimal(6,3)
)
BEGIN
	INSERT INTO paralelismoMicro(valorNominal1, valorNominal2, valorNominal3, valorNominal4, cMovelcFixo1, cMovelcFixo2, cMovelcFixo3, cMovelcFixo4, cMovelcFixo5, cMovelcFixo6)
    VALUES (novovalorNominal1, novovalorNominal2, novovalorNominal3, novovalorNominal4, novocMovelcFixo1, novocMovelcFixo2, novocMovelcFixo3, novocMovelcFixo4, novocMovelcFixo5, novocMovelcFixo6);
END // 
DELIMITER ;
call criarParalelismoMicro(1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0);


-- alteração de paralelismo do micrômetro
DELIMITER //
CREATE PROCEDURE modificarParalelismoMicro(
	IN idParalelismo int,
	IN novovalorNominal1 decimal(6,3),
    IN novovalorNominal2 decimal(6,3),
    IN novovalorNominal3 decimal(6,3),
    IN novovalorNominal4 decimal(6,3),
    IN novocMovelcFixo1 decimal(6,3),
    IN novocMovelcFixo2 decimal(6,3),
    IN novocMovelcFixo3 decimal(6,3),
    IN novocMovelcFixo4 decimal(6,3),
    IN novocMovelcFixo5 decimal(6,3),
	IN novocMovelcFixo6 decimal(6,3)
)
BEGIN
	UPDATE paralelismoMicro
    SET valorNominal1 = novovalorNominal1,
    valorNominal2 = novovalorNominal2,
    valorNominal3 = novovalorNominal3,
    valorNominal4 = novovalorNominal4,
    cMovelcFixo1 = novocMovelcFixo1,
    cMovelcFixo2 = novocMovelcFixo2,
    cMovelcFixo3 = novocMovelcFixo3,
    cMovelcFixo4 = novocMovelcFixo4,
    cMovelcFixo5 = novocMovelcFixo5,
	cMovelcFixo6 = novocMovelcFixo6
    WHERE pk_idParalelismoMicro = idParalelismo;
END // 
DELIMITER ;
call modificarParalelismoMicro(1, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9);


-- inserção de controle dimensional
DELIMITER //
CREATE PROCEDURE criarControleDimensional(
	IN novoVp1 decimal(6,3),
    IN novoVp1_1 decimal(6,3),
    IN novoVp1_2 decimal(6,3),
    IN novoVp1_3 decimal(6,3),
    IN novoVp2 decimal(6,3),
    IN novoVp2_1 decimal(6,3),
    IN novoVp2_2 decimal(6,3),
    IN novoVp2_3 decimal(6,3),
    IN novoVp3 decimal(6,3),
    IN novoVp3_1 decimal(6,3),
    IN novoVp3_2 decimal(6,3),
    IN novoVp3_3 decimal(6,3),
    IN novoVp4 decimal(6,3),
    IN novoVp4_1 decimal(6,3),
    IN novoVp4_2 decimal(6,3),
    IN novoVp4_3 decimal(6,3),
    IN novoVp5 decimal(6,3),
    IN novoVp5_1 decimal(6,3),
    IN novoVp5_2 decimal(6,3),
    IN novoVp5_3 decimal(6,3),
    IN novoVp6 decimal(6,3),
    IN novoVp6_1 decimal(6,3),
    IN novoVp6_2 decimal(6,3),
    IN novoVp6_3 decimal(6,3),
    IN novoVp7 decimal(6,3),
    IN novoVp7_1 decimal(6,3),
    IN novoVp7_2 decimal(6,3),
    IN novoVp7_3 decimal(6,3),
    IN novoVp8 decimal(6,3),
    IN novoVp8_1 decimal(6,3),
    IN novoVp8_2 decimal(6,3),
    IN novoVp8_3 decimal(6,3),
    IN novoVp9 decimal(6,3),
    IN novoVp9_1 decimal(6,3),
    IN novoVp9_2 decimal(6,3),
    IN novoVp9_3 decimal(6,3),
    IN novoVp10 decimal(6,3),
    IN novoVp10_1 decimal(6,3),
    IN novoVp10_2 decimal(6,3),
    IN novoVp10_3 decimal(6,3),
    IN novoVp11 decimal(6,3),
    IN novoVp11_1 decimal(6,3),
    IN novoVp11_2 decimal(6,3),
    IN novoVp11_3 decimal(6,3)
)
BEGIN
	INSERT INTO controleDimensional(vp1, vp1_1, vp1_2, vp1_3, vp2, vp2_1, vp2_2, vp2_3, vp3, vp3_1, vp3_2, vp3_3, vp4, vp4_1, vp4_2, vp4_3, vp5, vp5_1, vp5_2, vp5_3, vp6, vp6_1, vp6_2, vp6_3, vp7,vp7_1, vp7_2, vp7_3, vp8, vp8_1, vp8_2, vp8_3, vp9, vp9_1, vp9_2, vp9_3, vp10, vp10_1, vp10_2, vp10_3, vp11, vp11_1, vp11_2, vp11_3)
    VALUES ( novoVp1, novoVp1_1, novoVp1_2, novoVp1_3, novoVp2, novoVp2_1, novoVp2_2, novoVp2_3, novoVp3, novoVp3_1, novoVp3_2, novoVp3_3, novoVp4, novoVp4_1, novoVp4_2, novoVp4_3, novoVp5, novoVp5_1, novoVp5_2, novoVp5_3, novoVp6, novoVp6_1, novoVp6_2, novoVp6_3, novoVp7, novoVp7_1, novoVp7_2, novoVp7_3, novoVp8, novoVp8_1, novoVp8_2, novoVp8_3, novoVp9, novoVp9_1, novoVp9_2, novoVp9_3, novoVp10, novoVp10_1, novoVp10_2, novoVp10_3, novoVp11, novoVp11_1, novoVp11_2, novoVp11_3);
END // 
DELIMITER ;
call criarControleDimensional(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 , 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44);


-- alteração de controle dimensional
DELIMITER //
CREATE PROCEDURE modificarControleDimensional(
	IN idControle int,
	IN alterarVp1 decimal(6,3),
    IN alterarVp1_1 decimal(6,3),
    IN alterarVp1_2 decimal(6,3),
    IN alterarVp1_3 decimal(6,3),
    IN alterarVp2 decimal(6,3),
    IN alterarVp2_1 decimal(6,3),
    IN alterarVp2_2 decimal(6,3),
    IN alterarVp2_3 decimal(6,3),
    IN alterarVp3 decimal(6,3),
    IN alterarVp3_1 decimal(6,3),
    IN alterarVp3_2 decimal(6,3),
    IN alterarVp3_3 decimal(6,3),
    IN alterarVp4 decimal(6,3),
    IN alterarVp4_1 decimal(6,3),
    IN alterarVp4_2 decimal(6,3),
    IN alterarVp4_3 decimal(6,3),
    IN alterarVp5 decimal(6,3),
    IN alterarVp5_1 decimal(6,3),
    IN alterarVp5_2 decimal(6,3),
    IN alterarVp5_3 decimal(6,3),
    IN alterarVp6 decimal(6,3),
    IN alterarVp6_1 decimal(6,3),
    IN alterarVp6_2 decimal(6,3),
    IN alterarVp6_3 decimal(6,3),
    IN alterarVp7 decimal(6,3),
    IN alterarVp7_1 decimal(6,3),
    IN alterarVp7_2 decimal(6,3),
    IN alterarVp7_3 decimal(6,3),
    IN alterarVp8 decimal(6,3),
    IN alterarVp8_1 decimal(6,3),
    IN alterarVp8_2 decimal(6,3),
    IN alterarVp8_3 decimal(6,3),
    IN alterarVp9 decimal(6,3),
    IN alterarVp9_1 decimal(6,3),
    IN alterarVp9_2 decimal(6,3),
    IN alterarVp9_3 decimal(6,3),
    IN alterarVp10 decimal(6,3),
    IN alterarVp10_1 decimal(6,3),
    IN alterarVp10_2 decimal(6,3),
    IN alterarVp10_3 decimal(6,3),
    IN alterarVp11 decimal(6,3),
    IN alterarVp11_1 decimal(6,3),
    IN alterarVp11_2 decimal(6,3),
    IN alterarVp11_3 decimal(6,3)
)
BEGIN
	UPDATE controleDimensional
    SET vp1 = alterarVp1,
    vp1_1 = alterarVp1_1,
    vp1_2 = alterarVp1_2,
    vp1_3 = alterarVp1_3,
    vp2 = alterarVp2,
    vp2_1 = alterarVp2_1,
    vp2_2 = alterarVp2_2,
    vp2_3 = alterarVp2_3,
    vp3 = alterarVp3,
    vp3_1 = alterarVp3_1,
    vp3_2 = alterarVp3_2,
    vp3_3 = alterarVp3_3,
    vp4 = alterarVp4,
    vp4_1 = alterarVp4_1,
    vp4_2 = alterarVp4_2,
    vp4_3 = alterarVp4_3,
    vp5 = alterarVp5,
    vp5_1 = alterarVp5_1,
    vp5_2 = alterarVp5_2,
    vp5_3 = alterarVp5_3,
    vp6 = alterarVp6,
    vp6_1 = alterarVp6_1,
    vp6_2 = alterarVp6_2,
    vp6_3 = alterarVp6_3,
    vp7 = alterarVp7,
    vp7_1 = alterarVp7_1,
    vp7_2 = alterarVp7_2,
    vp7_3 = alterarVp7_3,
    vp8 = alterarVp8,
    vp8_1 = alterarVp8_1,
    vp8_2 = alterarVp8_2,
    vp8_3 = alterarVp8_3,
    vp9 = alterarVp9,
    vp9_1 = alterarVp9_1,
    vp9_2 = alterarVp9_2,
    vp9_3 = alterarVp9_3,
    vp10 = alterarVp10,
    vp10_1 = alterarVp10_1,
    vp10_2 = alterarVp10_2,
    vp10_3 = alterarVp10_3,
    vp11 = alterarVp11,
    vp11_1 = alterarVp11_1,
    vp11_2 = alterarVp11_2,
    vp11_3 = alterarVp11_3
    WHERE pk_idControle = idControle;
END // 
DELIMITER ;
call modificarControleDimensional(1, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);


-- inserção de resultados do micrômetro
DELIMITER //
CREATE PROCEDURE criarResultadosMicrometros(
	IN nrCertificado int,
	IN idControle int,
    IN idPlaneza int,
    IN idParalelismoMicro int,
    IN idInstrumento int,
    IN novoTecnico varchar(60),
    IN novoResponsável varchar(60),
    IN novaFaixaCalibradaNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
    IN novaFaixaCalibradaUni enum("mm", "pol"),
    IN novaDataCalibracao date,
    IN novaInspecao enum("ok", "nok"),
    IN novoTipoEscala enum("analogico", "digital"),
    IN novaVersaoMetodo int,
    IN novoTempInicial decimal(4,2),
    IN novoTempFinal decimal(4,2)
)
BEGIN
	INSERT INTO resultadosMicrometros(pk_idNrCertificado, fk_idControle, fk_idPlaneza, fk_idParalelismoMicro, fk_idInstrumento, fk_idTecnico, fk_idResponsavel, faixaCalibradaNum, faixaCalibradaUni, dataCalibracao, inspecao, tipoEscala, versaoMetodo, tempInicial, tempFinal)
    VALUES (nrCertificado, idControle, idPlaneza, idParalelismoMicro, idInstrumento, novoTecnico, novoResponsável, novaFaixaCalibradaNum, novaFaixaCalibradaUni, novaDataCalibracao, novaInspecao, novoTipoEscala, novaVersaoMetodo,novoTempInicial, novoTempFinal);
END // 
DELIMITER ;
call criarResultadosMicrometros(745, 1, 1, 1, 1, 1, 2, "100-125", "mm", '2024-03-21', "ok", "analogico", 9, 20.70, 20.5);


-- alteração de resultados do micrômetro
DELIMITER //
CREATE PROCEDURE modificarResultadosMicrometros(
	IN antigoNrCertificado int,
    IN alterarNrCertificado int,
	IN idControle int,
    IN idPlaneza int,
    IN idParalelismoMicro int,
    IN idInstrumento int,
    IN alterarTecnico varchar(60),
    IN alterarResponsável varchar(60),
    IN alterarFaixaCalibradaNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
    IN alterarFaixaCalibradaUni enum("mm", "pol"),
    IN alterarDataCalibracao date,
    IN alterarInspecao enum("ok", "nok"),
    IN alterarTipoEscala enum("analogico", "digital"),
    IN alterarVersaoMetodo int,
    IN alterarTempInicial decimal(4,2),
    IN alterarTempFinal decimal(4,2)
)
BEGIN
	UPDATE resultadosMicrometros
    SET pk_idNrCertificado = alterarNrCertificado,
    fk_idControle = idControle,
    fk_idPlaneza = idPlaneza,
    fk_idParalelismoMicro = idParalelismoMicro,
    fk_idInstrumento = idInstrumento,
    fk_idTecnico = alterarTecnico,
    fk_idResponsavel = alterarResponsável,
    faixaCalibradaNum = alterarFaixaCalibradaNum,
    faixaCalibradaUni = alterarFaixaCalibradaUni,
    dataCalibracao = alterarDataCalibracao,
    inspecao = alterarInspecao,
    tipoEscala = alterarTipoEscala,
    versaoMetodo = alterarVersaoMetodo,
    tempInicial = alterarTempInicial,
    tempFinal = alterarTempFinal
    WHERE pk_idNrCertificado = antigoNrCertificado;
END // 
DELIMITER ;
call modificarResultadosMicrometros(745, 750, 1, 1, 1, 1, 1, 2, "125-150", "pol", '2024-03-21', "ok", "analogico", 9, 20.70, 20.5);


-- visualizar informações do certificado
DELIMITER //
CREATE PROCEDURE infoscertificado(
	IN idInstrumento int,
	OUT idOrdem int,
    OUT infoContratante varchar(60),
    
    OUT infoInstrumento varchar(60),
    OUT infoFabricante varchar(60),
    OUT infoNSerie int,
    OUT infoIdentificacaoCliente varchar(50),
    OUT infoFaixaNominalNum enum("0-25", "25-50", "50-75", "75-100", "100-125", "125-150", "150-175", "175-200", "1-25"),
	OUT infoFaixaNominalUni enum("mm", "pol"),
	OUT infoDivisaoResolucaoNum decimal(4,2),
	OUT infoDivisaoResolucaoUni enum("mm", "pol"),
    
    OUT infoCliente varchar(60),
    OUT infoEndereco varchar(100),
	
    OUT infoDataDeRecebimento date
)
BEGIN
	SELECT os.pk_idOs, os.contratante, i.nome, i.fabricante, i.nSerie , i.identificacaoCliente, i.faixaNominalNum, i.faixaNominalUni, i.divisaoResolucaoNum, i.divisaoResolucaoUni, c.nomeEmpresa, c.endereco, r.dataDeRecebimento
    INTO idOrdem, infoContratante, infoInstrumento, infoFabricante, infoNSerie, infoIdentificacaoCliente, infoFaixaNominalNum, infoFaixaNominalUni, infoDivisaoResolucaoNum, infoDivisaoResolucaoUni, infoCliente, infoEndereco, infoDataDeRecebimento
    FROM instrumentos i
    join ordensServico os
    on i.fk_idOs = os.pk_idOs
    join clientes c
    on os.fk_idCliente = c.pk_idCliente
    join recebidos r
    on os.pk_idOs = r.fk_idOs
    WHERE i.pk_idInstrumento = idInstrumento;
END // 
DELIMITER ;
call infoscertificado(1, @idOrdem, @infoContratante, @infoInstrumento, @infoFabricante, @infoNSerie, @infoIdentificacaoCliente, @infoFaixaNominalNum, @infoFaixaNominalUni, @infoDivisaoResolucaoNum, @infoDivisaoResolucaoUni, @infoCliente, @infoEndereco, @infoDataDeRecebimento);
select @idOrdem, @infoContratante, @infoInstrumento, @infoFabricante, @infoNSerie, @infoIdentificacaoCliente, @infoFaixaNominalNum, @infoFaixaNominalUni, @infoDivisaoResolucaoNum, @infoDivisaoResolucaoUni, @infoCliente, @infoEndereco, @infoDataDeRecebimento;


-- inserção de medições internas
DELIMITER //
CREATE PROCEDURE criarMedicaoInterna(
	IN novaPrimeiraMedida decimal(6,3),
    IN novoValorNominal1_1 decimal(6,3),
    IN novoValorNominal1_2 decimal(6,3),
    IN novoValorNominal1_3 decimal(6,3),
    IN novaSegundaMedida decimal(6,3),
    IN novoValorNominal2_1 decimal(6,3),
    IN novoValorNominal2_2 decimal(6,3),
    IN novoValorNominal2_3 decimal(6,3),
    IN novaTerceiraMedida decimal(6,3),
    IN novoValorNominal3_1 decimal(6,3),
    IN novoValorNominal3_2 decimal(6,3),
    IN novoValorNominal3_3 decimal(6,3)
)
BEGIN
	INSERT INTO medicoesInternas(primeiraMedida, valorNominal1_1, valorNominal1_2, valorNominal1_3, segundaMedida, valorNominal2_1, valorNominal2_2, valorNominal2_3, terceiraMedida, valorNominal3_1, valorNominal3_2, valorNominal3_3)
    VALUES (novaPrimeiraMedida, novoValorNominal1_1, novoValorNominal1_2, novoValorNominal1_3, novaSegundaMedida, novoValorNominal2_1, novoValorNominal2_2, novoValorNominal2_3, novaTerceiraMedida, novoValorNominal3_1, novoValorNominal3_2, novoValorNominal3_3);
END // 
DELIMITER ;
call criarMedicaoInterna(1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0, 1.1, 2.2, 3.3);


-- alteração de mdeições internas
DELIMITER //
CREATE PROCEDURE alterarMedicoesInternas(
    IN idMedicaoInterna INT,
    IN alterarPrimeiraMedida DECIMAL(6,3),
    IN alterarValorNominal1_1 DECIMAL(6,3),
    IN alterarValorNominal1_2 DECIMAL(6,3),
    IN alterarValorNominal1_3 DECIMAL(6,3),
    IN alterarSegundaMedida DECIMAL(6,3),
    IN alterarValorNominal2_1 DECIMAL(6,3),
    IN alterarValorNominal2_2 DECIMAL(6,3),
    IN alterarValorNominal2_3 DECIMAL(6,3),
    IN alterarTerceiraMedida DECIMAL(6,3),
    IN alterarValorNominal3_1 DECIMAL(6,3),
    IN alterarValorNominal3_2 DECIMAL(6,3),
    IN alterarValorNominal3_3 DECIMAL(6,3)
)
BEGIN
    UPDATE medicoesinternas
    SET primeiraMedida = alterarPrimeiraMedida,
        valorNominal1_1 = alterarValorNominal1_1,
        valorNominal1_2 = alterarValorNominal1_2,
        valorNominal1_3 = alterarValorNominal1_3,
        segundaMedida = alterarSegundaMedida,
        valorNominal2_1 = alterarValorNominal2_1,
        valorNominal2_2 = alterarValorNominal2_2,
        valorNominal2_3 = alterarValorNominal2_3,
        terceiraMedida = alterarTerceiraMedida,
        valorNominal3_1 = alterarValorNominal3_1,
        valorNominal3_2 = alterarValorNominal3_2,
        valorNominal3_3 = alterarValorNominal3_3
    WHERE pk_idMedicaointerna = idMedicaoInterna;
END //
DELIMITER ;
CALL alterarMedicoesInternas(1, 10.5, 10.2, 10.3, 10.4, 20.5, 20.2, 20.3, 20.4, 30.5, 30.2, 30.3, 30.4);


-- inserção de medições de ressaltos
DELIMITER //
CREATE PROCEDURE inserirMedicoesRessaltos(
    IN novaPrimeiraMedida DECIMAL(6,3),
    IN novoValorNominal1_1 DECIMAL(6,3),
    IN novoValorNominal1_2 DECIMAL(6,3),
    IN novoValorNominal1_3 DECIMAL(6,3),
    IN novaSegundaMedida DECIMAL(6,3),
    IN novoValorNominal2_1 DECIMAL(6,3),
    IN novoValorNominal2_2 DECIMAL(6,3),
    IN novoValorNominal2_3 DECIMAL(6,3),
    IN novaTerceiraMedida DECIMAL(6,3),
    IN novoValorNominal3_1 DECIMAL(6,3),
    IN novoValorNominal3_2 DECIMAL(6,3),
    IN novoValorNominal3_3 DECIMAL(6,3)
)
BEGIN
    INSERT INTO medicoesRessaltos (primeiraMedida, valorNominal1_1, valorNominal1_2, valorNominal1_3, segundaMedida, valorNominal2_1, valorNominal2_2, valorNominal2_3, terceiraMedida, valorNominal3_1, valorNominal3_2, valorNominal3_3)
    VALUES (novaPrimeiraMedida, novoValorNominal1_1, novoValorNominal1_2, novoValorNominal1_3, novaSegundaMedida, novoValorNominal2_1, novoValorNominal2_2, novoValorNominal2_3, novaTerceiraMedida, novoValorNominal3_1, novoValorNominal3_2, novoValorNominal3_3);
END //
DELIMITER ;
CALL inserirMedicoesRessaltos(10.5, 10.2, 10.3, 10.4, 20.5, 20.2, 20.3, 20.4, 30.5, 30.2, 30.3, 30.4);


-- alteração de medições de ressaltos
DELIMITER //
CREATE PROCEDURE alterarMedicoesRessaltos(
    IN idMedicaoRessalto INT,
    IN novaPrimeiraMedida DECIMAL(6,3),
    IN novoValorNominal1_1 DECIMAL(6,3),
    IN novoValorNominal1_2 DECIMAL(6,3),
    IN novoValorNominal1_3 DECIMAL(6,3),
    IN novaSegundaMedida DECIMAL(6,3),
    IN novoValorNominal2_1 DECIMAL(6,3),
    IN novoValorNominal2_2 DECIMAL(6,3),
    IN novoValorNominal2_3 DECIMAL(6,3),
    IN novaTerceiraMedida DECIMAL(6,3),
    IN novoValorNominal3_1 DECIMAL(6,3),
    IN novoValorNominal3_2 DECIMAL(6,3),
    IN novoValorNominal3_3 DECIMAL(6,3)
)
BEGIN
    UPDATE medicoesRessaltos
    SET primeiraMedida = novaPrimeiraMedida,
        valorNominal1_1 = novoValorNominal1_1,
        valorNominal1_2 = novoValorNominal1_2,
        valorNominal1_3 = novoValorNominal1_3,
        segundaMedida = novaSegundaMedida,
        valorNominal2_1 = novoValorNominal2_1,
        valorNominal2_2 = novoValorNominal2_2,
        valorNominal2_3 = novoValorNominal2_3,
        terceiraMedida = novaTerceiraMedida,
        valorNominal3_1 = novoValorNominal3_1,
        valorNominal3_2 = novoValorNominal3_2,
        valorNominal3_3 = novoValorNominal3_3
    WHERE pk_idMedicaoRessalto = idMedicaoRessalto;
END //
DELIMITER ;
CALL alterarMedicoesRessaltos(1, 5.1, 10.2, 10.3, 10.4, 20.5, 20.2, 20.3, 20.4, 30.5, 30.2, 30.3, 30.4);


-- Inserção de medições de profundidades
DELIMITER //
CREATE PROCEDURE inserirMedicaoProfundidade(
    IN nova_primeiraMedida DECIMAL(6,3),
    IN novo_valorNominal1_1 DECIMAL(6,3),
    IN novo_valorNominal1_2 DECIMAL(6,3),
    IN novo_valorNominal1_3 DECIMAL(6,3),
    IN nova_segundaMedida DECIMAL(6,3),
    IN novo_valorNominal2_1 DECIMAL(6,3),
    IN novo_valorNominal2_2 DECIMAL(6,3),
    IN novo_valorNominal2_3 DECIMAL(6,3),
    IN nova_terceiraMedida DECIMAL(6,3),
    IN novo_valorNominal3_1 DECIMAL(6,3),
    IN novo_valorNominal3_2 DECIMAL(6,3),
    IN novo_valorNominal3_3 DECIMAL(6,3)
)
BEGIN
    INSERT INTO medicoesProfundidades (primeiraMedida, valorNominal1_1, valorNominal1_2, valorNominal1_3, segundaMedida, valorNominal2_1, valorNominal2_2, valorNominal2_3, terceiraMedida, valorNominal3_1, valorNominal3_2, valorNominal3_3)
    VALUES (nova_primeiraMedida, novo_valorNominal1_1, novo_valorNominal1_2, novo_valorNominal1_3, nova_segundaMedida, novo_valorNominal2_1, novo_valorNominal2_2, novo_valorNominal2_3, nova_terceiraMedida, novo_valorNominal3_1, novo_valorNominal3_2, novo_valorNominal3_3);
END//
DELIMITER ;
CALL inserirMedicaoProfundidade(1.5, 1.6, 1.7, 1.8, 2.5, 2.6, 2.7, 2.8, 3.5, 3.6, 3.7, 3.8);


-- Alteração de medições de profundidades
DELIMITER //
CREATE PROCEDURE alterarMedicaoProfundidade(
    IN idMedicao INT,
    IN nova_primeiraMedida DECIMAL(6,3),
    IN novo_valorNominal1_1 DECIMAL(6,3),
    IN novo_valorNominal1_2 DECIMAL(6,3),
    IN novo_valorNominal1_3 DECIMAL(6,3),
    IN nova_segundaMedida DECIMAL(6,3),
    IN novo_valorNominal2_1 DECIMAL(6,3),
    IN novo_valorNominal2_2 DECIMAL(6,3),
    IN novo_valorNominal2_3 DECIMAL(6,3),
    IN nova_terceiraMedida DECIMAL(6,3),
    IN novo_valorNominal3_1 DECIMAL(6,3),
    IN novo_valorNominal3_2 DECIMAL(6,3),
    IN novo_valorNominal3_3 DECIMAL(6,3)
)
BEGIN
    UPDATE medicoesProfundidades
    SET primeiraMedida = nova_primeiraMedida,
        valorNominal1_1 = novo_valorNominal1_1,
        valorNominal1_2 = novo_valorNominal1_2,
        valorNominal1_3 = novo_valorNominal1_3,
        segundaMedida = nova_segundaMedida,
        valorNominal2_1 = novo_valorNominal2_1,
        valorNominal2_2 = novo_valorNominal2_2,
        valorNominal2_3 = novo_valorNominal2_3,
        terceiraMedida = nova_terceiraMedida,
        valorNominal3_1 = novo_valorNominal3_1,
        valorNominal3_2 = novo_valorNominal3_2,
        valorNominal3_3 = novo_valorNominal3_3
    WHERE pk_idMedicaoProfundidade = idMedicao;
END//
DELIMITER ;
CALL alterarMedicaoProfundidade(1, 2.0, 2.1, 2.2, 2.3, 3.0, 3.1, 3.2, 3.3, 4.0, 4.1, 4.2, 4.3);


-- Inserção de paralelismo do PAQUÍMETRO
DELIMITER //
CREATE PROCEDURE inserirParalelismoPaq(
    IN novoValorNominalOrelha decimal(6,3),
    IN novoValorProxOrelha1 decimal(6,3),
    IN novoValorProxOrelha2 decimal(6,3),
    IN novoValorProxOrelha3 decimal(6,3),
    IN novoValorAfasOrelha1 decimal(6,3),
    IN novoValorAfasOrelha2 decimal(6,3),
    IN novoValorAfasOrelha3 decimal(6,3),
    IN novoValorNominalBico decimal(6,3),
    IN novoValorProxBico1 decimal(6,3),
    IN novoValorProxBico2 decimal(6,3),
    IN novoValorProxBico3 decimal(6,3),
    IN novoValorAfasBico1 decimal(6,3),
    IN novoValorAfasBico2 decimal(6,3),
    IN novoValorAfasBico3 decimal(6,3)
)
BEGIN
    INSERT INTO paralelismoPaq (valorNominalOrelha, valorProxOrelha1, valorProxOrelha2, valorProxOrelha3, valorAfasOrelha1, valorAfasOrelha2, valorAfasOrelha3, valorNominalBico, valorProxBico1, valorProxBico2, valorProxBico3, valorAfasBico1, valorAfasBico2, valorAfasBico3)
    VALUES (novoValorNominalOrelha, novoValorProxOrelha1, novoValorProxOrelha2, novoValorProxOrelha3, novoValorAfasOrelha1, novoValorAfasOrelha2, novoValorAfasOrelha3, novoValorNominalBico, novoValorProxBico1, novoValorProxBico2, novoValorProxBico3, novoValorAfasBico1, novoValorAfasBico2, novoValorAfasBico3);
END//
DELIMITER ;
CALL inserirParalelismoPaq(1.5, 1.6, 1.7, 1.8, 2.5, 2.6, 2.7, 2.8, 2.9, 9.9, 1.2, 2.2, 3.6, 7.4);


-- Alteração de paralelismo do paq
DELIMITER //
CREATE PROCEDURE alterarParalelismoPaq(
    idParalelismo INT,
    IN alterarValorNominalOrelha decimal(6,3),
    IN alterarValorProxOrelha1 decimal(6,3),
    IN alterarValorProxOrelha2 decimal(6,3),
    IN alterarValorProxOrelha3 decimal(6,3),
    IN alterarValorAfasOrelha1 decimal(6,3),
    IN alterarValorAfasOrelha2 decimal(6,3),
    IN alterarValorAfasOrelha3 decimal(6,3),
    IN alterarValorNominalBico decimal(6,3),
    IN alterarValorProxBico1 decimal(6,3),
    IN alterarValorProxBico2 decimal(6,3),
    IN alterarValorProxBico3 decimal(6,3),
    IN alterarValorAfasBico1 decimal(6,3),
    IN alterarValorAfasBico2 decimal(6,3),
    IN alterarValorAfasBico3 decimal(6,3)
)
BEGIN
    UPDATE paralelismoPaq
    SET valorNominalOrelha = alterarValorNominalOrelha,
    valorProxOrelha1 = alterarValorProxOrelha1,
    valorProxOrelha2 = alterarValorProxOrelha2,
    valorProxOrelha3 = alterarValorProxOrelha3,
    valorAfasOrelha1 = alterarValorAfasOrelha1,
    valorAfasOrelha2 = alterarValorAfasOrelha2,
    valorAfasOrelha3 = alterarValorAfasOrelha3,
    valorNominalBico = alterarValorNominalBico,
    valorProxBico1 = alterarValorProxBico1,
    valorProxBico2 = alterarValorProxBico2,
    valorProxBico3 = alterarValorProxBico3,
    valorAfasBico1 = alterarValorAfasBico1,
    valorAfasBico2 = alterarValorAfasBico2,
    valorAfasBico3 = alterarValorAfasBico3
    WHERE pk_idParalelismoPaq = idParalelismo;
END//
DELIMITER ;
CALL alterarParalelismoPaq(1, 5.1, 1.6, 1.7, 1.8, 2.5, 2.6, 2.7, 2.8, 2.9, 9.9, 1.2, 2.2, 3.6, 7.4);


-- Inserção de medições externas
DELIMITER //
CREATE PROCEDURE inserirMedicoesExternas(
	IN novoVn1 decimal(6,3),
    IN novoVn1_1 decimal(6,3),
    IN novoVn1_2 decimal(6,3),
    IN novoVn1_3 decimal(6,3),
    IN novoVn2 decimal(6,3),
    IN novoVn2_1 decimal(6,3),
    IN novoVn2_2 decimal(6,3),
    IN novoVn2_3 decimal(6,3),
    IN novoVn3 decimal(6,3),
    IN novoVn3_1 decimal(6,3),
    IN novoVn3_2 decimal(6,3),
    IN novoVn3_3 decimal(6,3),
    IN novoVn4 decimal(6,3),
    IN novoVn4_1 decimal(6,3),
    IN novoVn4_2 decimal(6,3),
    IN novoVn4_3 decimal(6,3),
    IN novoVn5 decimal(6,3),
    IN novoVn5_1 decimal(6,3),
    IN novoVn5_2 decimal(6,3),
    IN novoVn5_3 decimal(6,3),
    IN novoVn6 decimal(6,3),
    IN novoVn6_1 decimal(6,3),
    IN novoVn6_2 decimal(6,3),
    IN novoVn6_3 decimal(6,3),
    IN novoVn7 decimal(6,3),
    IN novoVn7_1 decimal(6,3),
    IN novoVn7_2 decimal(6,3),
    IN novoVn7_3 decimal(6,3),
    IN novoVnExtra1 decimal(6,3),
    IN novoVnExtra1_1 decimal(6,3),
    IN novoVnExtra1_2 decimal(6,3),
    IN novoVnExtra1_3 decimal(6,3),
    IN novoVnExtra2 decimal(6,3),
    IN novoVnExtra2_1 decimal(6,3),
    IN novoVnExtra2_2 decimal(6,3),
    IN novoVnExtra2_3 decimal(6,3),
    IN novoVnExtra3 decimal(6,3),
    IN novoVnExtra3_1 decimal(6,3),
    IN novoVnExtra3_2 decimal(6,3),
    IN novoVnExtra3_3 decimal(6,3)
)
BEGIN
    INSERT INTO medicoesExternas (vn1, vn1_1, vn1_2, vn1_3, vn2, vn2_1, vn2_2, vn2_3, vn3, vn3_1, vn3_2, vn3_3, vn4, vn4_1, vn4_2, vn4_3, vn5, vn5_1, vn5_2, vn5_3, vn6, vn6_1, vn6_2, vn6_3, vn7, vn7_1, vn7_2, vn7_3, vnExtra1, vnExtra1_1, vnExtra1_2, vnExtra1_3, vnExtra2, vnExtra2_1, vnExtra2_2, vnExtra2_3, vnExtra3, vnExtra3_1, vnExtra3_2, vnExtra3_3)
    VALUES (novoVn1, novoVn1_1, novoVn1_2, novoVn1_3, novoVn2, novoVn2_1, novoVn2_2, novoVn2_3, novoVn3, novoVn3_1, novoVn3_2, novoVn3_3, novoVn4, novoVn4_1, novoVn4_2, novoVn4_3, novoVn5, novoVn5_1, novoVn5_2, novoVn5_3, novoVn6, novoVn6_1, novoVn6_2, novoVn6_3, novoVn7, novoVn7_1, novoVn7_2, novoVn7_3, novoVnExtra1, novoVnExtra1_1, novoVnExtra1_2, novoVnExtra1_3, novoVnExtra2, novoVnExtra2_1, novoVnExtra2_2, novoVnExtra2_3, novoVnExtra3, novoVnExtra3_1, novoVnExtra3_2, novoVnExtra3_3);
END//
DELIMITER ;
CALL inserirMedicoesExternas(1, 0.1, 0.2, 0.3, 2, 1.3, 1.4, 1.5, 3, 1.4, 1.5, 1.6, 4, 20.0, 20.1, 20.2, 5, 50.0, 50.1, 50.2, 6, 100.0, 100.1, 100.2, 7, 150.0, 150.1, 150.2, 8, 10.0, 10.1, 10.2, 9, 20.0, 20.1, 20.2, 10, 30.0, 30.1, 30.2);


-- Alteração de medições externas
DELIMITER //
CREATE PROCEDURE alterarMedicoesExternas(
	IN idMedicaoExterna int,
	IN alterarVn1 decimal(6,3),
    IN alterarVn1_1 decimal(6,3),
    IN alterarVn1_2 decimal(6,3),
    IN alterarVn1_3 decimal(6,3),
    IN alterarVn2 decimal(6,3),
    IN alterarVn2_1 decimal(6,3),
    IN alterarVn2_2 decimal(6,3),
    IN alterarVn2_3 decimal(6,3),
    IN alterarVn3 decimal(6,3),
    IN alterarVn3_1 decimal(6,3),
    IN alterarVn3_2 decimal(6,3),
    IN alterarVn3_3 decimal(6,3),
    IN alterarVn4 decimal(6,3),
    IN alterarVn4_1 decimal(6,3),
    IN alterarVn4_2 decimal(6,3),
    IN alterarVn4_3 decimal(6,3),
    IN alterarVn5 decimal(6,3),
    IN alterarVn5_1 decimal(6,3),
    IN alterarVn5_2 decimal(6,3),
    IN alterarVn5_3 decimal(6,3),
    IN alterarVn6 decimal(6,3),
    IN alterarVn6_1 decimal(6,3),
    IN alterarVn6_2 decimal(6,3),
    IN alterarVn6_3 decimal(6,3),
    IN alterarVn7 decimal(6,3),
    IN alterarVn7_1 decimal(6,3),
    IN alterarVn7_2 decimal(6,3),
    IN alterarVn7_3 decimal(6,3),
    IN alterarVnExtra1 decimal(6,3),
    IN alterarVnExtra1_1 decimal(6,3),
    IN alterarVnExtra1_2 decimal(6,3),
    IN alterarVnExtra1_3 decimal(6,3),
    IN alterarVnExtra2 decimal(6,3),
    IN alterarVnExtra2_1 decimal(6,3),
    IN alterarVnExtra2_2 decimal(6,3),
    IN alterarVnExtra2_3 decimal(6,3),
    IN alterarVnExtra3 decimal(6,3),
    IN alterarVnExtra3_1 decimal(6,3),
    IN alterarVnExtra3_2 decimal(6,3),
    IN alterarVnExtra3_3 decimal(6,3)
)
BEGIN
    UPDATE medicoesExternas
    SET vn1 = alterarVn1,
    vn1_1 = alterarVn1_1,
    vn1_2 = alterarVn1_2,
    vn1_3 = alterarVn1_3,
    vn2 = alterarVn2,
    vn2_1 = alterarVn2_1,
    vn2_2 = alterarVn2_2,
    vn2_3 = alterarVn2_3,
    vn3 = alterarVn3,
    vn3_1 = alterarVn3_1,
    vn3_2 = alterarVn3_2,
    vn3_3 = alterarVn3_3,
    vn4 = alterarVn4,
    vn4_1 = alterarVn4_1,
    vn4_2 = alterarVn4_2,
    vn4_3 = alterarVn4_3,
    vn5 = alterarVn5,
    vn5_1 = alterarVn5_1,
    vn5_2 = alterarVn5_2,
    vn5_3 = alterarVn5_3,
    vn6 = alterarVn6,
    vn6_1 = alterarVn6_1,
    vn6_2 = alterarVn6_2,
    vn6_3 = alterarVn6_3,
    vn7 = alterarVn7,
    vn7_1 = alterarVn7_1,
    vn7_2 = alterarVn7_2,
    vn7_3 = alterarVn7_3,
    vn1 = alterarVnExtra1,
    vn1_1 = alterarVnExtra1_1,
    vn1_2 = alterarVnExtra1_2,
    vn1_3 = alterarVnExtra1_3,
    vn2 = alterarVnExtra2,
    vn2_1 = alterarVnExtra2_1,
    vn2_2 = alterarVnExtra2_2,
    vn2_3 = alterarVnExtra2_3,
    vn3 = alterarVnExtra3,
    vn3_1 = alterarVnExtra3_1,
    vn3_2 = alterarVnExtra3_2,
    vn3_3 = alterarVnExtra3_3
    WHERE pk_idMedicaoExterna = idMedicaoExterna;
END//
DELIMITER ;
CALL alterarMedicoesExternas(1, 1, 0.1, 0.2, 0.3, 2, 1.3, 1.4, 1.5, 3, 1.4, 1.5, 1.6, 4, 20.0, 20.1, 20.2, 5, 50.0, 50.1, 50.2, 6, 100.0, 100.1, 100.2, 7, 150.0, 150.1, 150.2, 8, 10.0, 10.1, 10.2, 9, 20.0, 20.1, 20.2, 10, 30.0, 30.1, 30.2);


-- inserção de resultados dos paquímetros 
DELIMITER //
CREATE PROCEDURE criarResultadosPaquimetro(
	IN nrCertificado int,
	IN idInstrumento int,
    IN idParalelismoPaq int,
    IN idMedExterna int,
    IN idMedInterna int,
    IN idMedRessalto int,
    IN idMedProfundidade int,
    IN novoTecnico int,
    IN novoResponsável int,
    IN novaDataCalibracao date,
    IN novaInspecao enum("ok", "nok"),
    IN novoTipoEscala enum("analogico", "digital"),
    IN novaVersaoMetodo int,
    IN novoTempInicial decimal(4,2),
    IN novoTempFinal decimal(4,2)
)
BEGIN
	INSERT INTO resultadosPaquimetros(pk_idNrCertificado, fk_idInstrumento, fk_idParalelismoPaq, fk_idMedicaoExterna, fk_idMedicaointerna, fk_idMedicaoRessalto, fk_idMedicaoProfundidade, fk_idTecnico, fk_idResponsavel, dataCalibracao, inspecao, tipoEscala, versaoMetodo, tempInicial, tempFinal)
    VALUES (nrCertificado, idInstrumento, idParalelismoPaq, idMedExterna, idMedInterna, idMedRessalto, idMedProfundidade, novoTecnico, novoResponsável, novaDataCalibracao, novaInspecao, novoTipoEscala, novaVersaoMetodo, novoTempInicial, novoTempFinal);
END // 
DELIMITER ;
call criarResultadosPaquimetro(322, 1, 1, 1, 1, 1, 1, 1, 2, '2024-03-25', "ok", "digital", 9, 22.5, 22);


-- alteração de resultados dos paquímetros
DELIMITER //
CREATE PROCEDURE modificarResultadosPaquimetro(
	IN antigoNrCertificado int,
    IN alterarNrCertificado int,
	IN idInstrumento int,
    IN idParalelismoPaq int,
    IN idMedExterna int,
    IN idMedInterna int,
    IN idMedRessalto int,
    IN idMedProfundidade int,
    IN alterarTecnico int,
    IN alterarResponsável int,
    IN alterarDataCalibracao date,
    IN alterarInspecao enum("ok", "nok"),
    IN alterarTipoEscala enum("analogico", "digital"),
    IN alterarVersaoMetodo int,
    IN alterarTempInicial decimal(4,2),
    IN alterarTempFinal decimal(4,2)
)
BEGIN
	UPDATE resultadosPaquimetros
    SET pk_idNrCertificado = alterarNrCertificado,
    fk_idInstrumento = idInstrumento,
    fk_idParalelismoPaq = idParalelismoPaq,
    fk_idMedicaoExterna = idMedExterna,
    fk_idMedicaoInterna = idMedInterna,
    fk_idMedicaoRessalto = idMedRessalto,
    fk_idMedicaoProfundidade = idMedProfundidade,
    fk_idTecnico = alterarTecnico,
    fk_idResponsavel = alterarResponsável,
    dataCalibracao = alterarDataCalibracao,
    inspecao = alterarInspecao,
    tipoEscala = alterarTipoEscala,
    versaoMetodo = alterarVersaoMetodo,
    tempInicial = alterarTempInicial,
    tempFinal = alterarTempFinal
    WHERE pk_idNrCertificado = antigoNrCertificado;
END // 
DELIMITER ;
call modificarResultadosPaquimetro(322, 350, 1, 1, 1, 1, 1, 1, 1, 2, '2024-03-25', "nok", "analogico", 9, 22.5, 22);


-- cadastro de peças
DELIMITER //
CREATE PROCEDURE cadastrarPeca (
    IN idOs int,
    IN idCliente int,
    IN novoNome varchar(60),
    IN novoMaterial varchar(60),
    IN novoNDesenho int,
    IN novaDescricao varchar(300)
)
BEGIN
    INSERT INTO pecas (fk_idOs, fk_idCliente, nome, material, nDesenho, descricao)
    VALUES (idOs, idCliente, novoNome, novoMaterial, novoNDesenho, novaDescricao);
END //
DELIMITER ;
call cadastrarPeca(665, 1, 'Paraconfuso', 'Ferro', 12345, 'Parafuso ta torto para a esquerda, naquele pique');
call cadastrarPeca(665, 1, 'Prego macaco', 'Aço inox', 54321, 'Prego macaco não ta perfurando a madeira direito');


-- alteraçao de peças
DELIMITER //
CREATE PROCEDURE alterarPeca (
    IN idPeca int,
    IN idOs int,
    IN idCliente int,
    IN alterarNome varchar(60),
    IN alterarMaterial varchar(60),
    IN alterarNDesenho int,
    IN alterarDescricao varchar(300)
)
BEGIN
    UPDATE pecas
    SET fk_idOs = idOs,
    fk_idCliente = idCliente,
    nome = alterarNome,
    material = alterarMaterial,
    nDesenho = alterarNDesenho,
    descricao = alterarDescricao
    WHERE pk_idPeca = idPeca;
END //
DELIMITER ;
call alterarPeca(1, 665, 1, 'Parafuso', 'Metal', 12345, 'Parafuso ta torto');


-- visualização das peças
DELIMITER //
CREATE PROCEDURE infosPeca(
	IN idPeca int,
    OUT idOrdem int,
    OUT idCliente int,
    OUT infoNome varchar(60),
	OUT infoMaterial varchar(60),
    OUT infonDesenho int,
    OUT infoDescricao varchar(300)
)
BEGIN
	SELECT fk_idOs, fk_idCliente, nome, material, nDesenho, descricao
    INTO idOrdem, idCliente, infoNome, infoMaterial, infonDesenho, infoDescricao
    FROM pecas
    WHERE pk_idPeca = idPeca;
END //
DELIMITER ;
call infosPeca(1, @idOrdem, @idCliente, @infoNome, @infoMaterial, @infonDesenho, @infoDescricao);
SELECT @idOrdem AS OrdemDeServiço, @idCliente AS Cliente, @infoNome AS Peça, @infoMaterial AS Material, @infonDesenho AS NumDesenho, @infoDescricao AS Descrição;


-- criação de relatório
DELIMITER //
CREATE PROCEDURE criarRelatorio (
	IN idRelatorio int,
    IN idInstrumento int,
    IN idUsuario int,
    IN idPeca int,
    IN novoInicio time,
    IN novoTermino time,
    IN novoTempoTotal time,
    IN novoTemperaturaC varchar(20),
    IN novaUmidadeRelativa varchar(20),
    IN novoObservacoes varchar(300),
    IN novoLocalDaMedicao varchar(100),
    IN novoDia date,
    IN novaAssinatura varchar(100)
)
BEGIN
    INSERT INTO relatorio (pk_idRelatorio, fk_idInstrumento, fk_idUsuario, fk_idPeca, inicio, termino, tempoTotal, temperaturaC, umidadeRelativa, observacoes, localDaMedicao, dia, assinatura)
    VALUES (idRelatorio, idInstrumento, idUsuario, idPeca, novoInicio, novoTermino, novoTempoTotal, novoTemperaturaC, novaUmidadeRelativa, novoObservacoes, novoLocalDaMedicao, novoDia, novaAssinatura);
END //
DELIMITER ;
call criarRelatorio(22, 1, 1, 1, '09:00', '17:00', '26:00', '25°C', '50%', 'Nenhuma observação', 'Laboratório A', '2024-03-24', 'Assinatura do técnico');


-- alteração de relatório
DELIMITER //
CREATE PROCEDURE modificarRelatorio(
	IN antigoIdRelatorio int,
	IN alterarIdRelatorio int,
    IN idInstrumento int,
    IN idUsuario int,
    IN idPeca int,
    IN alterarInicio time,
    IN alterarTermino time,
    IN alterarTempoTotal time,
    IN alterarTemperaturaC varchar(20),
    IN alterarUmidadeRelativa varchar(20),
    IN alterarObservacoes varchar(300),
    IN alterarLocalDaMedicao varchar(100),
    IN alterarDia date,
    IN alterarAssinatura varchar(100)
)
BEGIN
	UPDATE relatorio
    SET pk_idRelatorio = alterarIdRelatorio,
    fk_idInstrumento = idInstrumento,
    fk_idUsuario = idUsuario,
    fk_idPeca = idPeca,
    inicio = alterarInicio,
    termino = alterarTermino,
    tempoTotal = alterarTempoTotal,
    temperaturaC = alterarTemperaturaC,
    umidadeRelativa = alterarUmidadeRelativa,
    observacoes = alterarObservacoes,
    localDaMedicao = alterarLocalDaMedicao,
    dia = alterarDia,
    assinatura = alterarAssinatura
    WHERE pk_idRelatorio = antigoIdRelatorio;
END // 
DELIMITER ;
call modificarRelatorio(22, 32, 1, 1, 1, '10:00', '18:00', '8:00', '25°C', '50%', 'Nenhuma observação', 'Laboratório A', '2024-03-24', 'Assinatura do técnico');

-- retornar informações do relatório
DELIMITER //
CREATE PROCEDURE infosRelatorio(
	IN idPeca int,
    OUT infoUsuario varchar(60),
    OUT infoPeca varchar(60),
    OUT infoMaterial varchar(60),
    OUT infoNDesenho int,
    OUT infoDescricao varchar(300)
)
BEGIN
	SELECT u.nome, p.nome, p.material, p.nDesenho, p.descricao
    INTO infoUsuario, infoPeca, infoMaterial, infoNDesenho, infoDescricao
    FROM pecas p
    join ordensServico os
    on p.fk_idOs = os.pk_idOs
    join usuarios u
    on os.fk_idUsuario = u.pk_idUsuario
    WHERE p.pk_idPeca = idPeca;
END //
DELIMITER ;
call infosRelatorio(1, @infoUsuario, @infoPeca, @infoMaterial, @infoNDesenho, @infoDescricao);
SELECT @infoUsuario AS Usuario, @infoPeca AS Peça, @infoMaterial AS Material, @infoNDesenho AS NumDesenho, @infoDescricao AS Descricao;
