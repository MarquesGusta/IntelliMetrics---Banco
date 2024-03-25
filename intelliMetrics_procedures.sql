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
select * from usuarios;


-- redefinição de senha
DELIMITER //
CREATE PROCEDURE redefinirSenha(
	IN emailUsuario varchar(60),
	IN novaSenha varchar(10)
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
select * from clientes;


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
select * from ordensServico;
drop procedure criarOrdens;


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
call modificarOrdem(556, 45, 1, 1, "banana", "medicao", "cabou banana", '2024-04-27', "Bill Gates", "gatesbill@gmail.com", 11902345567);
select * from ordensServico;


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
call concluirOrdem(45);


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
call desmarcarOrdemComoConcluida(45);


-- criação de categorias
DELIMITER //
CREATE PROCEDURE criarCategoria(
	IN novaCategoria varchar(30)
)
BEGIN
	INSERT INTO categorias(nome) VALUES (novaCategoria);
END // 
DELIMITER ;
call criarCategoria("abidas");
select * from categorias;


-- alteração de categorias
DELIMITER //
CREATE PROCEDURE modificarCategoria(
	IN categoriaAlterda int,
	IN alterarNome varchar(30)
)
BEGIN
	UPDATE categorias
    SET nome = alterarNome
    WHERE pk_idCategoria = categoriaAlterda;
END // 
DELIMITER ;
call modificarCategoria(1, "neki");


-- criação de tipos
DELIMITER //
CREATE PROCEDURE criarTipo(
    IN idCategoria int,
    IN novoTipo varchar(30)
)
BEGIN
    INSERT INTO tipos(fk_idCategoria, nome) VALUES (idCategoria, novoTipo);
END //
DELIMITER ;
call criarTipo(1, "tenis");
select * from tipos;



-- alteração de tipos
DELIMITER //
CREATE PROCEDURE modificarTipo(
    IN idTipo int,
    IN alterarCategoria int,
    IN alterarTipo varchar(30)
)
BEGIN
    UPDATE tipos
    SET fk_idCategoria = alterarCategoria,
    nome = alterarTipo
    WHERE pk_idTipo = idTipo;
END //
DELIMITER ;
call modificarTipo(1, 1, "sapatu");



-- cadastro de instrumentos
DELIMITER //
CREATE PROCEDURE cadastrarInstrumento(
    IN idCliente int,
    IN idOrdem int,
    IN idTipo int,
    IN novoNSerie int,
    IN novaIdentificacaoCliente int,
    IN novoFabricante varchar(60),
	IN novaFaixaNominalNum decimal(4,2),
    IN novaFaixaNominalUnidade enum('mm', 'pol'),
    IN novaDivisaoNum decimal(4,2),
    IN novaDivisaoUni enum('mm', 'pol')
)
BEGIN
    INSERT INTO instrumentos(fk_idCliente, fk_idOs, fk_idTipo, nSerie, identificacaoCliente, fabricante, faixaNominalNum, faixaNominalUni, divisaoResolucaoNum, divisaoResolucaoUni)
    VALUES (idCliente, idOrdem, idTipo, novoNSerie, novaIdentificacaoCliente, novoFabricante, novaFaixaNominalNum, novaFaixaNominalUnidade, novaDivisaoNum, novaDivisaoUni);
END //
DELIMITER ;
call cadastrarInstrumento(1, 556, 1, 112233, 1222333,  "Martelos e machados", 1.2, "mm", 2.43, "mm");
select * from instrumentos;


-- alteraçao de instrumentos
DELIMITER //
CREATE PROCEDURE modificarInstrumento(
    IN idInstrumento INT,
    IN idCliente INT,
    IN idOsCalibracao INT,
    IN idTipo INT,
    IN alterarNSerie INT,
	IN alterarIdentificacaoCliente int,
    IN alterarFabricante VARCHAR(60),
    IN alterarFaixaNominalNum decimal(4,2),
    IN alterarFaixaNominalUnidade enum('mm', 'pol'),
    IN alterarDivisaoNum decimal(4,2),
    IN alterarDivisaoUni enum('mm', 'pol')
)
BEGIN
    UPDATE instrumentos
    SET fk_idCliente = idCliente,
    fk_idOs = idOsCalibracao,
    fk_idTipo = idTipo,
    nSerie = alterarNSerie,
    identificacaoCliente = alterarIdentificacaoCliente,
	fabricante = alterarFabricante,
    faixaNominalNum = alterarFaixaNominalNum,
    faixaNominalUni = alterarFaixaNominalUnidade,
    divisaoResolucaoNum = alterarDivisaoNum,
    divisaoResolucaoUni = alterarDivisaoUni
    WHERE pk_idinstrumento = idInstrumento;
END //
DELIMITER ;
call modificarInstrumento(1, 1, 556, 1, 112233, 111232, "Machados e Martelos", 2.21, "pol", 5.32, "mm");


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
select * from recebidos;
drop procedure recebimento;


-- alteração de instrumentos recebidos
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
call modificarRecebimento(2, 556, "vendas", 12341, 12344563, '2024-03-27', "sim", '2024-04-25', '2024-05-21', "sim", '2024-03-28', null, null);
drop procedure modificarInstrumentosRecebidos;

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
select * from planeza;


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
    IN novocMovelcFixo5 decimal(6,3)
)
BEGIN
	INSERT INTO paralelismoMicro(valorNominal1, valorNominal2, valorNominal3, valorNominal4, cMovelcFixo1, cMovelcFixo2, cMovelcFixo3, cMovelcFixo4, cMovelcFixo5)
    VALUES (novovalorNominal1, novovalorNominal2, novovalorNominal3, novovalorNominal4, novocMovelcFixo1, novocMovelcFixo2, novocMovelcFixo3, novocMovelcFixo4, novocMovelcFixo5);
