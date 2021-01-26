-- Adminer 4.7.8 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `apartamentos`;
CREATE TABLE `apartamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `apartamentos` (`id`, `nome`) VALUES
(1,	'Apartamento 1'),
(2,	'Apartamento 2'),
(3,	'Apartamento 3')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `nome` = VALUES(`nome`);

DROP TABLE IF EXISTS `bandeiras`;
CREATE TABLE `bandeiras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `taxa` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `bandeiras` (`id`, `nome`, `taxa`) VALUES
(1,	'Mastercard',	1.50),
(2,	'Visa',	1.75),
(3,	'Amex',	1.95)
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `nome` = VALUES(`nome`), `taxa` = VALUES(`taxa`);

DROP TABLE IF EXISTS `creditos`;
CREATE TABLE `creditos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apartamento_id` int(11) NOT NULL,
  `bandeira_id` int(11) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `apartamento_id` (`apartamento_id`),
  KEY `bandeira_id` (`bandeira_id`),
  CONSTRAINT `creditos_ibfk_1` FOREIGN KEY (`apartamento_id`) REFERENCES `apartamentos` (`id`),
  CONSTRAINT `creditos_ibfk_2` FOREIGN KEY (`bandeira_id`) REFERENCES `bandeiras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `creditos` (`id`, `apartamento_id`, `bandeira_id`, `valor`, `created_at`) VALUES
(1,	1,	NULL,	10.00,	'2020-12-26 19:10:57'),
(2,	1,	1,	10.00,	'2021-01-26 19:11:11'),
(3,	1,	1,	10.00,	'2021-01-26 19:12:08'),
(4,	1,	3,	20.00,	'2021-01-26 19:12:12'),
(5,	1,	1,	10.00,	'2021-01-26 19:57:58'),
(6,	1,	1,	50.00,	'2021-02-26 22:10:07'),
(7,	2,	2,	20.00,	'2021-01-26 22:30:41'),
(8,	2,	3,	10.00,	'2021-01-26 22:30:52'),
(9,	2,	3,	10.00,	'2021-01-26 22:30:57')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `apartamento_id` = VALUES(`apartamento_id`), `bandeira_id` = VALUES(`bandeira_id`), `valor` = VALUES(`valor`), `created_at` = VALUES(`created_at`);

DROP TABLE IF EXISTS `utilizacoes`;
CREATE TABLE `utilizacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apartamento_id` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `apartamento_id` (`apartamento_id`),
  CONSTRAINT `utilizacoes_ibfk_1` FOREIGN KEY (`apartamento_id`) REFERENCES `apartamentos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `utilizacoes` (`id`, `apartamento_id`, `valor`, `created_at`) VALUES
(1,	1,	10.00,	'2021-01-26 19:50:33'),
(2,	1,	10.00,	'2021-01-26 19:50:37'),
(3,	1,	10.00,	'2021-01-26 19:50:41')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `apartamento_id` = VALUES(`apartamento_id`), `valor` = VALUES(`valor`), `created_at` = VALUES(`created_at`);

-- 2021-01-26 22:41:12
