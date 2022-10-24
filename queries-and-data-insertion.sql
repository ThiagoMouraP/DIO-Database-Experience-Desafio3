-- inserção de dados e queries
use ecommerce;

SHOW TABLES;

-- insere na tabela cliente (fName, mInit, lName, cpf, endereço)
INSERT INTO cliente (fName, mInit, lName, cpf, endereço) 
	VALUES ('Maria', 'M', 'Silva', '12345678910', 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
		   ('Matheus', 'O', 'Pimentel', '98765432101', 'Rua Almeida 289, Centro - Cidade das Flores'),
           ('Ricardo', 'F', 'Silva', '45678913141', 'Avenida Alemeda Vinha 1009, Centro - Cidade das Flores'),
           ('Julia', 'S', 'França', '78912345610', 'Rua Lareiras 861, Centro - Cidade das Flores'),
           ('Roberta', 'G', 'Assis', '98745631101', 'Avenida Koller 19, Centro - Cidade das Flores'),
           ('Isabela', 'M', 'Cruz', '65478912310', 'Rua Alemeda das Flores 29, Centro - Cidade das Flores');
 
SELECT * FROM cliente;

-- insere na tabela produto (nome, categoria('Eletrônicos', 'Vestimentas', 'Brinquedos', 'Alimentos'), descrição, avaliação, tamanho)
INSERT INTO produto (nome, categoria, descrição, avaliação, tamanho)
	VALUES ('Fones de Ouvido', 'Eletrônicos', 'Fones de qualidade', '4', null),
		   ('Barbie Elsa', 'Brinquedos', 'Boneca', '3', null),
           ('Body Carters', 'Vestimentas', 'Roupa de qualidade', '5', 'P'),
           ('Microfone Vedo - Youtuber', 'Eletrônicos', 'Microfone para gravar vídeos e fazer lives', '4', null),
           ('Farinha de Arroz', 'Alimentos', 'Farinha de qualidade', '2', null),
           ('Suco de Uva', 'Alimentos', 'Suco natural', '4', null);

SELECT * FROM cliente;     
SELECT * FROM produto;     

-- insere na tabela pagamento (idCliente, tipo('Boleto', 'Cartão de Crédito', 'Pix', 'Paypal'), numeroCartao, valor)
INSERT INTO pagamento (idCliente, tipo, numeroCartao, valor)
	VALUES (2, 'Boleto', null, 89.50),
		   (1, 'Paypal', '7845452519101', 399.99),
           (6, 'Pix', '1115872009101', 200.00),
           (3, 'Cartão de Crédito', '6545872519101', 99.99);
           
SELECT * FROM pagamento;

-- insere na tabela pedido (idCliente, status('Em andamento', 'Em processamento', 'Enviado', 'Entregue'), descrição, frete)
INSERT INTO pedido (idCliente, idPagamento, status, descrição, frete)
	VALUES (1, 6, 'Enviado', 'Compra de vestimenta', default),
		   (4, 8, DEFAULT, 'Compra de alimento', 15),
           (2, 7, 'Entregue', 'Compra de eletrônico', 12);
          
SELECT * FROM pedido;
    
-- insere na tabela produto_pedido (idPedido, idProduto, quantidade, status('Disponível', 'Sem estoque'))
INSERT INTO produto_pedido (idPedido, idProduto, quantidade, status)
	VALUES (1, 1, 2, 'Disponível'),
		   (2, 4, 3, 'Sem estoque'),
           (3, 6, 3, 'Disponível');
           
SELECT * FROM produto_pedido;

-- insere na tabela estoque (localidade, responsável, telefone)
INSERT INTO estoque (localidade, responsável, telefone)
	VALUES ('Av. Franklin Roosevelt, 164, Rio de Janeiro, RJ', 'Valdemir Costa', '38909658'),
		   ('Rua Castro Barbosa, 36, Rio de Janeiro, RJ', 'Cláudio Lopes', '25805528'),
           ('Rua da Alfândega, 193 F, Rio de Janeiro, RJ', 'Jocimar Souza', '25899965');
           
-- insere na tabela produto_estoque (idProduto, idEstoque, quantidade)
INSERT INTO produto_estoque (idProduto, idEstoque, quantidade)
	VALUES (1, 1, 300),
		   (4, 1, 2),
           (2, 3, 100),
           (3, 3, 10),
           (5, 2, 29),
           (6, 2, 15);
           
-- insere na tabela fornecedor (razão_social, cnpj, telefone, email)
INSERT INTO fornecedor (razão_social, cnpj, telefone, email)
	VALUES ('Almeida e filhos', '23546765123112568721', '990127676', 'almeidaefilhos@gmail.com'),
		   ('Eletrônicos Silva', '29455867920192458687', '25804578', 'eletronicossilva@gmail.com'),
           ('Modas SA', '56894523658923547823', '989429763', 'modassa@gmail.com');
           
-- insere na tabela produto_fornecedor (idProduto, idFornecedor, quantidade, valor_unitario, valor_total, data_compra, data_recebimento)
INSERT INTO produto_fornecedor (idProduto, idFornecedor, quantidade, valor_unitario, valor_total, data_compra, data_recebimento)
	VALUES (2, 1, 100, 89.90, 8990, '2022-10-20', '2022-10-23'),
		   (5, 1, 20, 3, 60, '2022-09-10', '2022-09-30'),
           (6, 1, 10, 4, 40, '2022-10-10', '2022-10-20'),
           (1, 2, 30, 200, 6000, '2022-10-12', '2022-10-18'),
           (4, 2, 20, 400, 8000, '2022-09-01', '2022-09-09'),
           (3, 3, 30, 30, 900, '2022-10-10', '2022-10-19');
           
SELECT * FROM produto_fornecedor;

-- insere na tabela vendedor (razão_social, localidade, nome_fantasia, telefone, email, cnpj)
INSERT INTO vendedor (razão_social, localidade, nome_fantasia, telefone, email, cnpj)
	VALUES ('Eletrônicos Souza e Silva', 'Av. Presidente Vargas, 98, Rio de Janeiro', 'Eletrônicos Plus', '99007474', 'eletronicosplus@gmail.com', '354855126985236'),
		   ('Alimentos SA', 'R. São Cristóvão, 112, Rio de Janeiro', 'Alimentos Saudáveis', '25806644', 'alimentossaudaveis@gmail.com', '123456789123456'),
           ('Moda SA', 'R. Alfândega, 34, Rio de Janeiro', 'Vista-se bem', '35486621', 'vistasebem@gmail.com', '987654321987654');

SELECT * FROM vendedor;

-- insere na tabela produto_vendedor (idProduto, idVendedor, quantidade)
INSERT INTO produto_vendedor (idProduto, idVendedor, quantidade)
	VALUES ('1', '1', 20),
		   ('5', '2', 10),
           ('3', '3', 20);
           
SELECT * FROM cliente c, pedido p WHERE c.idCliente = p.idCliente;
SELECT concat(fName, ' ', lName) AS Cliente, idPedido AS Pedido, status AS Status_pedido FROM cliente c, pedido p WHERE c.idCliente = p.idCliente;

-- Recupera quantos pedidos foram feitos pelos clientes
SELECT c.idCliente, fName, count(*) AS Numero_de_pedidos FROM cliente c 
	INNER JOIN pedido p ON c.idCliente = p.idCliente 
    GROUP BY idCliente;
    
SELECT * FROM cliente c 
	INNER JOIN pedido p ON c.idCliente = p.idCliente 
    INNER JOIN produto_pedido pp ON pp.idPedido = p.idPedido
    GROUP BY c.idCliente;