﻿	CREATE DATABASE LivrariaMHS;
	USE LivrariaMHS;

	CREATE TABLE Ruas (
		ID   INT           IDENTITY (1, 1) NOT NULL,
		Nome NVARCHAR (70) NOT NULL,
		CONSTRAINT PK_Ruas PRIMARY KEY CLUSTERED (ID ASC)
	);

	CREATE TABLE Cidades (
		ID     INT           IDENTITY (1, 1) NOT NULL,
		Nome   NVARCHAR (70) NOT NULL,
		Estado NVARCHAR (2)  NOT NULL,
		CONSTRAINT PK_Cidades PRIMARY KEY CLUSTERED (ID ASC)
	);

	CREATE TABLE dbo.Bairros (
		ID   INT           IDENTITY (1, 1) NOT NULL,
		Nome NVARCHAR (70) NOT NULL,
		CONSTRAINT PK_Bairros PRIMARY KEY CLUSTERED (ID ASC)
	);

	CREATE TABLE Clientes (
		ID             INT            IDENTITY (1, 1) NOT NULL,
		Nome           NVARCHAR (70)  NOT NULL,
		Sexo           INT            NOT NULL,
		Email          NVARCHAR (MAX) NOT NULL,
		CPF            NVARCHAR (14)  NOT NULL,
		DataNascimento DATETIME2 (7)  NOT NULL,
		Telefone       NVARCHAR (14)  NOT NULL,
		Numero         NVARCHAR (8)   NOT NULL,
		RuaID          INT            NOT NULL,
		BairroID       INT            NOT NULL,
		CidadeID       INT            NOT NULL,
		CONSTRAINT PK_Clientes PRIMARY KEY CLUSTERED (ID ASC),
		CONSTRAINT FK_Clientes_Bairros_BairroID FOREIGN KEY (BairroID) REFERENCES Bairros (ID) ON DELETE CASCADE,
		CONSTRAINT FK_Clientes_Cidades_CidadeID FOREIGN KEY (CidadeID) REFERENCES Cidades (ID) ON DELETE CASCADE,
		CONSTRAINT FK_Clientes_Ruas_RuaID FOREIGN KEY (RuaID) REFERENCES Ruas (ID) ON DELETE CASCADE
	);
	CREATE NONCLUSTERED INDEX IX_Clientes_BairroID ON Clientes(BairroID ASC);
	CREATE NONCLUSTERED INDEX IX_Clientes_CidadeID ON Clientes(CidadeID ASC);
	CREATE NONCLUSTERED INDEX IX_Clientes_RuaID ON Clientes(RuaID ASC);

	CREATE TABLE Categorias (
		ID   INT           IDENTITY (1, 1) NOT NULL,
		Nome NVARCHAR (50) NOT NULL,
		CONSTRAINT PK_Categorias PRIMARY KEY CLUSTERED (ID ASC)
	);

	CREATE TABLE Autores (
		ID   INT           IDENTITY (1, 1) NOT NULL,
		Nome NVARCHAR (70) NOT NULL,
		CONSTRAINT PK_Autores PRIMARY KEY CLUSTERED (ID ASC)
	);

	CREATE TABLE Livros (
		ID          INT             IDENTITY (1, 1) NOT NULL,
		Titulo      NVARCHAR (70)   NOT NULL,
		Paginas     INT             NOT NULL,
		Preco       DECIMAL (18, 2) NOT NULL,
		Edicao      INT             NOT NULL,
		Ano         INT             NOT NULL,
		AutorID     INT             NOT NULL,
		ContentType NVARCHAR (MAX)  NULL,
		Dados       VARBINARY (MAX) NULL,
		Nome        NVARCHAR (MAX)  NULL,
		CONSTRAINT PK_Livros PRIMARY KEY CLUSTERED (ID ASC),
		CONSTRAINT FK_Livros_Autores_AutorID FOREIGN KEY (AutorID) REFERENCES Autores (ID) ON DELETE CASCADE
	);
	CREATE NONCLUSTERED INDEX IX_Livros_AutorID ON Livros(AutorID ASC);

	CREATE TABLE LivroCategoria (
		ID          INT IDENTITY (1, 1) NOT NULL,
		LivroID     INT NOT NULL,
		CategoriaID INT NOT NULL,
		CONSTRAINT PK_LivroCategoria PRIMARY KEY CLUSTERED (ID ASC),
		CONSTRAINT FK_LivroCategoria_Categorias_CategoriaID FOREIGN KEY (CategoriaID) REFERENCES Categorias (ID) ON DELETE CASCADE,
		CONSTRAINT FK_LivroCategoria_Livros_LivroID FOREIGN KEY (LivroID) REFERENCES Livros (ID) ON DELETE CASCADE
	);
	CREATE NONCLUSTERED INDEX IX_LivroCategoria_CategoriaID ON LivroCategoria(CategoriaID ASC);
	CREATE NONCLUSTERED INDEX IX_LivroCategoria_LivroID ON LivroCategoria(LivroID ASC);

	CREATE TABLE Vendas (
		ID            INT             IDENTITY (1, 1) NOT NULL,
		Data          DATETIME2 (7)   NOT NULL,
		Quantidade    INT             NOT NULL,
		ValorUnitario DECIMAL (18, 2) NOT NULL,
		ClienteID     INT             NOT NULL,
		LivroID       INT             NOT NULL
	);
	CREATE NONCLUSTERED INDEX IX_Vendas_ClienteID ON Vendas(ClienteID ASC);
	CREATE NONCLUSTERED INDEX IX_Vendas_LivroID ON Vendas(LivroID ASC);
	ALTER TABLE Vendas ADD CONSTRAINT PK_Vendas PRIMARY KEY CLUSTERED (ID ASC);
	ALTER TABLE dbo.Vendas ADD CONSTRAINT FK_Vendas_Clientes_ClienteID FOREIGN KEY (ClienteID) REFERENCES Clientes (ID) ON DELETE CASCADE;
	ALTER TABLE Vendas ADD CONSTRAINT FK_Vendas_Livros_LivroID FOREIGN KEY (LivroID) REFERENCES Livros (ID) ON DELETE CASCADE;

	CREATE TABLE [dbo].[__EFMigrationsHistory] (
		[MigrationId]    NVARCHAR (150) NOT NULL,
		[ProductVersion] NVARCHAR (32)  NOT NULL
	);