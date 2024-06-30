/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: db_minhacarteira
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE DATABASE `db_minhacarteira` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;


USE `db_minhacarteira`;


--
-- Table structure for table `carteiras`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carteiras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `id_tipo_carteira` smallint(6) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `dt_cadastro` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data da inclusão do cadastro',
  `dt_modificacao` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT 'Data da alteração do cadastro',
  PRIMARY KEY (`id`),
  KEY `carteiras_tipo_carteiras_FK` (`id_tipo_carteira`),
  KEY `carteiras_usuarios_FK` (`id_usuario`),
  CONSTRAINT `carteiras_tipo_carteiras_FK` FOREIGN KEY (`id_tipo_carteira`) REFERENCES `tipo_carteiras` (`id`),
  CONSTRAINT `carteiras_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carteiras`
--

LOCK TABLES `carteiras` WRITE;
/*!40000 ALTER TABLE `carteiras` DISABLE KEYS */;
/*!40000 ALTER TABLE `carteiras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria da tabela',
  `descricao` varchar(100) NOT NULL COMMENT 'Nome que descreve a categoria do usuário',
  `tipo_categoria` enum('DESPESA','RECEITA') NOT NULL COMMENT 'Identifica se a categoria é  uma Despesa ou Receita',
  `id_categoria_pai` int(11) DEFAULT NULL COMMENT 'Identifica a categoria superior',
  `id_usuario` int(11) DEFAULT NULL COMMENT 'Define o usuario a categoria',
  `dt_cadastro` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data do cadastro da categoria',
  `dt_modificacao` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT 'Data da alteração do cadastro',
  PRIMARY KEY (`id`),
  KEY `categorias_usuarios_FK` (`id_usuario`),
  KEY `categorias_categorias_FK` (`id_categoria_pai`),
  CONSTRAINT `categorias_categorias_FK` FOREIGN KEY (`id_categoria_pai`) REFERENCES `categorias` (`id`),
  CONSTRAINT `categorias_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Categorias para agrupar e segmentar os lançamentos financeiros, cada usuário tem suas categorias';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamentos_despesas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamentos_despesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(250) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `data_pagamento` date DEFAULT NULL,
  `data_vencimento` date NOT NULL DEFAULT curdate(),
  `id_categoria` int(11) NOT NULL,
  `id_carteira` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `pago` tinyint(4) NOT NULL DEFAULT 0,
  `comprovante` varchar(500) DEFAULT NULL,
  `dt_cadastro` datetime NOT NULL DEFAULT current_timestamp(),
  `dt_modificacao` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `lancamentos_despesas_usuarios_FK` (`id_usuario`),
  KEY `lancamentos_despesas_carteiras_FK` (`id_carteira`),
  KEY `lancamentos_despesas_categorias_FK` (`id_categoria`),
  CONSTRAINT `lancamentos_despesas_carteiras_FK` FOREIGN KEY (`id_carteira`) REFERENCES `carteiras` (`id`),
  CONSTRAINT `lancamentos_despesas_categorias_FK` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  CONSTRAINT `lancamentos_despesas_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamentos_despesas`
--

LOCK TABLES `lancamentos_despesas` WRITE;
/*!40000 ALTER TABLE `lancamentos_despesas` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamentos_despesas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancamentos_receitas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamentos_receitas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(250) NOT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `data_credito` date DEFAULT NULL,
  `data_vencimento` date NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_carteira` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `pago` tinyint(4) NOT NULL DEFAULT 0,
  `dt_cadastro` datetime NOT NULL DEFAULT current_timestamp(),
  `dt_modificacao` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `lancamentos_receitas_carteiras_FK` (`id_carteira`),
  KEY `lancamentos_receitas_categorias_FK` (`id_categoria`),
  KEY `lancamentos_receitas_usuarios_FK` (`id_usuario`),
  CONSTRAINT `lancamentos_receitas_carteiras_FK` FOREIGN KEY (`id_carteira`) REFERENCES `carteiras` (`id`),
  CONSTRAINT `lancamentos_receitas_categorias_FK` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  CONSTRAINT `lancamentos_receitas_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamentos_receitas`
--

LOCK TABLES `lancamentos_receitas` WRITE;
/*!40000 ALTER TABLE `lancamentos_receitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancamentos_receitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveis_usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `niveis_usuarios` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `super_usuario` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveis_usuarios`
--

LOCK TABLES `niveis_usuarios` WRITE;
/*!40000 ALTER TABLE `niveis_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `niveis_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_carteiras`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_carteiras` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_carteiras`
--

LOCK TABLES `tipo_carteiras` WRITE;
/*!40000 ALTER TABLE `tipo_carteiras` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_carteiras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `senha` varchar(500) NOT NULL,
  `id_nivel_usuario` smallint(6) NOT NULL,
  `fg_ativo` tinyint(1) NOT NULL DEFAULT 0,
  `dt_cadastro` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data de inclusão do cadastro', 
  `dt_modificacao` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT 'Data da alteração do cadastro',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuarios_email_unique` (`email`),
  KEY `usuarios_niveis_usuarios_FK` (`id_nivel_usuario`),
  CONSTRAINT `usuarios_niveis_usuarios_FK` FOREIGN KEY (`id_nivel_usuario`) REFERENCES `niveis_usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


