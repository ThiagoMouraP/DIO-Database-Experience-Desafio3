-- criação do banco de dados para o cenário de e-commerce
create database ecommerce;
drop database ecommerce;
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

ALTER TABLE cliente MODIFY COLUMN endereço VARCHAR(100);
ALTER TABLE cliente AUTO_INCREMENT = 1;

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

ALTER TABLE produto MODIFY COLUMN nome VARCHAR(30);
ALTER TABLE produto AUTO_INCREMENT = 1;

-- criar tabela pagamento
CREATE TABLE pagamento(
	idPagamento INT,
    idCliente INT,
    tipo ENUM('Boleto', 'Cartão de Crédito', 'Pix', 'Paypal'),
    numeroCartao VARCHAR(20),
    valor FLOAT,
    PRIMARY KEY (idPagamento, idCliente)
);

ALTER TABLE pagamento MODIFY COLUMN idPagamento INT UNIQUE AUTO_INCREMENT;
ALTER TABLE pagamento AUTO_INCREMENT = 1;

-- criar tabela pedido
create table pedido(
	idPedido SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
	idCliente SMALLINT,
	idPagamento INT,
	status ENUM('Em andamento', 'Em processamento', 'Enviado', 'Entregue') DEFAULT 'Em processamento',
	descrição VARCHAR(45),
	frete FLOAT DEFAULT 10 NOT NULL,
	CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
	CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPagamento) REFERENCES pagamento(idPagamento)
);

ALTER TABLE pedido AUTO_INCREMENT = 1;

-- criar tabela terceiro-vendedor
CREATE TABLE vendedor(
	idVendedor SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    razão_social VARCHAR(20) NOT NULL,
    localidade VARCHAR(45) NOT NULL,
    nome_fantasia VARCHAR(20) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    email VARCHAR(20) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    CONSTRAINT unique_vendedor UNIQUE (cnpj)
);

ALTER TABLE vendedor CHANGE COLUMN razão_social razão_social VARCHAR(45) NOT NULL;
ALTER TABLE vendedor CHANGE COLUMN email email VARCHAR(45) NOT NULL;
ALTER TABLE vendedor AUTO_INCREMENT = 1;

-- criar tabela estoque
CREATE TABLE estoque(
	idEstoque SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    localidade VARCHAR(255) NOT NULL,
    responsável VARCHAR(45) NOT NULL,
    telefone CHAR(11) NOT NULL
);

ALTER TABLE estoque AUTO_INCREMENT = 1;

-- criar tabela fornecedor
CREATE TABLE fornecedor(
	idFornecedor SMALLINT UNIQUE AUTO_INCREMENT PRIMARY KEY,
    razão_social VARCHAR(20) NOT NULL,
	cnpj CHAR(20) NOT NULL,
    telefone CHAR(11) NOT NULL,
    email CHAR(30) NOT NULL,
    CONSTRAINT unique_fornecedor UNIQUE (cnpj)
);

ALTER TABLE fornecedor AUTO_INCREMENT = 1;

-- criar tabela Produto X Vendedor
CREATE TABLE produto_vendedor(
	idVendedor SMALLINT,
    idProduto SMALLINT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idVendedor, idProduto),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idVendedor) REFERENCES vendedor(idVendedor),
    CONSTRAINT fk_produto_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

-- criar tabela produto x fornecedor
CREATE TABLE produto_fornecedor(
	idProduto SMALLINT, 
    idFornecedor SMALLINT,
    PRIMARY KEY (idProduto, idFornecedor),
    CONSTRAINT fk_fornecedor FOREIGN KEY (idFornecedor) REFERENCES fornecedor(idFornecedor),
    CONSTRAINT fk_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

ALTER TABLE produto_fornecedor ADD quantidade INT DEFAULT 1;
ALTER TABLE produto_fornecedor ADD valor_unitario FLOAT DEFAULT 0;
ALTER TABLE produto_fornecedor ADD valor_total FLOAT DEFAULT 0;
ALTER TABLE produto_fornecedor ADD data_compra DATE;
ALTER TABLE produto_fornecedor ADD data_recebimento DATE;

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
    quantidade INT DEFAULT 1,
    localidade VARCHAR(255) NOT NULL,
    PRIMARY KEY (idEstoque, idProduto),
    CONSTRAINT fk_produtoEstoque_estoque FOREIGN KEY (idEstoque) REFERENCES estoque(idEstoque),
    CONSTRAINT fk_produtoEstoque_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

ALTER TABLE produto_estoque DROP column localidade;

desc produto_estoque;