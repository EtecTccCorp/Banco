-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.


-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.


CREATE DATABASE Modelo_Fisico_Empresa;
USE Modelo_Fisico_Empresa;

CREATE TABLE Roteiro (
	Codigo_Roteiro 				INT AUTO_INCREMENT 	NOT NULL,
	Data_Roteiro				DATE 				NOT NULL,
	Valor_Nota_Roteiro 			DECIMAL(10,2) 		NOT NULL,
	PRIMARY KEY(Codigo_Roteiro)
);

CREATE TABLE Cliente (
	Codigo_Cliente 				INT  AUTO_INCREMENT NOT NULL,
	Nome_Cliente 				VARCHAR(50) NOT NULL,
	CNPJ_Cliente 				VARCHAR(14),
	CPF_Cliente 				VARCHAR(11),
	Forma_De_Pagamento_Cliente 	VARCHAR(15) NOT NULL,
	PRIMARY KEY(Codigo_Cliente)

);

CREATE TABLE Fornecedor (
	Codigo_Fornecedor 	INT  AUTO_INCREMENT NOT NULL,
	Nome_Fornecedor 	VARCHAR (50) 	NOT NULL,
	CNPJ_Fornecedor 	VARCHAR(14) 	NOT NULL,
	PRIMARY KEY(Codigo_Fornecedor)
);

CREATE TABLE Endereco (
	Codigo_endereco 	INT AUTO_INCREMENT 	NOT NULL,
	Rua_Endereco 		VARCHAR (50) 		NOT NULL,
	Bairro_Endereco 	VARCHAR(50) 		NOT NULL,
	Numero_Endereco 	VARCHAR (6)			NOT NULL,
	Cep_Endereco 		VARCHAR(8) 			NOT NULL,
	Cidade_Endereco 	VARCHAR(30) 		NOT NULL,
	Codigo_Cliente 		INT,
	Codigo_Fornecedor 	INT,
	PRIMARY KEY(Codigo_endereco)
);


CREATE TABLE Funcionario(
	Codigo_Func 	INT AUTO_INCREMENT 	NOT NULL,
	Nome_Func 		VARCHAR(50)  		NOT NULL,
	Cargo_Func		VARCHAR(15) 		NOT NULL,
	CPF_Func 		VARCHAR(11) 		NOT NULL,
	RG_Func 		VARCHAR(11)			NOT NULL,
	Login_Func 		VARCHAR (20) 		NOT NULL,
	Senha_Func 		VARCHAR (06)		NOT NULL,
	Codigo_endereco INT ,
	Codigo_Roteiro 	INT ,
	PRIMARY KEY(Codigo_Func),
	FOREIGN KEY(Codigo_endereco) REFERENCES Endereco (Codigo_endereco),
	FOREIGN KEY(Codigo_Roteiro) REFERENCES Roteiro(Codigo_Roteiro)
);

CREATE TABLE Contato (
	Codigo_Contato 					INT AUTO_INCREMENT NOT NULL,
	Cel_Contato 					VARCHAR(17),
	Fixo_Contato  					VARCHAR(16),
	Nextel_Contato 					VARCHAR(17),
	Codigo_Func 					INT ,
	Codigo_Fornecedor 				INT ,
	Codigo_Cliente 					INT ,
	PRIMARY KEY(Codigo_Contato),
	FOREIGN KEY(Codigo_Func) 		REFERENCES 	Funcionario (Codigo_Func),
	FOREIGN KEY(Codigo_Fornecedor) 	REFERENCES 	Fornecedor(Codigo_Fornecedor),
	FOREIGN KEY(Codigo_Cliente) 	REFERENCES  Cliente (Codigo_Cliente)
);

CREATE TABLE Tipo_Contato (
	Codigo_TipoContato 			INT AUTO_INCREMENT 	NOT NULL ,
	Descricao_TipoContato 		VARCHAR (20) 		NOT NULL,
	Codigo_Contato 				INT ,
	PRIMARY KEY(Codigo_TipoContato),
	FOREIGN KEY(Codigo_Contato)	REFERENCES Contato(Codigo_Contato)
);


CREATE TABLE Tipo_Endereco (
	Codigo_Tipo_Endereco 			INT AUTO_INCREMENT 	NOT NULL,
	Descricao_TipoEndereco 			VARCHAR (30) 		NOT NULL,
	Codigo_endereco 				INT ,
	PRIMARY KEY(Codigo_Tipo_Endereco),
	FOREIGN KEY(Codigo_endereco) 	REFERENCES Endereco(Codigo_endereco)
);

