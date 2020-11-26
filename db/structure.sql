-- --------------------------------------------------------
-- Servidor:                     den1.mysql3.gear.host   --
-- --------------------------------------------------------

-- Criando banco
CREATE DATABASE IF NOT EXISTS `piti95ionize`;
USE `piti95ionize`;

-- Criando tabela piti95ionize.tb_category
CREATE TABLE IF NOT EXISTS `tb_category` (
  `pk_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`pk_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Criando tabela piti95ionize.tb_credentials
CREATE TABLE IF NOT EXISTS `tb_credentials` (
  `pk_cred_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `fk_user_id` int(11) NOT NULL,
  PRIMARY KEY (`pk_cred_id`),
  KEY `fk_user_id` (`fk_user_id`),
  CONSTRAINT `tb_credentials_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `tb_user` (`pk_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Criando tabela piti95ionize.tb_product
CREATE TABLE IF NOT EXISTS `tb_product` (
  `pk_prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `product_condition` enum('new','used') NOT NULL,
  `img_dir` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` longtext,
  `stock` int(11) NOT NULL,
  `fk_category_id` int(11) NOT NULL,
  `fk_salesman_id` int(11) NOT NULL,
  PRIMARY KEY (`pk_prod_id`),
  KEY `fk_salesman_id` (`fk_salesman_id`),
  KEY `fk_category_id` (`fk_category_id`),
  CONSTRAINT `tb_product_ibfk_1` FOREIGN KEY (`fk_salesman_id`) REFERENCES `tb_user` (`pk_user_id`),
  CONSTRAINT `tb_product_ibfk_2` FOREIGN KEY (`fk_category_id`) REFERENCES `tb_category` (`pk_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Criando piti95ionize.tb_transaction
CREATE TABLE IF NOT EXISTS `tb_transaction` (
  `pk_tran_id` int(11) NOT NULL AUTO_INCREMENT,
  `tr_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_product_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` enum('to_send','in_transit','done','canceled') NOT NULL,
  `fk_buyer_id` int(11) NOT NULL,
  `fk_seller_id` int(11) NOT NULL,
  PRIMARY KEY (`pk_tran_id`),
  KEY `fk_product_id` (`fk_product_id`),
  KEY `fk_buyer_id` (`fk_buyer_id`),
  KEY `fk_seller_id` (`fk_seller_id`),
  CONSTRAINT `tb_transaction_ibfk_1` FOREIGN KEY (`fk_product_id`) REFERENCES `tb_product` (`pk_prod_id`),
  CONSTRAINT `tb_transaction_ibfk_2` FOREIGN KEY (`fk_buyer_id`) REFERENCES `tb_user` (`pk_user_id`),
  CONSTRAINT `tb_transaction_ibfk_3` FOREIGN KEY (`fk_seller_id`) REFERENCES `tb_product` (`fk_salesman_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Criando tabela piti95ionize.tb_user
CREATE TABLE IF NOT EXISTS `tb_user` (
  `pk_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `birthday` date NOT NULL,
  `user_address` varchar(255) NOT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`pk_user_id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;