END // 
DELIMITER ;
call criarParalelismoMicro(1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0);
select * from paralelismoMicro;


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
    IN novocMovelcFixo5 decimal(6,3)
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
    cMovelcFixo5 = novocMovelcFixo5
    WHERE pk_idParalelismoMicro = idParalelismo;
END // 
DELIMITER ;
call modificarParalelismoMicro(1, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9);


-- inserção de controle dimensional
DELIMITER //
CREATE PROCEDURE criarControleDimensional(
	IN novovp0_0_1 decimal(6,3),
	IN novovp0_0_2 decimal(6,3),
	IN novovp0_0_3 decimal(6,3),
	IN novovp2_5_1 decimal(6,3),
	IN novovp2_5_2 decimal(6,3),
	IN novovp2_5_3 decimal(6,3),
	IN novovp5_1_1 decimal(6,3),
	IN novovp5_1_2 decimal(6,3),
	IN novovp5_1_3 decimal(6,3),
	IN novovp7_7_1 decimal(6,3),
	IN novovp7_7_2 decimal(6,3),
	IN novovp7_7_3 decimal(6,3),
	IN novovp10_3_1 decimal(6,3),
	IN novovp10_3_2 decimal(6,3),
	IN novovp10_3_3 decimal(6,3),
	IN novovp12_9_1 decimal(6,3),
	IN novovp12_9_2 decimal(6,3),
	IN novovp12_9_3 decimal(6,3),
	IN novovp15_0_1 decimal(6,3),
	IN novovp15_0_2 decimal(6,3),
	IN novovp15_0_3 decimal(6,3),
	IN novovp17_6_1 decimal(6,3),
	IN novovp17_6_2 decimal(6,3),
	IN novovp17_6_3 decimal(6,3),
	IN novovp20_2_1 decimal(6,3),
	IN novovp20_2_2 decimal(6,3),
	IN novovp20_2_3 decimal(6,3),
	IN novovp22_8_1 decimal(6,3),
	IN novovp22_8_2 decimal(6,3),
	IN novovp22_8_3 decimal(6,3),
	IN novovp25_0_1 decimal(6,3),
	IN novovp25_0_2 decimal(6,3),
	IN novovp25_0_3 decimal(6,3)
)
BEGIN
	INSERT INTO controleDimensional( vp0_0_1, vp0_0_2, vp0_0_3, vp2_5_1, vp2_5_2, vp2_5_3, vp5_1_1, vp5_1_2, vp5_1_3, vp7_7_1, vp7_7_2, vp7_7_3, vp10_3_1, vp10_3_2, vp10_3_3, vp12_9_1, vp12_9_2, vp12_9_3, vp15_0_1, vp15_0_2, vp15_0_3, vp17_6_1, vp17_6_2, vp17_6_3, vp20_2_1, vp20_2_2, vp20_2_3, vp22_8_1, vp22_8_2, vp22_8_3, vp25_0_1, vp25_0_2, vp25_0_3)
    VALUES (novovp0_0_1, novovp0_0_2, novovp0_0_3, novovp2_5_1, novovp2_5_2, novovp2_5_3, novovp5_1_1, novovp5_1_2, novovp5_1_3, novovp7_7_1, novovp7_7_2, novovp7_7_3, novovp10_3_1, novovp10_3_2, novovp10_3_3, novovp12_9_1, novovp12_9_2, novovp12_9_3, novovp15_0_1, novovp15_0_2, novovp15_0_3, novovp17_6_1, novovp17_6_2, novovp17_6_3, novovp20_2_1, novovp20_2_2, novovp20_2_3, novovp22_8_1, novovp22_8_2, novovp22_8_3, novovp25_0_1, novovp25_0_2, novovp25_0_3);
