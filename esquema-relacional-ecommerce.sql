-- criação do banco de dados para o cenário de e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
	idCliente SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
	fName VARCHAR(10),
	mInit CHAR(3),
	lName VARCHAR(20),
	CPF CHAR(11) NOT NULL,
	endereço VARCHAR(30),
	dataNascimento DATE,
	CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
);

-- criar tabela produto
-- tamanho em cm
create table produto(
	idProduto SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(10) NOT NULL,
	categoria ENUM('Eletrônicos', 'Vestimentas', 'Brinquedos', 'Alimentos') NOT NULL,
	descrição VARCHAR(50),
	avaliação FLOAT DEFAULT 0,
	tamanho VARCHAR(10)
);

-- criar tabela pagamento
CREATE TABLE pagamento(
	idPagamento INT,
    idCliente INT,
    tipo ENUM('Boleto', 'Cartão de Crédito', 'Pix', 'Paypal'),
    numeroCartao VARCHAR(20),
    valor FLOAT,
    PRIMARY KEY (idPagamento, idCliente)
);

-- criar tabela pedido
create table pedido(
	idPedido SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
	idCliente SMALLINT,
	idPagamento INT,
	status ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL,
	descrição VARCHAR(45),
	frete FLOAT DEFAULT 10 NOT NULL,
	CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
	CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPagamento) REFERENCES pagamento(idPagamento)
);

-- criar tabela terceiro-vendedor
CREATE TABLE vendedor(
	idVendedor SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    razão_social VARCHAR(20) NOT NULL,
    localidade VARCHAR(45) NOT NULL,
    nome_fantasia VARCHAR(20) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    e_mail VARCHAR(20) NOT NULL
);
-- criar tabela estoque
CREATE TABLE estoque(
	idEstoque SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    localidade VARCHAR(255) NOT NULL
);

-- criar tabela fornecedor
CREATE TABLE fornecedor(
	idFornecedor SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    razão_social VARCHAR(20) NOT NULL,
	cnpf CHAR(20) NOT NULL UNIQUE
);

-- criar tabela Produto X Vendedor
CREATE TABLE produto_vendedor(
	idVendedor SMALLINT,
    idProduto SMALLINT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idVendedor, idProduto),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idVendedor) REFERENCES vendedor(idVendedor),
    CONSTRAINT fk_produto_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

-- criar tabela Produto X Pedido
CREATE TABLE produto_pedido(
	idPedido SMALLINT,
    idProduto SMALLINT,
    quantidade INT DEFAULT 1,
    status ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPedido, idProduto),
    CONSTRAINT fk_produtoPedido_pedido FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    CONSTRAINT fk_produtoPedido_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

-- criar tabela Produto X Estoque
CREATE TABLE produto_estoque(
	idEstoque SMALLINT,
    idProduto SMALLINT,
    localidade VARCHAR(255) NOT NULL,
    PRIMARY KEY (idEstoque, idProduto),
    CONSTRAINT fk_produtoEstoque_estoque FOREIGN KEY (idEstoque) REFERENCES estoque(idEstoque),
    CONSTRAINT fk_produtoEstoque_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

ALTER TABLE produto_estoque CHANGE quantidade quantidade INT NOT NULL;

desc produto_estoque;