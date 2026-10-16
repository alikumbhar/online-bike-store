/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.21-MariaDB : Database - bike_shop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bike_shop` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bike_shop`;

/*Table structure for table `ci_sessions` */

DROP TABLE IF EXISTS `ci_sessions`;

CREATE TABLE `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ci_sessions` */

insert  into `ci_sessions`(`id`,`ip_address`,`timestamp`,`data`) values 
('4vrs6bo7q9vi23torn5ieals0povqnfb','::1',1789533579,'cart|a:1:{i:0;a:5:{s:2:\"id\";s:1:\"5\";s:4:\"name\";s:19:\"Touring Bike Helmet\";s:5:\"price\";s:6:\"749.00\";s:5:\"image\";s:6:\"l5.png\";s:3:\"qty\";i:1;}}success|s:22:\"Product added to cart.\";__ci_vars|a:1:{s:7:\"success\";s:3:\"new\";}'),
('ikkmsmpmr91mkmif1p5tfg4n3htu85f9','::1',1789534950,'user_id|s:1:\"2\";username|s:4:\"dada\";role|s:8:\"customer\";cart|a:1:{i:0;a:5:{s:2:\"id\";s:2:\"10\";s:4:\"name\";s:28:\"Off-Road Bike Helmet - Green\";s:5:\"price\";s:6:\"899.00\";s:5:\"image\";s:6:\"a4.png\";s:3:\"qty\";i:1;}}'),
('n4e0ifnfeps97078gbreg5kt1a9p4o0q','::1',1789533579,'user_id|s:1:\"1\";username|s:5:\"admin\";role|s:5:\"admin\";');

/*Table structure for table `contact_messages` */

DROP TABLE IF EXISTS `contact_messages`;

CREATE TABLE `contact_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `email` varchar(190) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `contact_messages` */

/*Table structure for table `order_items` */

DROP TABLE IF EXISTS `order_items`;

CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_name` varchar(180) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_items_order` (`order_id`),
  KEY `fk_items_product` (`product_id`),
  CONSTRAINT `fk_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `order_items` */

insert  into `order_items`(`id`,`order_id`,`product_id`,`product_name`,`price`,`quantity`) values 
(1,1,12,'Cyclocross Bike Helmet - Pro',699.00,1),
(2,1,11,'Touring Bike Helmet - White',749.00,1),
(3,1,9,'Racing Bike Helmet - Red',799.00,1),
(4,2,6,'Cyclocross Bike Helmet',699.00,2),
(5,2,4,'Off-Road Bike Helmet',899.00,1);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Processing',
  `payment_method` varchar(30) NOT NULL,
  `shipping_address` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`id`,`user_id`,`total`,`status`,`payment_method`,`shipping_address`,`created_at`,`updated_at`) values 
(1,2,2247.00,'Processing','card','karachi','2026-09-16 09:24:42','2026-09-16 09:24:42'),
(2,2,2297.00,'Processing','card','d','2026-09-16 10:00:57','2026-09-16 10:00:57');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(120) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'l1.png',
  `stock` int(11) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`description`,`category`,`price`,`old_price`,`image`,`stock`,`is_featured`,`created_at`,`updated_at`) values 
(1,'Aerion Carrbo Helmet','Fashion and twin disc helmet.','Fashion, Twin Disc',699.00,799.00,'l1.png',20,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(2,'Mountain Bike Helmet','Sports protective gear.','Sports, Protective Gear',549.00,649.00,'l2.png',20,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(3,'Racing Bike Helmet','Performance aerodynamic helmet.','Performance, Aerodynamic',799.00,999.00,'l3.png',15,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(4,'Off-Road Bike Helmet','Adventure durable helmet.','Adventure, Durable',899.00,1099.00,'l4.png',15,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(5,'Touring Bike Helmet','Comfort and ventilation.','Comfort, Ventilation',749.00,899.00,'l5.png',25,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(6,'Cyclocross Bike Helmet','Versatile lightweight helmet.','Versatile, Lightweight',699.00,899.00,'l6.png',25,1,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(7,'Aerion Carrbo Helmet - Black','Premium finish.','Fashion',699.00,799.00,'a1.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(8,'Mountain Bike Helmet - Blue','Protective riding gear.','Sports',549.00,649.00,'a2.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(9,'Racing Bike Helmet - Red','Aerodynamic racing design.','Performance',799.00,999.00,'a3.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(10,'Off-Road Bike Helmet - Green','Durable adventure gear.','Adventure',899.00,1099.00,'a4.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(11,'Touring Bike Helmet - White','Comfortable long-distance gear.','Touring',749.00,899.00,'a5.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29'),
(12,'Cyclocross Bike Helmet - Pro','Lightweight versatile gear.','Cyclocross',699.00,899.00,'a6.png',10,0,'2026-09-16 09:21:29','2026-09-16 09:21:29');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(190) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('customer','admin') NOT NULL DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`email`,`phone`,`password_hash`,`role`,`created_at`,`updated_at`) values 
(1,'Administrator','admin','admin@bikeshop.local',NULL,'$2y$12$9D0vKBjAX4s3rY4eSWFQmOVFDAasxqkGpNvdki1XJijRMTdyThtPe','admin','2026-09-16 09:21:29','2026-09-16 09:21:29'),
(2,'Adeel khan','dada','usmanshoeb08@gmail.com',NULL,'$2y$10$8CTufw0/w4/CuNInEwEIr.Tjw/pP6l0MZYremkj0VHmkNclxp3pnC','customer','2026-09-16 09:23:48','2026-09-16 09:23:48');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