END // 
DELIMITER ;
call criarControleDimensional(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 , 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33);
select * from controleDimensional;


-- alteração de controle dimensional
DELIMITER //
CREATE PROCEDURE modificarControleDimensional(
	IN idControle int,
	IN alterarvp0_0_1 decimal(6,3),
	IN alterarvp0_0_2 decimal(6,3),
	IN alterarvp0_0_3 decimal(6,3),
	IN alterarvp2_5_1 decimal(6,3),
	IN alterarvp2_5_2 decimal(6,3),
	IN alterarvp2_5_3 decimal(6,3),
	IN alterarvp5_1_1 decimal(6,3),
	IN alterarvp5_1_2 decimal(6,3),
	IN alterarvp5_1_3 decimal(6,3),
	IN alterarvp7_7_1 decimal(6,3),
	IN alterarvp7_7_2 decimal(6,3),
	IN alterarvp7_7_3 decimal(6,3),
	IN alterarvp10_3_1 decimal(6,3),
	IN alterarvp10_3_2 decimal(6,3),
	IN alterarvp10_3_3 decimal(6,3),
	IN alterarvp12_9_1 decimal(6,3),
	IN alterarvp12_9_2 decimal(6,3),
	IN alterarvp12_9_3 decimal(6,3),
	IN alterarvp15_0_1 decimal(6,3),
	IN alterarvp15_0_2 decimal(6,3),
	IN alterarvp15_0_3 decimal(6,3),
	IN alterarvp17_6_1 decimal(6,3),
	IN alterarvp17_6_2 decimal(6,3),
	IN alterarvp17_6_3 decimal(6,3),
	IN alterarvp20_2_1 decimal(6,3),
	IN alterarvp20_2_2 decimal(6,3),
	IN alterarvp20_2_3 decimal(6,3),
	IN alterarvp22_8_1 decimal(6,3),
	IN alterarvp22_8_2 decimal(6,3),
	IN alterarvp22_8_3 decimal(6,3),
	IN alterarvp25_0_1 decimal(6,3),
	IN alterarvp25_0_2 decimal(6,3),
	IN alterarvp25_0_3 decimal(6,3)
)
BEGIN
	UPDATE controleDimensional
    SET vp0_0_1 =  alterarvp0_0_1,
	vp0_0_2 = alterarvp0_0_2,
	vp0_0_3 = alterarvp0_0_3,
	vp2_5_1 = alterarvp2_5_1,
	vp2_5_2 = alterarvp2_5_2,
	vp2_5_3 = alterarvp2_5_3,
	vp5_1_1 = alterarvp5_1_1,
	vp5_1_2 = alterarvp5_1_2,
	vp5_1_3 = alterarvp5_1_3,
	vp7_7_1 = alterarvp7_7_1,
	vp7_7_2 = alterarvp7_7_2,
	vp7_7_3 = alterarvp7_7_3,
	vp10_3_1 = alterarvp10_3_1,
	vp10_3_2 = alterarvp10_3_2,
	vp10_3_3 = alterarvp10_3_3,
	vp12_9_1 = alterarvp12_9_1,
	vp12_9_2 = alterarvp12_9_2,
	vp12_9_3 = alterarvp12_9_3,
	vp15_0_1 = alterarvp15_0_1,
	vp15_0_2 = alterarvp15_0_2,
	vp15_0_3 = alterarvp15_0_3,
	vp17_6_1 = alterarvp17_6_1,
	vp17_6_2 = alterarvp17_6_2,
	vp17_6_3 = alterarvp17_6_3,
	vp20_2_1 = alterarvp20_2_1,
	vp20_2_2 = alterarvp20_2_2,
	vp20_2_3 = alterarvp20_2_3,
	vp22_8_1 = alterarvp22_8_1,
	vp22_8_2 = alterarvp22_8_2,
	vp22_8_3 = alterarvp22_8_3,
	vp25_0_1 = alterarvp25_0_1,
	vp25_0_2 = alterarvp25_0_2,
	vp25_0_3 = alterarvp25_0_3
    WHERE pk_idControle = idControle;