CREATE TABLE Vendas (
	Codigo_Vendas 	INT AUTO_INCREMENT 		NOT NULL,
	Relatorio 		Varchar(255) 			NOT NULL,
	Codigo_Boleto 	INT  					NOT NULL,
	Codigo_Estoque 	INT 					NOT NULL,
	Codigo_Roteiro 	INT 					NOT NULL,
	PRIMARY KEY(Codigo_Vendas)

);


CREATE TABLE Estoque (
	Codigo_Estoque 				INT AUTO_INCREMENT NOT NULL,
	Codigo_Vendas 				INT ,
	PRIMARY KEY(Codigo_Estoque),
	FOREIGN KEY(Codigo_Vendas) 	REFERENCES Vendas (Codigo_Vendas)
);

CREATE TABLE Produto (
	Codigo_Produto 				INT AUTO_INCREMENT 	NOT NULL,
	Nome_Produto 				VARCHAR(50) 		NOT NULL,
	Validade_Produtos 			DATE 				NOT NULL,
	Valor_Produtos 				DECIMAL(10.2) 		NOT NULL,
	Quantidade_Produto 			INT(4) 				NOT NULL,
	Peso_Produto 				DECIMAL(10.2) 		NOT NULL,
	Codigo_Estoque 				INT ,
	PRIMARY KEY(Codigo_Produto),
	FOREIGN KEY(Codigo_Estoque) REFERENCES Estoque (Codigo_Estoque)
);

CREATE TABLE Tipo_Produto (
	Codigo_Tipo_Produto 		INT AUTO_INCREMENT 	NOT NULL,
	Descricao_Tipo_Produto 		VARCHAR (100) 		NOT NULL,
	Codigo_Produto 				INT,
	PRIMARY KEY(Codigo_Tipo_Produto),
	FOREIGN KEY(Codigo_Produto) REFERENCES Produto (Codigo_Produto)
);


CREATE TABLE Boleto (
	Codigo_Boleto 				INT AUTO_INCREMENT 			NOT NULL,
	Valor_Boleto 				DECIMAL(10,2) 				NOT NULL,
	Data_Emissao 				DATE 						NOT NULL,
	Data_Vencimento				DATE 						NOT NULL,
	Codigo_Cliente 				INT,
	Codigo_Vendas 				INT,
	PRIMARY KEY(Codigo_Boleto),
	FOREIGN KEY(Codigo_Cliente) REFERENCES Cliente(Codigo_Cliente),
	FOREIGN KEY(Codigo_Vendas) 	REFERENCES Vendas(Codigo_Vendas)
);


ALTER TABLE Vendas ADD FOREIGN KEY(Codigo_Boleto) REFERENCES Boleto(Codigo_Boleto);
ALTER TABLE Vendas ADD FOREIGN KEY(Codigo_Estoque) REFERENCES Estoque(Codigo_Estoque);
ALTER TABLE Vendas ADD FOREIGN KEY(Codigo_Roteiro) REFERENCES Roteiro(Codigo_Roteiro);
ALTER TABLE Endereco ADD FOREIGN KEY(Codigo_Fornecedor) REFERENCES Fornecedor (Codigo_Fornecedor);
ALTER TABLE Endereco ADD FOREIGN KEY(Codigo_Cliente) REFERENCES Cliente (Codigo_Cliente);
/*
ALTER TABLE Tipo_Contato ADD FOREIGN KEY(Codigo_Contato) REFERENCES Contato (Codigo_Contato);
ALTER TABLE Tipo_Endereco ADD FOREIGN KEY(Codigo_endereco) REFERENCES Endereco (Codigo_endereco);
ALTER TABLE Endereco ADD FOREIGN KEY(Codigo_Fornecedor) REFERENCES Fornecedor (Codigo_Fornecedor);
ALTER TABLE Funcionario ADD FOREIGN KEY(Codigo_Roteiro:) REFERENCES Roteiro (Codigo_Roteiro);
ALTER TABLE Vendas ADD FOREIGN KEY(Codigo_Boleto) REFERENCES Boleto (Codigo_Boleto);
ALTER TABLE Vendas ADD FOREIGN KEY(Codigo_Vendas) REFERENCES Roteiro (Codigo_Roteiro);
ALTER TABLE Contato ADD FOREIGN KEY(Codigo_Fornecedor) REFERENCES Fornecedor (Codigo_Fornecedor);*/

