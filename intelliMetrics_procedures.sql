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


-- criação de ordem de calibração
DELIMITER //
CREATE PROCEDURE criarOsCalibracao(
	IN novaOrdem int,
	IN idCliente int,
    IN idUsuario int,
    IN novoTitulo varchar(30),
    IN novaDescricao varchar(150),
    IN novaDataInicio date,
    IN novaDataTermino date,
    IN novoContratante varchar(60),
    IN novoEmail varchar(60),
    IN novoTelefone varchar(11)
)
BEGIN
	INSERT INTO ordensCalibracao(pk_idOsCalibracao, fk_idCliente, fk_idUsuario, titulo, descricao, dataInicio, dataTermino, contratante, email, telefone)
    VALUES (novaOrdem, idCliente, idUsuario, novoTitulo, novaDescricao, novaDataInicio, novaDataTermino, novoContratante, novoEmail, novoTelefone);
END // 
DELIMITER ;
call criarOsCalibracao(556, 1, 1, "Arregaça ai esse paquímetro", "Paquímetro ta com defeito", curdate(), '2024-03-27', "Bill Gates", "gatesbill@gmail.com", 11902345567);
select * from ordensCalibracao;


-- alteração de ordem de calibração
DELIMITER //
CREATE PROCEDURE modificarOsCalibracao(
	IN idAntigo int,
	IN alterarOrdem int,
	IN alterarCliente int,
    IN alterarUsuario int,
    IN alterarTitulo varchar(30),
    IN alterarDescricao varchar(150),
    IN alterarDataTermino date,
    IN alterarContratante varchar(60),
    IN alterarEmail varchar(60),
    IN alterarTelefone varchar(11)
)
BEGIN
	UPDATE ordensCalibracao
    SET pk_idOsCalibracao = alterarOrdem,
    fk_idCliente = alterarCliente,
    fk_idUsuario = alterarUsuario,
    titulo = alterarTitulo,
    descricao = alterarDescricao,
    dataTermino = alterarDataTermino,
    contratante = alterarContratante,
    email = alterarEmail,
    telefone = alterarTelefone
    WHERE pk_idOsCalibracao = idAntigo;
END // 
DELIMITER ;
call modificarOsCalibracao(556, 45, 1, 1, "banana", "cabou banana", '2024-04-27', "Bill Gates", "gatesbill@gmail.com", 11902345567);


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
    IN idOsCalibracao int,
    IN idTipo int,
    IN novoNSerie int,
    IN novoFabricante varchar(60),
    IN novaResolucao int,
    IN novaUnidadeMedida enum('mm', 'cm', 'pol'),
    IN novaFaixaNominal varchar(30)
)
BEGIN
    INSERT INTO instrumentos(fk_idCliente, fk_idOsCalibracao, fk_idTipo, nSerie, fabricante, resolucao, unidadeMedida, faixaNominal)
    VALUES (idCliente, idOsCalibracao, idTipo, novoNSerie, novoFabricante, novaResolucao, novaUnidadeMedida, novaFaixaNominal);
END //
DELIMITER ;
call cadastrarInstrumento(1, 45, 1, 112233, "Martelos e machados", 230, "pol", "AAAAAAAA");
select * from instrumentos;


-- alteraçao de instrumentos
DELIMITER //
CREATE PROCEDURE modificarInstrumento(
    IN idInstrumento INT,
    IN idCliente INT,
    IN idOsCalibracao INT,
    IN idTipo INT,
    IN alterarNSerie INT,
    IN alterarFabricante VARCHAR(60),
    IN alterarResolucao INT,
    IN alterarUnidadeMedida ENUM('mm', 'cm', 'pol'),
    IN alterarFaixaNominal VARCHAR(30)
)
BEGIN
    UPDATE instrumentos
    SET fk_idCliente = idCliente,
    fk_idOsCalibracao = idOsCalibracao,
    fk_idTipo = idTipo,
    nSerie = alterarNSerie,
	fabricante = alterarFabricante,
    resolucao = alterarResolucao,
    unidadeMedida = alterarUnidadeMedida,
    faixaNominal = alterarFaixaNominal
    WHERE pk_idinstrumento = idInstrumento;
END //
DELIMITER ;
call modificarInstrumento(3, 1, 45, 1, 112233, "Machados e Martelos", 230, "cm", "bbbbbbb");


-- inserção de instrumentos recebidos
DELIMITER //
CREATE PROCEDURE inserirInstrumentoRecebido(
    IN idOsCalibracao int,
    IN novoSetor varchar(30),
    IN novoNProposta int,
    IN novoNumNotaFiscal int,
    IN novaDataRecebimento date
)
BEGIN
    INSERT INTO instrumentosRecebidos(fk_idOsCalibracao, setor, nProposta, nNotaFiscal, dataDeRecebimento)
    VALUES (idOsCalibracao, novoSetor, novoNProposta, novoNumNotaFiscal, novaDataRecebimento);
END //
DELIMITER ;
call inserirInstrumentoRecebido(45, "marketing", 12341, 12344563, '2024-03-27');
select * from instrumentosRecebidos;


-- alteração de instrumentos recebidos
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;

-- inserção de planeza


-- alteração de planeza


-- inserção de paralelismo do micrômetro


-- alteração de paralelismo do micrômetro


-- inserção de controle dimensional


-- alteração de controle dimensional


-- inserção de resultados do micrômetro


-- alteração de resultados do micrômetro


-- inserção de mdeições internas  // marques


-- alteração de mdeições internas


-- inserção de medições de ressaltos


-- alteração de medições de ressaltos


-- inserção de medições de profundidades


-- alteração de medições de profundidades


-- inserção de paralelismo do micrômetro


-- alteração de paralelismo do micrômetro


-- inserção de medicoes externas


-- alteração de medicoes externas


-- inserção de resultados dos paquímetros  // leal


-- alteração de resultados dos paquímetros

-- criação de certificados
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteração de texto de um certificado
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteração dos resultados de um certificado
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- criação de ordem de medição
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteração de ordem de medição
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- cadastro de peças
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteraçao de peças
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- exclusão de peças / a decidir
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- inserção de pecas recebidas
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteração de pecas recebidas
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- criação de relatório
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;


-- alteração de relatório
DELIMITER //
CREATE PROCEDURE criarLista(

)
BEGIN

END // 
DELIMITER ;