END // 
DELIMITER ;
call modificarControleDimensional(1, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);


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
    IN novaFaixaCalibradaNum decimal(4,2),
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
call criarResultadosMicrometros(745, 1, 1, 1, 1, 1, 2, 2.3, "mm", '2024-03-21', "ok", "analogico", 9, 20.70, 20.5);
select * from resultadosMicrometros;


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
    IN alterarFaixaCalibradaNum decimal(4,2),
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
call modificarResultadosMicrometros(745, 750, 1, 1, 1, 1, 1, 2, 3.2, "pol", '2024-03-21', "ok", "analogico", 9, 20.70, 20.5);


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
select * from medicoesInternas; 


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
select * from medicoesRessaltos;


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
select * from medicoesProfundidades;


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


-- Inserção de paralelismo do micrômetro
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
select * from paralelismoPaq;


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
drop procedure alterarParalelismoPaq;

-- Inserção de medições externas
DELIMITER //
CREATE PROCEDURE inserirMedicoesExternas(
    IN novo_vn0_0_1 DECIMAL(6,3),
    IN novo_vn0_0_2 DECIMAL(6,3),
    IN novo_vn0_0_3 DECIMAL(6,3),
    IN novo_vn1_3_1 DECIMAL(6,3),
    IN novo_vn1_3_2 DECIMAL(6,3),
    IN novo_vn1_3_3 DECIMAL(6,3),
    IN novo_vn1_4_1 DECIMAL(6,3),
    IN novo_vn1_4_2 DECIMAL(6,3),
    IN novo_vn1_4_3 DECIMAL(6,3),
    IN novo_vn20_0_1 DECIMAL(6,3),
    IN novo_vn20_0_2 DECIMAL(6,3),
    IN novo_vn20_0_3 DECIMAL(6,3),
    IN novo_vn50_0_1 DECIMAL(6,3),
    IN novo_vn50_0_2 DECIMAL(6,3),
    IN novo_vn50_0_3 DECIMAL(6,3),
    IN novo_vn100_0_1 DECIMAL(6,3),
    IN novo_vn100_0_2 DECIMAL(6,3),
    IN novo_vn100_0_3 DECIMAL(6,3),
    IN novo_vn150_0_1 DECIMAL(6,3),
    IN novo_vn150_0_2 DECIMAL(6,3),
    IN novo_vn150_0_3 DECIMAL(6,3),
    IN novo_vnExtra1_1 DECIMAL(6,3),
    IN novo_vnExtra1_2 DECIMAL(6,3),
    IN novo_vnExtra1_3 DECIMAL(6,3),
    IN novo_vnExtra2_1 DECIMAL(6,3),
    IN novo_vnExtra2_2 DECIMAL(6,3),
    IN novo_vnExtra2_3 DECIMAL(6,3),
    IN novo_vnExtra3_1 DECIMAL(6,3),
    IN novo_vnExtra3_2 DECIMAL(6,3),
    IN novo_vnExtra3_3 DECIMAL(6,3)
)
BEGIN
    INSERT INTO medicoesExternas (vn0_0_1, vn0_0_2, vn0_0_3, vn1_3_1, vn1_3_2, vn1_3_3, vn1_4_1, vn1_4_2, vn1_4_3, vn20_0_1, vn20_0_2, vn20_0_3, vn50_0_1, vn50_0_2, vn50_0_3, vn100_0_1, vn100_0_2, vn100_0_3, vn150_0_1, vn150_0_2, vn150_0_3, vnExtra1_1, vnExtra1_2, vnExtra1_3, vnExtra2_1, vnExtra2_2, vnExtra2_3, vnExtra3_1, vnExtra3_2, vnExtra3_3)
    VALUES (novo_vn0_0_1, novo_vn0_0_2, novo_vn0_0_3, novo_vn1_3_1, novo_vn1_3_2, novo_vn1_3_3, novo_vn1_4_1, novo_vn1_4_2, novo_vn1_4_3, novo_vn20_0_1, novo_vn20_0_2, novo_vn20_0_3, novo_vn50_0_1, novo_vn50_0_2, novo_vn50_0_3, novo_vn100_0_1, novo_vn100_0_2, novo_vn100_0_3, novo_vn150_0_1, novo_vn150_0_2, novo_vn150_0_3, novo_vnExtra1_1, novo_vnExtra1_2, novo_vnExtra1_3, novo_vnExtra2_1, novo_vnExtra2_2, novo_vnExtra2_3, novo_vnExtra3_1, novo_vnExtra3_2, novo_vnExtra3_3);
END//
DELIMITER ;
CALL inserirMedicoesExternas(0.1, 0.2, 0.3, 1.3, 1.4, 1.5, 1.4, 1.5, 1.6, 20.0, 20.1, 20.2, 50.0, 50.1, 50.2, 100.0, 100.1, 100.2, 150.0, 150.1, 150.2, 10.0, 10.1, 10.2, 20.0, 20.1, 20.2, 30.0, 30.1, 30.2);
select * from medicoesExternas;


-- Alteração de medições externas
DELIMITER //
CREATE PROCEDURE alterarMedicoesExternas(
    IN idMedicaoExterna INT,
    IN novo_vn0_0_1 DECIMAL(6,3),
    IN novo_vn0_0_2 DECIMAL(6,3),
    IN novo_vn0_0_3 DECIMAL(6,3),
    IN novo_vn1_3_1 DECIMAL(6,3),
    IN novo_vn1_3_2 DECIMAL(6,3),
    IN novo_vn1_3_3 DECIMAL(6,3),
    IN novo_vn1_4_1 DECIMAL(6,3),
    IN novo_vn1_4_2 DECIMAL(6,3),
    IN novo_vn1_4_3 DECIMAL(6,3),
    IN novo_vn20_0_1 DECIMAL(6,3),
    IN novo_vn20_0_2 DECIMAL(6,3),
    IN novo_vn20_0_3 DECIMAL(6,3),
    IN novo_vn50_0_1 DECIMAL(6,3),
    IN novo_vn50_0_2 DECIMAL(6,3),
    IN novo_vn50_0_3 DECIMAL(6,3),
    IN novo_vn100_0_1 DECIMAL(6,3),
    IN novo_vn100_0_2 DECIMAL(6,3),
    IN novo_vn100_0_3 DECIMAL(6,3),
    IN novo_vn150_0_1 DECIMAL(6,3),
    IN novo_vn150_0_2 DECIMAL(6,3),
    IN novo_vn150_0_3 DECIMAL(6,3),
    IN novo_vnExtra1_1 DECIMAL(6,3),
    IN novo_vnExtra1_2 DECIMAL(6,3),
    IN novo_vnExtra1_3 DECIMAL(6,3),
    IN novo_vnExtra2_1 DECIMAL(6,3),
    IN novo_vnExtra2_2 DECIMAL(6,3),
    IN novo_vnExtra2_3 DECIMAL(6,3),
    IN novo_vnExtra3_1 DECIMAL(6,3),
    IN novo_vnExtra3_2 DECIMAL(6,3),
    IN novo_vnExtra3_3 DECIMAL(6,3)
)
BEGIN
    UPDATE medicoesExternas
    SET vn0_0_1 = novo_vn0_0_1,
        vn0_0_2 = novo_vn0_0_2,
        vn0_0_3 = novo_vn0_0_3,
        vn1_3_1 = novo_vn1_3_1,
        vn1_3_2 = novo_vn1_3_2,
        vn1_3_3 = novo_vn1_3_3,
        vn1_4_1 = novo_vn1_4_1,
        vn1_4_2 = novo_vn1_4_2,
        vn1_4_3 = novo_vn1_4_3,
        vn20_0_1 = novo_vn20_0_1,
        vn20_0_2 = novo_vn20_0_2,
        vn20_0_3 = novo_vn20_0_3,
        vn50_0_1 = novo_vn50_0_1,
        vn50_0_2 = novo_vn50_0_2,
        vn50_0_3 = novo_vn50_0_3,
        vn100_0_1 = novo_vn100_0_1,
        vn100_0_2 = novo_vn100_0_2,
        vn100_0_3 = novo_vn100_0_3,
        vn150_0_1 = novo_vn150_0_1,
        vn150_0_2 = novo_vn150_0_2,
        vn150_0_3 = novo_vn150_0_3,
        vnExtra1_1 = novo_vnExtra1_1,
        vnExtra1_2 = novo_vnExtra1_2,
        vnExtra1_3 = novo_vnExtra1_3,
        vnExtra2_1 = novo_vnExtra2_1,
        vnExtra2_2 = novo_vnExtra2_2,
        vnExtra2_3 = novo_vnExtra2_3,
        vnExtra3_1 = novo_vnExtra3_1,
        vnExtra3_2 = novo_vnExtra3_2,
        vnExtra3_3 = novo_vnExtra3_3
    WHERE pk_idMedicaoExterna = idMedicaoExterna;
END//
DELIMITER ;
CALL alterarMedicoesExternas(1, 0.1, 0.2, 0.3, 1.3, 1.4, 1.5, 1.4, 1.5, 1.6, 20.0, 20.1, 20.2, 50.0, 50.1, 50.2, 100.0, 100.1, 100.2, 150.0, 150.1, 150.2, 10.0, 10.1, 10.2, 20.0, 20.1, 20.2, 30.0, 30.1, 30.2);


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
    IN novaFaixaCalibradaNum decimal(4,2),
    IN novaFaixaCalibradaUni enum("mm", "pol"),
    IN novaDataCalibracao date,
    IN novaInspecao enum("ok", "nok"),
    IN novoTipoEscala enum("analogico", "digital"),
    IN novaVersaoMetodo int,
    IN novoTempInicial decimal(4,2),
    IN novoTempFinal decimal(4,2)
)
BEGIN
	INSERT INTO resultadosPaquimetros(pk_idNrCertificado, fk_idInstrumento, fk_idParalelismoPaq, fk_idMedicaoExterna, fk_idMedicaointerna, fk_idMedicaoRessalto, fk_idMedicaoProfundidade, fk_idTecnico, fk_idResponsavel, faixaCalibradaNum, faixaCalibradaUni, dataCalibracao, inspecao, tipoEscala, versaoMetodo, tempInicial, tempFinal)
    VALUES (nrCertificado, idInstrumento, idParalelismoPaq, idMedExterna, idMedInterna, idMedRessalto, idMedProfundidade, novoTecnico, novoResponsável, novaFaixaCalibradaNum, novaFaixaCalibradaUni, novaDataCalibracao, novaInspecao, novoTipoEscala, novaVersaoMetodo, novoTempInicial, novoTempFinal);
END // 
DELIMITER ;
call criarResultadosPaquimetro(322, 1, 1, 1, 1, 1, 1, 1, 2, 5.8, "pol", '2024-03-25', "ok", "digital", 9, 22.5, 22);
select * from resultadosPaquimetros;
drop procedure criarResultadosPaquimetro;


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
    IN alterarFaixaCalibradaNum decimal(4,2),
    IN alterarFaixaCalibradaUni enum("mm", "pol"),
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
call modificarResultadosPaquimetro(322, 350, 1, 1, 1, 1, 1, 1, 1, 2, 8.5, "mm", '2024-03-25', "nok", "analogico", 9, 22.5, 22);


-- precisamos criar um trigger para alterar o número do certificado caso eles alterem algum valor da calibração

-- também precisamos criar um trigger para caso eles alterem o id de uma ordem de serviço, também altere as fks que estão referenciando essa ordem


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
select * from pecas;
DROP PROCEDURE cadastrarPeca;


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
drop procedure alterarPeca;


-- criação de relatório
DELIMITER //
CREATE PROCEDURE criarRelatorio (
	IN idRelatorio int,
    IN idOs int,
    IN idInstrumento int,
    IN idUsuario int,
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
    INSERT INTO relatorio (pk_idRelatorio, fk_idOs, fk_idInstrumento, fk_idUsuario, inicio, termino, tempoTotal, temperaturaC, umidadeRelativa, observacoes, localDaMedicao, dia, assinatura)
    VALUES (idRelatorio, idOs, idInstrumento, idUsuario, novoInicio, novoTermino, novoTempoTotal, novoTemperaturaC, novaUmidadeRelativa, novoObservacoes, novoLocalDaMedicao, novoDia, novaAssinatura);
END //
DELIMITER ;
call criarRelatorio(23, 665, 2, 1, '09:00', '17:00', '26:00', '25°C', '50%', 'Nenhuma observação', 'Laboratório A', '2024-03-24', 'Assinatura do técnico');
select * from relatorio;
drop procedure criarRelatorio;


-- alteração de relatório
DELIMITER //
CREATE PROCEDURE modificarRelatorio(
	IN antigoIdRelatorio int,
	IN alterarIdRelatorio int,
    IN idOs int,
    IN idInstrumento int,
    IN idUsuario int,
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
    fk_idOs = idOs,
    fk_idInstrumento = idInstrumento,
    fk_idUsuario = idUsuario,
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
call modificarRelatorio(23, 32, 665, 2, 1, '10:00', '18:00', '8:00', '25°C', '50%', 'Nenhuma observação', 'Laboratório A', '2024-03-24', 'Assinatura do técnico');