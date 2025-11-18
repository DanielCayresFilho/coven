-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: coven
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('3186c60d-dc62-463c-80f5-386a54f1dfd2','89538d0724abef04f594dcf93010a71d839fcadb59c3066f57065fb0051b1036','2025-08-04 20:00:33.001','20250730000001_remove_quantity_from_procedure_products','',NULL,'2025-08-04 20:00:33.001',0),('3a8c938c-294b-473c-bd9d-42122f367c8e','1d86d82e3514f0cefeb96ca30a4776728f4f0b428ea06d89c48bd030120c663f','2025-08-04 20:00:37.215','20250730000002_add_comanda_system','',NULL,'2025-08-04 20:00:37.215',0),('803be2e9-5ce1-4cd9-a0cc-5c1f8273f56b','d755563dc2c7ac79d81996973bf01c689af231308c9873ef6e0ac533f7c0d5b8',NULL,'20250730000000_add_product_measurement_fields','A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20250730000000_add_product_measurement_fields\n\nDatabase error code: 1265\n\nDatabase error:\nData truncated for column \'type\' at row 7\n\nPlease check the query number 1 from the migration file.\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name=\"20250730000000_add_product_measurement_fields\"\n             at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:113\n   1: schema_commands::commands::apply_migrations::Applying migration\n           with migration_name=\"20250730000000_add_product_measurement_fields\"\n             at schema-engine/commands/src/commands/apply_migrations.rs:91\n   2: schema_core::state::ApplyMigrations\n             at schema-engine/core/src/state.rs:236','2025-08-04 20:00:20.241','2025-08-04 19:35:37.481',0),('a53eaa64-1a5b-4002-859e-ff38f512ea6e','89538d0724abef04f594dcf93010a71d839fcadb59c3066f57065fb0051b1036',NULL,'20250730000001_remove_quantity_from_procedure_products','A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20250730000001_remove_quantity_from_procedure_products\n\nDatabase error code: 1091\n\nDatabase error:\nCan\'t DROP \'quantity\'; check that column/key exists\n\nPlease check the query number 1 from the migration file.\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name=\"20250730000001_remove_quantity_from_procedure_products\"\n             at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:113\n   1: schema_commands::commands::apply_migrations::Applying migration\n           with migration_name=\"20250730000001_remove_quantity_from_procedure_products\"\n             at schema-engine/commands/src/commands/apply_migrations.rs:91\n   2: schema_core::state::ApplyMigrations\n             at schema-engine/core/src/state.rs:236','2025-08-04 20:00:32.981','2025-08-04 20:00:24.246',0),('ab569713-c36f-47fa-9cee-5cfee06f54de','4d1be815162805c4c9a069e86b5c3882e2359f8e85cc5b745556a9dfcb04199c','2025-07-25 18:39:22.931','20250725172057_newmigra',NULL,NULL,'2025-07-25 18:39:22.581',1),('c07e756d-c288-47f1-b148-fa3373291f15','d755563dc2c7ac79d81996973bf01c689af231308c9873ef6e0ac533f7c0d5b8','2025-08-04 20:00:20.259','20250730000000_add_product_measurement_fields','',NULL,'2025-08-04 20:00:20.259',0);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_procedures`
--

DROP TABLE IF EXISTS `appointment_procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_procedures` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointmentId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `procedureId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointment_procedures_appointmentId_procedureId_key` (`appointmentId`,`procedureId`),
  KEY `appointment_procedures_procedureId_fkey` (`procedureId`),
  CONSTRAINT `appointment_procedures_appointmentId_fkey` FOREIGN KEY (`appointmentId`) REFERENCES `appointments` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `appointment_procedures_procedureId_fkey` FOREIGN KEY (`procedureId`) REFERENCES `procedures` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_procedures`
--

LOCK TABLES `appointment_procedures` WRITE;
/*!40000 ALTER TABLE `appointment_procedures` DISABLE KEYS */;
INSERT INTO `appointment_procedures` VALUES ('037ebb11-57ab-403d-bb3e-6d5ae7c79d4b','3705e1cc-91ba-4fa7-8209-7cf4b548ada3','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('0944ea5a-728e-448e-9ce4-f882d893538b','1fe16e65-6454-417d-be85-bacbe20c87ca','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('09b020d9-76a3-4582-b46d-4bb503cdf77c','c1748e43-cdcf-46cf-804c-29ea1f0970ff','1ce11b84-bbeb-4547-9cbd-6b67ca459c0f',95.00),('0b91efdf-7e33-42b1-9b54-8a075c21b4ad','e917bdde-4e94-4348-9583-e66b9d64fc12','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('16e385e9-20cd-427e-a8ad-ca3ad7ea4e07','978bec64-90dc-4366-a312-7177dabcbb14','2b507d5e-947a-474b-929e-ed3b50de1b8d',50.00),('195c503d-2465-41e3-aab0-fc5ffdd923be','7d7dccb4-f324-48be-af2e-c6657809ba16','5ebdca19-aff1-4a0e-a983-9c6b4f4a3916',330.00),('23463e6c-aa6d-478e-a9c5-afae34ea7316','4e645fa2-82c0-41a1-aab5-28e10034ac92','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('24a84540-0860-4e8d-837f-7303045be276','4680b986-dcf4-4843-8110-5dc173b36a3a','2e2fba44-1643-4a66-85c7-045ebe6a72ca',150.00),('2bce25bb-07d5-4973-8ccb-1b06874d60fc','ad442e5c-f049-4f78-80ba-461189b40bb1','a8b4278e-1c2a-4da0-bbec-590dee086c2b',130.00),('3345ccec-714d-4f5d-b520-087ed0220ea2','bce30a16-9508-4e78-99e7-f93cd60e6479','83d1b862-fe5b-41c8-9e1f-70c4e4e5438f',50.00),('34044c7f-ace2-4881-83c7-4f2c602397ea','9a40cad8-a238-44a6-b848-e627e4d763ef','ae0813f3-cca1-4bef-b541-ec00040eee8b',200.00),('3cf52c44-fd91-4301-8139-f40dc94971c5','3a0b9433-1ea0-44a8-9b48-4ba90c2196a6','54061f0f-5dc0-45f2-a2ee-31493b1bb363',250.00),('636477c1-b554-478c-a992-6a96f5b20a18','3321c573-bef4-4730-9f6b-3ddf32ac3bf7','567c0509-c220-48ae-9135-6b866f01e152',380.00),('66574074-f270-41e9-abe3-ececd20f33a0','cd3b407c-d679-4f8e-8100-46b572f1638c','a3eb67b8-c6b6-4ee7-9d6c-1afc56ebf310',160.00),('71d009a1-5739-4cb1-8132-d0dbe2283638','9646fcd4-d031-4562-9922-361022a282a1','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('743c694e-069e-4327-9be4-b19c83783800','8e2b85bc-188c-4233-90ca-89e9da220e36','40221573-20f3-4dc3-b6f5-af217f0afc8d',100.00),('773189bb-20dc-40bf-9168-7242a8b4b835','d8a5f036-495e-4d5c-8a5b-0d6d8ac41cef','567c0509-c220-48ae-9135-6b866f01e152',380.00),('78f9d9d6-679c-4fe7-9a47-c3c8c89e2c74','c7bffe10-a373-4f95-b6bd-789b6d6571c1','23dec80a-d1f1-441f-9493-36a1ab75e9d1',860.00),('7a7d6613-c015-4b38-84fd-a815be99606c','c9e2f7dd-c221-41c0-84a2-68f06ab2aec5','a3eb67b8-c6b6-4ee7-9d6c-1afc56ebf310',160.00),('81010763-e45b-4f23-b076-83c600f5c62f','0a7dce6c-69dc-4e7e-81c0-7680563940f2','1d09bdb4-7714-4d1b-af86-36b99962de7c',600.00),('89bd0646-a36e-4a18-b887-4e455cb5d71d','d8a5f036-495e-4d5c-8a5b-0d6d8ac41cef','58ba0e27-c4a2-42fb-b78d-7144a8269674',20.00),('8cabc141-84ef-4a7a-ae91-76c8235970d9','f02d7d9b-c81b-4770-9b3e-0b0c39965b33','54061f0f-5dc0-45f2-a2ee-31493b1bb363',250.00),('92b91ded-a90e-4f38-93c9-cf49156b2619','c1748e43-cdcf-46cf-804c-29ea1f0970ff','b7cdba77-a9e8-4770-8ed7-e68b18c7016d',110.00),('93d0367b-3e3d-478f-a4c4-c652b4a90913','5f3dd538-7d74-45ab-9109-55628b4cdce2','b7cdba77-a9e8-4770-8ed7-e68b18c7016d',110.00),('a2ac4aa3-b683-4f60-acb0-0b5ea84382ad','7e91d471-d813-4063-b79e-140f8f341dff','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('a4d6472c-1050-4587-ac17-d75eaa9b8d64','05c5a54a-0bfb-4115-804a-0daa1bbafce8','83d1b862-fe5b-41c8-9e1f-70c4e4e5438f',50.00),('b6142074-c1ba-4446-8513-cfdce4f61052','71e98a87-b853-4c1b-9c20-d5d4feeef1f0','1d09bdb4-7714-4d1b-af86-36b99962de7c',700.00),('b650b70f-c97f-4c90-a0d9-6a0be307ae99','73ce9ed2-baeb-4706-8697-e90ccc5effe6','b8fb5412-f884-4570-aed6-359ab6c83fd6',635.00),('bb93f4e2-6c47-4167-ae4c-2347db542f78','d8a5f036-495e-4d5c-8a5b-0d6d8ac41cef','3d1d5ae2-9b0d-444c-9239-9e4d011888c3',10.00),('bbc13538-0418-44ce-9ad5-fbb2a0875d5e','1d8b5148-2bdf-483b-a4b1-477a654dda11','02326c24-37c5-449a-b8c2-4c85e5a0149c',250.00),('bf3f1506-e390-4fb7-aca8-659ea1485ded','e917bdde-4e94-4348-9583-e66b9d64fc12','b7cdba77-a9e8-4770-8ed7-e68b18c7016d',110.00),('c9db3696-2bdc-4793-9f83-019268a42a3f','bfaa04bf-3169-44c2-a527-e946ad35713b','49eec65b-060c-418c-897c-c307e3bb98fd',350.00),('e234149f-fbff-491f-bb9f-0e1feaadbb71','0f09be7e-6c9c-458f-aab4-f6b425d10fe6','76daf4ae-2a69-446c-9e6b-fd21a911640f',620.00),('e65fc77c-23cb-4c27-8a9c-e81fb6e3db75','1b28d733-91dd-45db-988a-daca66387d22','86ca167a-a1e0-4ef0-ad75-67326f6286bc',200.00),('e717f101-bd4c-46a0-b533-1bdfd166674a','2cf81c6b-5019-4340-be9b-c0d3911d8d26','55f64a3b-208d-4051-a1c9-a1a8f3ca40a1',270.00),('e9ebc0e6-5a54-4d4c-b8d0-43a5ff981645','c28f4334-b25f-48c0-a92c-760c9d9fe6c4','5a316ce6-f27f-41aa-82dd-a2b3803a2852',845.00),('ebd1b103-5c32-4f0f-89fe-a50021fcd6c7','972765a3-9333-4e18-9b28-d2c81ca29fac','54061f0f-5dc0-45f2-a2ee-31493b1bb363',250.00),('ec46e20b-e0ad-4c49-81c0-22068646337b','6024ca8d-4a08-4830-b629-d2d931b05eb3','1ce11b84-bbeb-4547-9cbd-6b67ca459c0f',95.00),('ed27b848-f1e8-4ab5-959f-0857abee041b','4bb5e86f-7957-4c26-a252-da37b19b70a0','1ce11b84-bbeb-4547-9cbd-6b67ca459c0f',95.00),('f026fbcc-1035-4992-8280-14d51d0e6a7b','c02e527f-6f3e-4839-bb9e-7f3cc0e3446b','5491c64a-062f-484d-bff9-9257039b86d4',50.00),('f53395bc-c3d7-41a0-8578-1e7b1db03cab','7d7dccb4-f324-48be-af2e-c6657809ba16','1ce11b84-bbeb-4547-9cbd-6b67ca459c0f',95.00),('f66d8a7c-0853-47ca-9b57-c771a9fb5eb1','e917bdde-4e94-4348-9583-e66b9d64fc12','54061f0f-5dc0-45f2-a2ee-31493b1bb363',250.00),('f94a54e0-e9c6-4407-8801-99df9b1ec379','2e610366-014d-4fb6-ac5f-dba08aaa0c91','83d1b862-fe5b-41c8-9e1f-70c4e4e5438f',50.00);
/*!40000 ALTER TABLE `appointment_procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clientId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime(3) NOT NULL,
  `startTime` datetime(3) NOT NULL,
  `endTime` datetime(3) DEFAULT NULL,
  `status` enum('AGENDADO','CONFIRMADO','CONCLUIDO','CANCELADO','BLOQUEADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AGENDADO',
  `paymentMethod` enum('PIX','DINHEIRO','CARTAO_DEBITO','CARTAO_CREDITO_1X','CARTAO_CREDITO_2X','CARTAO_CREDITO_3X','CARTAO_CREDITO_ACIMA_3X') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `partialPayment` decimal(10,2) DEFAULT NULL,
  `finalPrice` decimal(10,2) DEFAULT NULL,
  `cardTax` decimal(5,4) DEFAULT NULL,
  `paymentData` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comandaOpenedAt` datetime(3) DEFAULT NULL,
  `comandaClosedAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_clientId_fkey` (`clientId`),
  KEY `appointments_userId_fkey` (`userId`),
  CONSTRAINT `appointments_clientId_fkey` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `appointments_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES ('05c5a54a-0bfb-4115-804a-0daa1bbafce8','40a5cd95-9743-40b3-9b95-451351f2724b','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-10 00:00:00.000','2025-09-10 14:00:00.000','2025-09-10 15:00:00.000','CONCLUIDO','PIX',50.00,10.00,25.00,40.00,0.0000,'{\"originalPrice\":50,\"discount\":10,\"priceBeforeTax\":40,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":40}',NULL,NULL,'2025-09-10 18:09:06.953','2025-08-15 21:06:39.495','2025-09-10 18:09:06.955'),('0a7dce6c-69dc-4e7e-81c0-7680563940f2','03f151e0-1f00-49e1-be58-daa009e46897','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-11-26 00:00:00.000','2025-11-26 13:00:00.000','2025-11-26 19:00:00.000','AGENDADO',NULL,600.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-15 21:13:29.094','2025-08-15 21:13:29.094'),('0f09be7e-6c9c-458f-aab4-f6b425d10fe6','6bfc70b6-3cab-44a9-9ac7-b915f8cb81b8','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-17 00:00:00.000','2025-08-17 07:00:00.000','2025-08-17 13:00:00.000','CONCLUIDO',NULL,620.00,620.00,310.00,NULL,NULL,NULL,'100g magic premium',NULL,NULL,'2025-08-17 14:18:17.633','2025-08-21 12:22:44.923'),('1b28d733-91dd-45db-988a-daca66387d22','0ec556e2-3f57-463e-8e04-292c5a784c95','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-30 00:00:00.000','2025-07-30 14:00:00.000','2025-07-30 15:30:00.000','CANCELADO','PIX',200.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-26 22:38:45.959','2025-07-29 21:34:38.730'),('1d8b5148-2bdf-483b-a4b1-477a654dda11','0ec556e2-3f57-463e-8e04-292c5a784c95','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-30 00:00:00.000','2025-07-30 22:00:00.000','2025-07-31 00:00:00.000','CANCELADO','PIX',250.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-30 11:15:25.672','2025-08-01 15:37:59.444'),('1fe16e65-6454-417d-be85-bacbe20c87ca','7c3caa6c-a644-4f91-bf8e-7b7de3d1a466','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-11 00:00:00.000','2025-10-11 08:30:00.000','2025-10-11 09:15:00.000','CONCLUIDO',NULL,50.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-19 23:51:19.463','2025-10-20 00:16:53.345'),('2cf81c6b-5019-4340-be9b-c0d3911d8d26','8605f15a-5106-4fcb-a62b-8baee8464984','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-04 00:00:00.000','2025-10-04 04:30:00.000','2025-10-04 06:30:00.000','CONCLUIDO',NULL,270.00,10.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-20 00:01:32.682','2025-10-20 00:13:09.460'),('2e610366-014d-4fb6-ac5f-dba08aaa0c91','40a5cd95-9743-40b3-9b95-451351f2724b','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-15 00:00:00.000','2025-08-15 17:00:00.000','2025-08-15 18:00:00.000','CONCLUIDO','PIX',50.00,10.00,25.00,40.00,0.0000,'{\"originalPrice\":50,\"discount\":10,\"priceBeforeTax\":40,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":40}',NULL,NULL,'2025-08-15 21:03:08.387','2025-08-12 14:38:33.217','2025-08-15 21:03:08.388'),('3321c573-bef4-4730-9f6b-3ddf32ac3bf7','6ad89114-d47b-4bfa-a22a-b5d8a4aa8c98','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-15 00:00:00.000','2025-10-15 04:30:00.000','2025-10-15 07:30:00.000','CONCLUIDO',NULL,380.00,20.00,NULL,NULL,NULL,NULL,'Brinde aniversario, dessa vez será corte completo ',NULL,NULL,'2025-08-16 16:29:21.225','2025-10-20 00:17:44.714'),('3705e1cc-91ba-4fa7-8209-7cf4b548ada3','7c3caa6c-a644-4f91-bf8e-7b7de3d1a466','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-04 00:00:00.000','2025-10-04 11:30:00.000','2025-10-04 12:15:00.000','CANCELADO',NULL,50.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-06 15:13:12.108','2025-10-19 23:58:42.709'),('3a0b9433-1ea0-44a8-9b48-4ba90c2196a6','9af998c8-7be6-4e21-8f60-e001e07e761a','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-20 00:00:00.000','2025-09-20 14:00:00.000','2025-09-20 17:00:00.000','CANCELADO',NULL,250.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-15 21:10:53.230','2025-10-19 23:58:37.184'),('4680b986-dcf4-4843-8110-5dc173b36a3a','eb454114-ee39-4968-be2e-b4f38bdc8f6c','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-06 00:00:00.000','2025-09-06 15:30:00.000','2025-09-06 17:30:00.000','CANCELADO',NULL,150.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-21 12:45:31.850','2025-09-02 16:29:19.431'),('4bb5e86f-7957-4c26-a252-da37b19b70a0','c90fc0fb-6e97-4f9a-8237-89f9027dda42','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-15 00:00:00.000','2025-10-15 06:00:00.000','2025-10-15 07:15:00.000','CONCLUIDO',NULL,95.00,5.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-19 23:53:02.407','2025-10-20 00:17:06.069'),('4e645fa2-82c0-41a1-aab5-28e10034ac92','afca4870-c75d-488d-83ed-4f28d418cf35','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-11 00:00:00.000','2025-10-11 06:00:00.000','2025-10-11 06:45:00.000','CONCLUIDO',NULL,50.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-19 23:56:06.925','2025-10-20 00:16:37.754'),('5f3dd538-7d74-45ab-9109-55628b4cdce2','12ccf542-96bd-4136-a74c-724b0303e898','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-11-01 00:00:00.000','2025-11-01 10:30:00.000','2025-11-01 11:30:00.000','AGENDADO',NULL,110.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-16 18:40:01.695','2025-08-16 18:40:01.695'),('6024ca8d-4a08-4830-b629-d2d931b05eb3','be0d2cf3-1a2c-4aa8-9185-056eb799649b','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-15 00:00:00.000','2025-09-15 15:00:00.000','2025-09-15 16:15:00.000','CONCLUIDO','PIX',95.00,5.00,47.50,90.00,0.0000,'{\"originalPrice\":95,\"discount\":5,\"priceBeforeTax\":90,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":90}',NULL,NULL,'2025-09-15 19:00:57.134','2025-09-15 17:54:31.145','2025-09-15 19:00:57.137'),('71e98a87-b853-4c1b-9c20-d5d4feeef1f0','03f151e0-1f00-49e1-be58-daa009e46897','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-26 00:00:00.000','2025-07-26 16:30:00.000','2025-07-26 22:30:00.000','CONCLUIDO','PIX',700.00,40.00,NULL,NULL,NULL,NULL,'60g de pó, 40g 6.07',NULL,NULL,'2025-07-26 14:14:01.659','2025-07-26 22:45:18.949'),('73ce9ed2-baeb-4706-8697-e90ccc5effe6','b9621d0f-fcc9-4d99-8f3e-606018505a6e','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-05 00:00:00.000','2025-08-05 13:00:00.000','2025-08-05 19:00:00.000','CONCLUIDO','CARTAO_CREDITO_3X',635.00,0.00,317.50,555.69,0.1249,'{\"originalPrice\":635,\"discount\":0,\"priceBeforeTax\":635,\"taxRate\":0.1249,\"taxAmount\":79.3115,\"finalAmount\":555.6885}',NULL,NULL,'2025-08-05 17:40:23.888','2025-07-29 21:31:35.470','2025-08-05 17:40:23.890'),('7d7dccb4-f324-48be-af2e-c6657809ba16','9af998c8-7be6-4e21-8f60-e001e07e761a','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-25 00:00:00.000','2025-10-25 14:30:00.000','2025-10-25 18:45:00.000','AGENDADO',NULL,425.00,25.00,NULL,NULL,NULL,NULL,'Corte Helena ',NULL,NULL,'2025-10-22 12:43:36.960','2025-10-22 12:43:36.960'),('7e91d471-d813-4063-b79e-140f8f341dff','0ec556e2-3f57-463e-8e04-292c5a784c95','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-28 00:00:00.000','2025-07-29 00:00:00.000','2025-07-29 00:45:00.000','CANCELADO',NULL,50.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-28 20:45:56.069','2025-07-29 21:34:36.383'),('8e2b85bc-188c-4233-90ca-89e9da220e36','0ec556e2-3f57-463e-8e04-292c5a784c95','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-29 00:00:00.000','2025-07-30 01:09:00.000','2025-07-30 02:09:00.000','CANCELADO','DINHEIRO',100.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-30 00:09:29.487','2025-07-30 00:13:48.399'),('9646fcd4-d031-4562-9922-361022a282a1','36103683-b79e-4593-9956-c88c6cc015c2','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-17 00:00:00.000','2025-10-17 06:00:00.000','2025-10-17 06:45:00.000','CONCLUIDO',NULL,50.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-20 00:02:34.206','2025-10-20 00:17:56.830'),('972765a3-9333-4e18-9b28-d2c81ca29fac','6bfc70b6-3cab-44a9-9ac7-b915f8cb81b8','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-12-08 00:00:00.000','2025-12-08 10:00:00.000','2025-12-08 13:00:00.000','AGENDADO',NULL,250.00,NULL,NULL,NULL,NULL,NULL,'confirmar dia e horario uma semana antes',NULL,NULL,'2025-08-17 19:09:40.212','2025-08-17 19:09:40.212'),('978bec64-90dc-4366-a312-7177dabcbb14','0ec556e2-3f57-463e-8e04-292c5a784c95','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-07-28 00:00:00.000','2025-07-28 18:00:00.000','2025-07-28 18:45:00.000','CANCELADO','CARTAO_DEBITO',50.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-28 18:08:46.883','2025-08-01 15:37:54.980'),('9a40cad8-a238-44a6-b848-e627e4d763ef','2296c978-3eff-4b74-bca2-9e0d2f21d144','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-18 00:00:00.000','2025-10-18 06:00:00.000','2025-10-18 09:00:00.000','CONCLUIDO',NULL,200.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-19 23:50:24.959','2025-10-20 00:18:20.970'),('ad442e5c-f049-4f78-80ba-461189b40bb1','12ccf542-96bd-4136-a74c-724b0303e898','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-16 00:00:00.000','2025-08-16 14:30:00.000','2025-08-16 15:30:00.000','CONCLUIDO','PIX',130.00,10.00,65.00,120.00,0.0000,'{\"originalPrice\":130,\"discount\":10,\"priceBeforeTax\":120,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":120}',NULL,NULL,'2025-08-16 18:37:47.775','2025-08-14 16:59:12.170','2025-08-16 18:37:47.777'),('bce30a16-9508-4e78-99e7-f93cd60e6479','40a5cd95-9743-40b3-9b95-451351f2724b','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-04 00:00:00.000','2025-10-04 13:00:00.000','2025-10-04 14:00:00.000','CONCLUIDO',NULL,50.00,10.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-10 18:10:12.874','2025-10-20 00:16:23.760'),('bfaa04bf-3169-44c2-a527-e946ad35713b','b9621d0f-fcc9-4d99-8f3e-606018505a6e','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-05 00:00:00.000','2025-10-05 10:00:00.000','2025-10-05 13:00:00.000','CANCELADO',NULL,350.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-15 21:12:03.897','2025-10-19 23:58:48.428'),('bfb8957a-17b2-4d82-8d98-cb65addec2da','be0d2cf3-1a2c-4aa8-9185-056eb799649b','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-11-01 00:00:00.000','2025-11-01 12:01:00.000','2025-11-01 12:01:00.000','AGENDADO',NULL,0.00,NULL,NULL,NULL,NULL,NULL,'Lembrar de marcar em dezembro ',NULL,NULL,'2025-09-15 19:02:51.377','2025-09-15 19:02:51.377'),('c02e527f-6f3e-4839-bb9e-7f3cc0e3446b','7c3caa6c-a644-4f91-bf8e-7b7de3d1a466','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-06 00:00:00.000','2025-09-06 08:30:00.000','2025-09-06 09:15:00.000','CONCLUIDO','PIX',50.00,5.00,NULL,45.00,0.0000,'{\"originalPrice\":50,\"discount\":5,\"priceBeforeTax\":45,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":45}',NULL,NULL,'2025-09-06 15:10:34.473','2025-08-27 13:15:35.773','2025-09-06 15:10:34.475'),('c1748e43-cdcf-46cf-804c-29ea1f0970ff','e25fa365-4180-4d11-8320-9c75a7796215','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-04 00:00:00.000','2025-10-04 10:00:00.000','2025-10-04 12:15:00.000','CONCLUIDO',NULL,205.00,45.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-10-20 00:07:01.740','2025-10-20 00:16:04.451'),('c28f4334-b25f-48c0-a92c-760c9d9fe6c4','9af998c8-7be6-4e21-8f60-e001e07e761a','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-08 00:00:00.000','2025-09-08 07:30:00.000','2025-09-08 13:30:00.000','CONCLUIDO','PIX',845.00,90.00,NULL,755.00,0.0000,'{\"originalPrice\":845,\"discount\":90,\"priceBeforeTax\":755,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":755}',NULL,NULL,'2025-09-08 20:07:35.276','2025-09-02 16:28:12.649','2025-09-08 20:07:35.280'),('c7bffe10-a373-4f95-b6bd-789b6d6571c1','48ac9f3d-d000-43f9-abcc-4c9ae68cd7a8','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-10-20 00:00:00.000','2025-10-20 09:00:00.000','2025-10-20 17:00:00.000','AGENDADO',NULL,860.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-15 21:09:29.289','2025-08-15 21:09:29.289'),('c9e2f7dd-c221-41c0-84a2-68f06ab2aec5','8605f15a-5106-4fcb-a62b-8baee8464984','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-09-20 00:00:00.000','2025-09-20 10:30:00.000','2025-09-20 12:30:00.000','CANCELADO',NULL,160.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-30 15:32:44.305','2025-09-17 20:21:40.547'),('cd3b407c-d679-4f8e-8100-46b572f1638c','8605f15a-5106-4fcb-a62b-8baee8464984','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-30 00:00:00.000','2025-08-30 10:30:00.000','2025-08-30 12:30:00.000','CONCLUIDO','PIX',160.00,5.00,80.00,155.00,0.0000,'{\"originalPrice\":160,\"discount\":5,\"priceBeforeTax\":155,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":155}',NULL,NULL,'2025-08-30 15:28:07.305','2025-08-29 16:00:52.023','2025-08-30 15:28:07.308'),('d8a5f036-495e-4d5c-8a5b-0d6d8ac41cef','6ad89114-d47b-4bfa-a22a-b5d8a4aa8c98','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-16 00:00:00.000','2025-08-16 10:00:00.000','2025-08-16 13:00:00.000','CONCLUIDO','PIX',410.00,20.00,190.00,390.00,0.0000,'{\"originalPrice\":410,\"discount\":20,\"priceBeforeTax\":390,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":390}',NULL,NULL,'2025-08-16 16:26:52.121','2025-08-13 19:06:52.187','2025-08-16 16:26:52.123'),('e917bdde-4e94-4348-9583-e66b9d64fc12','9af998c8-7be6-4e21-8f60-e001e07e761a','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-09 00:00:00.000','2025-08-09 14:30:00.000','2025-08-09 18:30:00.000','CONCLUIDO','PIX',410.00,20.00,NULL,390.00,0.0000,'{\"originalPrice\":410,\"discount\":20,\"priceBeforeTax\":390,\"taxRate\":0,\"taxAmount\":0,\"finalAmount\":390}',NULL,'2025-08-09 17:04:37.879','2025-08-09 21:44:34.566','2025-07-29 21:32:23.195','2025-08-09 21:44:34.567'),('f02d7d9b-c81b-4770-9b3e-0b0c39965b33','48ac9f3d-d000-43f9-abcc-4c9ae68cd7a8','f481ccce-2af2-447a-abe2-f97e3cba9871','2025-08-04 00:00:00.000','2025-08-04 12:00:00.000','2025-08-04 15:00:00.000','CONCLUIDO','PIX',250.00,20.00,125.00,230.00,NULL,NULL,NULL,NULL,'2025-08-04 15:00:00.000','2025-07-29 21:28:51.175','2025-08-06 14:24:44.092');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthDate` datetime(3) DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('03f151e0-1f00-49e1-be58-daa009e46897','Josinete Maria de Moura','josinete.moura@yahoo.com','14988102890','2025-07-11 00:00:00.000',NULL,'Alérgica: amonia e componentes do petróleo',1,'2025-07-26 14:11:53.986','2025-07-26 22:43:25.910'),('0ec556e2-3f57-463e-8e04-292c5a784c95','Daniel',NULL,'14988117592','1999-02-17 00:00:00.000',NULL,NULL,1,'2025-07-26 22:37:52.852','2025-07-26 22:37:52.852'),('12ccf542-96bd-4136-a74c-724b0303e898','Vanessa José Oliveira dos Santos','vanessa.josoliveira@yahoo.com.br','14997292425','1989-05-24 00:00:00.000',NULL,NULL,1,'2025-08-14 16:58:24.945','2025-08-16 17:39:55.456'),('2296c978-3eff-4b74-bca2-9e0d2f21d144','Nicolas',NULL,'14999999999',NULL,NULL,NULL,1,'2025-10-19 23:47:28.979','2025-10-19 23:47:28.979'),('36103683-b79e-4593-9956-c88c6cc015c2','Tamires',NULL,'14999999999',NULL,NULL,NULL,1,'2025-10-20 00:01:58.745','2025-10-20 00:01:58.745'),('40a5cd95-9743-40b3-9b95-451351f2724b','Leonardo Toledo Sabbag','leonardo.2001toledo2001@gmail.com','(14) 99655-9335','2000-12-24 00:00:00.000',NULL,NULL,1,'2025-08-12 14:35:29.442','2025-08-15 21:05:07.343'),('48ac9f3d-d000-43f9-abcc-4c9ae68cd7a8','Cintia Mateus Quadros','cquadros72@gmail.com','13981382615','1995-01-14 00:00:00.000',NULL,'retoque a cada dois meses e meio \nproximo retoque cabelo todo + corte',1,'2025-07-29 21:21:54.149','2025-08-04 14:15:28.997'),('6ad89114-d47b-4bfa-a22a-b5d8a4aa8c98','Thaísa Nickelly Ferreira Gonçalves','tnickelly@gmail.com','14998433094','2001-10-14 00:00:00.000',NULL,NULL,1,'2025-08-13 19:05:41.590','2025-08-16 15:29:47.354'),('6bfc70b6-3cab-44a9-9ac7-b915f8cb81b8','Laura Rodrighero','laura_rodrighero@hotmail.com','14982071806','2001-09-03 00:00:00.000',NULL,NULL,1,'2025-08-17 14:06:54.128','2025-08-17 14:06:54.128'),('7c3caa6c-a644-4f91-bf8e-7b7de3d1a466','Talita Lima dos Santos','talitasantos4089@gmail.com','14988416372','2002-06-18 00:00:00.000',NULL,NULL,1,'2025-08-27 13:13:55.930','2025-09-06 15:12:15.533'),('8605f15a-5106-4fcb-a62b-8baee8464984','Paolla de Oliveira','paollarveira@gmail.com','1491482589','1997-02-24 00:00:00.000',NULL,NULL,1,'2025-08-29 16:00:04.145','2025-08-30 15:30:09.097'),('9146383f-bf25-48aa-bf6b-2da34961f8db','Matheus',NULL,'14999999999','2001-05-15 00:00:00.000',NULL,NULL,1,'2025-09-18 17:21:51.026','2025-09-18 17:21:51.026'),('9af998c8-7be6-4e21-8f60-e001e07e761a','Aline Andressa Oliveira França','aaofranca24@gmail.com','14991232082','1998-09-24 00:00:00.000',NULL,NULL,1,'2025-07-29 21:25:39.011','2025-08-09 18:54:34.799'),('ae065086-acf1-4d92-bba7-d2d3ea4a546e','Sthefany',NULL,'14991026117',NULL,NULL,NULL,1,'2025-08-21 12:43:40.584','2025-08-21 12:43:40.584'),('afca4870-c75d-488d-83ed-4f28d418cf35','Ana Flávia',NULL,'14999999999',NULL,NULL,NULL,1,'2025-10-19 23:53:48.059','2025-10-19 23:53:48.059'),('b9621d0f-fcc9-4d99-8f3e-606018505a6e','Annelise',NULL,'14997489461',NULL,NULL,NULL,1,'2025-07-29 21:27:40.401','2025-07-29 21:27:40.401'),('be0d2cf3-1a2c-4aa8-9185-056eb799649b','Wivina Mayara de Castro Gonçalves','wivina.castro@gmail.com','14988028955','1999-04-30 00:00:00.000',NULL,NULL,1,'2025-09-15 17:53:42.046','2025-09-15 19:04:48.627'),('c90fc0fb-6e97-4f9a-8237-89f9027dda42','Marinalva',NULL,'14999999999',NULL,NULL,NULL,1,'2025-10-19 23:52:16.529','2025-10-19 23:52:16.529'),('e25fa365-4180-4d11-8320-9c75a7796215','Mãe da Tamires',NULL,'14999999999',NULL,NULL,NULL,1,'2025-10-20 00:03:24.680','2025-10-20 00:03:24.680'),('eb454114-ee39-4968-be2e-b4f38bdc8f6c','Regina',NULL,'14999999999',NULL,NULL,NULL,1,'2025-08-21 12:44:31.932','2025-08-21 12:44:31.932');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry_money_categories`
--

DROP TABLE IF EXISTS `entry_money_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_money_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_money_categories_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry_money_categories`
--

LOCK TABLES `entry_money_categories` WRITE;
/*!40000 ALTER TABLE `entry_money_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `entry_money_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cost_variable_categories`
--

DROP TABLE IF EXISTS `cost_variable_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cost_variable_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `cost_variable_categories_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cost_variable_categories`
--

LOCK TABLES `cost_variable_categories` WRITE;
/*!40000 ALTER TABLE `cost_variable_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cost_variable_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixes_accounts_categories`
--

DROP TABLE IF EXISTS `fixes_accounts_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixes_accounts_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `fixes_accounts_categories_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixes_accounts_categories`
--

LOCK TABLES `fixes_accounts_categories` WRITE;
/*!40000 ALTER TABLE `fixes_accounts_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixes_accounts_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investments_categories`
--

DROP TABLE IF EXISTS `investments_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investments_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `investments_categories_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investments_categories`
--

LOCK TABLES `investments_categories` WRITE;
/*!40000 ALTER TABLE `investments_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `investments_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry_analytics`
--

DROP TABLE IF EXISTS `entry_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_analytics` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime(3) NOT NULL,
  `entryMoneyCategoryId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `entry_analytics_entryMoneyCategoryId_idx` (`entryMoneyCategoryId`),
  CONSTRAINT `entry_analytics_entryMoneyCategoryId_fkey` FOREIGN KEY (`entryMoneyCategoryId`) REFERENCES `entry_money_categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry_analytics`
--

LOCK TABLES `entry_analytics` WRITE;
/*!40000 ALTER TABLE `entry_analytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `entry_analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `out_analytics`
--

DROP TABLE IF EXISTS `out_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `out_analytics` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime(3) NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `costVariableCategoryId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fixesAccountsCategoryId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `investmentsCategoryId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `out_analytics_costVariableCategoryId_idx` (`costVariableCategoryId`),
  KEY `out_analytics_fixesAccountsCategoryId_idx` (`fixesAccountsCategoryId`),
  KEY `out_analytics_investmentsCategoryId_idx` (`investmentsCategoryId`),
  CONSTRAINT `out_analytics_costVariableCategoryId_fkey` FOREIGN KEY (`costVariableCategoryId`) REFERENCES `cost_variable_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `out_analytics_fixesAccountsCategoryId_fkey` FOREIGN KEY (`fixesAccountsCategoryId`) REFERENCES `fixes_accounts_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `out_analytics_investmentsCategoryId_fkey` FOREIGN KEY (`investmentsCategoryId`) REFERENCES `investments_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `out_analytics`
--

LOCK TABLES `out_analytics` WRITE;
/*!40000 ALTER TABLE `out_analytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `out_analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_flow_configs`
--

DROP TABLE IF EXISTS `cash_flow_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_flow_configs` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `initialBalance` decimal(10,2) NOT NULL,
  `prolabore` decimal(10,2) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_flow_configs_year_month_key` (`year`,`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_flow_configs`
--

LOCK TABLES `cash_flow_configs` WRITE;
/*!40000 ALTER TABLE `cash_flow_configs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_flow_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedure_products`
--

DROP TABLE IF EXISTS `procedure_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_products` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `procedureId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `productId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `procedure_products_procedureId_productId_key` (`procedureId`,`productId`),
  KEY `procedure_products_productId_fkey` (`productId`),
  CONSTRAINT `procedure_products_procedureId_fkey` FOREIGN KEY (`procedureId`) REFERENCES `procedures` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `procedure_products_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedure_products`
--

LOCK TABLES `procedure_products` WRITE;
/*!40000 ALTER TABLE `procedure_products` DISABLE KEYS */;
INSERT INTO `procedure_products` VALUES ('692af3c4-c425-44f8-a076-27c8e83ff9bd','2b507d5e-947a-474b-929e-ed3b50de1b8d','1c103883-cd7b-4b69-87cf-f14c693784b1'),('d1485f83-48de-41f8-af36-4416f9a265d7','2b507d5e-947a-474b-929e-ed3b50de1b8d','2bc96b5a-aa3f-4e9a-b115-521c5e057a8a'),('c9fd293f-cd7d-4a7d-948a-3b161de31528','2b507d5e-947a-474b-929e-ed3b50de1b8d','5f74e162-29a1-47d6-a8cc-04647b9410ef'),('6d57ebf3-8ab5-446b-8ac5-2d3ce9e79a7c','2b507d5e-947a-474b-929e-ed3b50de1b8d','90e3d497-e3d5-4715-b37c-2cca90ca76dc'),('7446ec50-6abc-4e71-b6af-8034e781bb7a','2b507d5e-947a-474b-929e-ed3b50de1b8d','9cfa9ad7-ead7-4299-8090-5804b69c4ba2'),('d425d0cd-10a7-4138-b81d-ef698bbbe6ec','2b507d5e-947a-474b-929e-ed3b50de1b8d','c80c8a22-aefc-4659-9302-2924bafcf58b'),('69b76a7e-742d-4b9b-886e-db9685895738','2b507d5e-947a-474b-929e-ed3b50de1b8d','e6e46b66-3603-4a07-a0f6-9e6f776aee1f'),('f17c7b25-1e49-4ef6-b4f5-a2213d0ad0d4','5491c64a-062f-484d-bff9-9257039b86d4','1c103883-cd7b-4b69-87cf-f14c693784b1'),('c1ea449f-fc61-49c7-909b-164f4b6a75e2','5491c64a-062f-484d-bff9-9257039b86d4','2bc96b5a-aa3f-4e9a-b115-521c5e057a8a'),('b86f5179-7ae4-4bc2-8b75-0ece6a8d6d95','5491c64a-062f-484d-bff9-9257039b86d4','5f74e162-29a1-47d6-a8cc-04647b9410ef'),('de984189-3141-4efe-89c0-05f59ed33921','5491c64a-062f-484d-bff9-9257039b86d4','90e3d497-e3d5-4715-b37c-2cca90ca76dc'),('6001c3cf-8ced-4a06-93ab-bc7dad9a9174','5491c64a-062f-484d-bff9-9257039b86d4','9cfa9ad7-ead7-4299-8090-5804b69c4ba2'),('8be0c01e-0d83-46de-a244-4f722e1a74c7','5491c64a-062f-484d-bff9-9257039b86d4','c80c8a22-aefc-4659-9302-2924bafcf58b'),('ccfb7b50-4288-47f8-8d9e-e790d60871b2','5491c64a-062f-484d-bff9-9257039b86d4','e6e46b66-3603-4a07-a0f6-9e6f776aee1f'),('6f3581ab-9e9c-4b99-9f7c-aeba48a6ffda','86ca167a-a1e0-4ef0-ad75-67326f6286bc','6a70b897-2a5c-4553-8094-b55065dcec4a'),('c871c94b-0081-4df2-b8a8-c6a92d452ac1','a3419f7a-3920-49d7-81c3-6ab8c5c8803e','d3d9bda5-77c8-4a5d-b87f-0dad6f2679f1');
/*!40000 ALTER TABLE `procedure_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedures`
--

DROP TABLE IF EXISTS `procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedures` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedures`
--

LOCK TABLES `procedures` WRITE;
/*!40000 ALTER TABLE `procedures` DISABLE KEYS */;
INSERT INTO `procedures` VALUES ('0197ff81-578a-4360-b1ea-3c8677d2fad3','Selagem Afro – Cabelo Curto','','CABELO',240,270.00,1,'2025-07-29 19:48:31.718','2025-07-29 19:48:31.718'),('01ea6f53-d976-4db3-a67b-efa7a3a9fbe3','Ritual Vênus Ruiva - Curto','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',240,510.00,1,'2025-07-29 20:24:53.242','2025-08-06 15:14:31.667'),('02326c24-37c5-449a-b8c2-4c85e5a0149c',' Coloração Comum – Cabelo Curto','','CABELO',120,250.00,1,'2025-07-29 19:20:33.811','2025-08-06 14:28:23.949'),('0744175a-6eea-4cac-8c18-1a8ed61701f2','Ritual Emily\'s Touch','','OUTROS',90,135.00,1,'2025-07-29 20:07:28.195','2025-07-29 20:07:48.981'),('08b9d783-8d27-475e-b974-50cf70f64715','Ritual Morana Iluminada - Extra Longo','Morena iluminada + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',420,1010.00,1,'2025-07-29 20:59:02.543','2025-08-06 14:59:11.157'),('0af0dbb4-67ce-478f-947f-3f797de4f8d1',' Protocolo Tratamento FEG (Celulite) (Sessão)','','ESTETICA_CORPORAL',90,110.00,1,'2025-07-29 20:00:06.282','2025-08-06 14:34:02.548'),('0bbea3f2-65a9-4bdc-b9ce-0da8d7de9101','Ritual Akasha','Limpeza + Drenagem facial + Detox facial','ESTETICA_FACIAL',180,230.00,1,'2025-07-29 21:15:39.371','2025-08-06 14:43:58.054'),('0f1d2945-efb0-4d6b-8926-adb82f8a7dfc',' Reflexologia e Escalda Pés ','','ESTETICA_CORPORAL',60,80.00,1,'2025-07-29 19:57:07.550','2025-08-06 14:34:24.347'),('0f5c1c00-a4bd-40a6-a656-7f6696299798',' Protocolo Tratamento Melasma (Sessão)','','ESTETICA_FACIAL',90,180.00,1,'2025-07-29 19:58:44.497','2025-08-06 14:34:18.329'),('107981f7-5588-4475-913c-4565746d8d1f','Ritual Segredo da Meia-Noite - Médio','Secret Hair + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',300,535.00,1,'2025-07-29 21:01:04.541','2025-08-06 15:06:30.365'),('10c34fd0-e6a3-4213-aff9-2cbcbbcacc40','Ritual Sonhos Pintados - Curto','Ombré hair colorido + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',300,545.00,1,'2025-07-29 21:03:15.497','2025-08-06 15:07:07.556'),('1746fcf7-43ab-45dd-bc50-93a689643fea','Massagem Clássica','','ESTETICA_CORPORAL',60,100.00,1,'2025-07-29 19:52:37.914','2025-08-06 14:40:14.350'),('17a3ee2c-3e2e-45da-bb8d-6c8bff1ca7ed',' Lavar + Finalização Modelada','','OUTROS',90,100.00,1,'2025-07-29 18:51:42.092','2025-07-29 18:55:36.741'),('1a145fd6-95a9-43ef-a0ca-87d682b7634b','Secret Hair – Cabelo Extra Longo','','CABELO',360,580.00,1,'2025-07-29 19:38:52.248','2025-08-06 15:17:09.852'),('1b5df1cc-b4a1-4c26-a903-bc791806c981','Henna – Cabelo Curto','','CABELO',120,120.00,1,'2025-07-29 19:29:17.275','2025-08-06 14:39:26.547'),('1be8a0af-dde2-49eb-95f9-91f7e30c6d77','Colorido Global – Cabelo Extra Longo','','CABELO',420,1200.00,1,'2025-07-29 19:44:06.620','2025-08-06 14:37:24.303'),('1ce11b84-bbeb-4547-9cbd-6b67ca459c0f','Corte + Finalização Simples','','CORTE',75,95.00,1,'2025-07-29 18:53:19.161','2025-07-29 18:55:25.869'),('1d09bdb4-7714-4d1b-af86-36b99962de7c','Morena Iluminada - Cabelo Médio ','','CABELO',360,600.00,1,'2025-07-26 14:10:55.651','2025-08-06 14:40:47.941'),('1d8f645e-e4a7-4854-ab47-06ae10d2e38c','Massagem Facial','','ESTETICA_FACIAL',30,45.00,1,'2025-07-29 19:51:41.672','2025-08-06 14:40:22.858'),('1f68dcde-ebed-45fd-ad2f-3ba7fc06486d','Ritual Vênus Gótica - Médio','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',240,745.00,1,'2025-07-29 20:21:48.719','2025-08-06 15:14:38.186'),('20d346d1-acaf-414f-8cd1-2348a3306c59','Ritual Espelho das Bruxas - Longo','Alisamento + tratamento + corte + escova babyliss/chapinha','CORTE',420,780.00,1,'2025-07-29 21:09:51.409','2025-08-06 14:54:40.459'),('20dc51b6-9976-4735-8979-864889864ea9','Peeling de Diamante ','','ESTETICA_FACIAL',60,80.00,1,'2025-07-29 19:56:09.453','2025-08-06 14:41:11.308'),('23dec80a-d1f1-441f-9493-36a1ab75e9d1','Alisamento – Cabelo Extra Longo','','ALISAMENTO',480,860.00,1,'2025-07-29 19:47:15.625','2025-07-29 19:47:15.625'),('28d7938e-cc2f-4bb2-aae0-021506bbcf63',' Detox Corporal','','ESTETICA_CORPORAL',90,110.00,1,'2025-07-29 19:56:40.567','2025-08-06 14:29:33.677'),('29c226be-2490-47f5-bb8f-90a278375e4c','Ritual Sonhos Pintados - Longo','Ombré hair colorido + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',420,645.00,1,'2025-07-29 21:04:17.788','2025-08-06 15:07:31.345'),('2aff6f1f-3f5d-4eb3-aae3-59a666d622ca',' Microagulhamento Facial','','ESTETICA_FACIAL',120,210.00,1,'2025-07-29 19:53:55.802','2025-08-06 14:32:19.770'),('2b507d5e-947a-474b-929e-ed3b50de1b8d','Design de Sobrancelha','Olhares que hipnotizam. Realçamos suas sobrancelhas com técnica e sensibilidade, revelando a expressão natural da sua beleza — com um toque bruxesco de sofisticação.','OUTROS',45,50.00,0,'2025-07-28 17:46:39.922','2025-07-28 18:47:48.157'),('2c81463a-a212-4f46-bdac-46ae32e3bece','Ritual Carrie','Buço + Axila + Perna completa + Virilha completa','EPILACAO',120,150.00,1,'2025-07-29 21:17:54.955','2025-08-06 14:46:02.258'),('2d1ba461-b600-4d00-9eab-d1fb8622784d',' Morena Iluminada – Cabelo Curto','','CABELO',180,400.00,1,'2025-07-29 19:34:02.864','2025-08-06 14:32:47.144'),('2e2fba44-1643-4a66-85c7-045ebe6a72ca',' Corte + Escova + Chapinha/Babyliss','','ALISAMENTO',120,150.00,1,'2025-07-29 18:54:43.798','2025-08-06 14:29:23.856'),('32864a67-d817-4da1-8ad7-020e0a0dfa9d',' Coloração Comum – Cabelo Médio','','CABELO',150,340.00,1,'2025-07-29 19:21:23.215','2025-08-06 14:29:14.283'),('33f5b836-cb22-46c6-bd1c-89c712c8bac3','Ritual de Transmutação - Médio','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',240,545.00,1,'2025-07-29 20:28:26.825','2025-08-06 14:48:24.997'),('34a77004-5a9e-43d9-a635-57db0e4d4ebe','Colorido Global – Cabelo Curto','','CABELO',180,600.00,1,'2025-07-29 19:42:24.495','2025-08-06 14:37:17.477'),('34b701fc-fcbb-462d-9c9d-55cca5ea4208','Ritual de Transmutação - Curto','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',180,450.00,1,'2025-07-29 20:27:51.038','2025-08-06 14:47:50.047'),('34e0b02d-296b-42bd-90c3-acb19cfb1703','Epilação Buço ','','EPILACAO',20,20.00,1,'2025-07-29 20:01:49.313','2025-08-06 14:38:59.510'),('374500ac-3851-4b76-8120-200b02964cbf','Ritual Toque de Magia Negra - Longo','Design de sobrancelha + Henna capilar + Tratamento + corte + finalização modelada','COLORACAO',210,450.00,1,'2025-07-29 20:37:53.730','2025-08-06 15:09:23.117'),('3999ce42-b199-4633-b364-961ae4de5a8b','Reconstrução – Cabelo Longo','','CABELO',90,220.00,1,'2025-07-29 19:17:26.606','2025-07-29 19:17:26.606'),('3a12194b-402b-41c6-a916-f9d300cb750b','Ritual Elvira','Coloração + Corte + Tratamento + Finalização modelada','EPILACAO',150,210.00,1,'2025-07-29 21:18:23.710','2025-08-06 14:50:11.554'),('3bfe7c7f-1c0a-48b4-8a32-cd10437d3d46','Ritual Espelho das Bruxas - Extra Longo','Alisamento + tratamento + corte + escova babyliss/chapinha','CORTE',480,925.00,1,'2025-07-29 21:10:12.127','2025-08-06 14:54:29.614'),('3c059427-5968-48f6-ba2e-cc09d34dd310','Ritual Vênus Gótica - Longo ','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',300,560.00,1,'2025-07-29 20:22:09.285','2025-08-06 15:14:44.941'),('3c271db0-69fb-49b5-9058-8c1e9f78adaa',' Massagem Relaxante','','ESTETICA_CORPORAL',60,100.00,1,'2025-07-29 19:53:01.022','2025-08-06 14:32:02.690'),('3d1d5ae2-9b0d-444c-9239-9e4d011888c3','Coloração Sobrancelha ','','OUTROS',30,10.00,1,'2025-08-16 15:32:04.161','2025-08-16 15:32:04.161'),('3e441d7b-4fe8-4af5-86f9-852d099e18cc','Selagem Afro – Cabelo Longo','','CABELO',360,530.00,1,'2025-07-29 19:49:30.464','2025-07-29 19:49:30.464'),('3feca299-789c-48cf-94e6-b4739eeb9928',' Coloração Comum – Cabelo Extra Longo','','CABELO',240,500.00,1,'2025-07-29 19:23:35.898','2025-08-06 14:28:39.069'),('40221573-20f3-4dc3-b6f5-af217f0afc8d',' Bambuterapia','','OUTROS',60,100.00,0,'2025-07-29 19:54:45.347','2025-08-06 14:26:14.739'),('411f4e8c-98cc-436e-a766-6e666d7510a8','Ritual Selene - Curto ','Tratamento + Corte + Escova + Babyliss/chapinha','CORTE',120,235.00,1,'2025-10-22 18:46:36.000','2025-10-22 18:46:48.150'),('4264a93b-3afb-49d0-afa3-4a0638a085cc',' Ombré Colorido – Cabelo Extra Longo','','CABELO',480,620.00,1,'2025-07-29 19:41:30.548','2025-08-06 14:33:15.291'),('4520fc30-1806-4edb-bb76-7ca4788976dc','Detox Cabelo Longo','','CABELO',90,180.00,1,'2025-07-29 18:57:35.974','2025-07-29 18:57:35.974'),('466ae2b9-21e3-4e16-b8c5-6610e3631fdb','Reconstrução – Cabelo Médio','','CABELO',75,190.00,1,'2025-07-29 19:16:57.427','2025-07-29 19:16:57.427'),('4790ca1f-72ae-4b3d-ad2b-d5e17693335a','Ritual Segredo da Meia-Noite - Extra Longo','Secret Hair + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',420,645.00,1,'2025-07-29 21:01:48.787','2025-08-06 15:06:09.343'),('49319af3-1586-4aeb-b362-6c3b6f339a8b','Detox Facial','','ESTETICA_FACIAL',30,60.00,1,'2025-07-29 19:52:10.139','2025-08-06 14:38:36.140'),('49eec65b-060c-418c-897c-c307e3bb98fd','Retoque de Raiz Ruivo','','COLORACAO',180,350.00,1,'2025-07-29 19:24:56.773','2025-08-06 14:41:58.142'),('4a19edb7-671c-4006-b82f-26a9e8e62f05','Henna – Cabelo Longo','','CABELO',150,160.00,1,'2025-07-29 19:30:11.145','2025-08-06 14:39:36.220'),('4b296aa4-7ef4-4437-9d66-80f7fa17f8d2','Nutrição – Cabelo Médio','','CABELO',60,130.00,1,'2025-07-29 19:14:46.341','2025-07-29 19:14:46.341'),('4bfe61db-43ca-4f0d-ac4a-e7f07ecb0110','Ritual Feitiço de Lótus - Extra Longo ','Design de sobrancelha + Tratamento + Finalização modelada','TRATAMENTO',150,200.00,1,'2025-07-29 20:11:18.226','2025-08-06 14:55:52.027'),('4c20afd8-a32c-41f5-bbad-b03c2aab2637','Retoque de Raiz Comum','','COLORACAO',120,180.00,1,'2025-07-29 19:18:43.786','2025-08-06 14:41:54.340'),('4e53f5cb-02b0-44ec-af6f-c47737bd37a2',' Epilação Perna Completa','','EPILACAO',60,60.00,1,'2025-07-29 20:05:01.313','2025-08-06 14:29:51.901'),('4e5d1f8f-70c2-4137-a8bc-eb060fa59f1f','Protocolo Tratamento Estrias (Sessão)','','ESTETICA_CORPORAL',90,180.00,1,'2025-07-29 20:00:34.960','2025-08-06 14:41:23.456'),('54061f0f-5dc0-45f2-a2ee-31493b1bb363','Alisamento – Retoque de Raiz','','ALISAMENTO',180,250.00,1,'2025-07-29 19:45:25.641','2025-07-29 19:45:25.641'),('546f2027-57f7-47e8-beb9-2dfafd169a39','Ritual Valsa dos Espíritos - Médio','Design de sobrancelha + Tratamento + Corte +  Escova com chapinha/babyliss','CORTE',120,290.00,1,'2025-07-29 20:14:27.960','2025-08-06 15:15:51.079'),('5491c64a-062f-484d-bff9-9257039b86d4','Design de Sobrancelha','Olhares que hipnotizam. Redesenhamos suas sobrancelhas com técnica e sensibilidade, revelando a expressão natural da sua beleza — com um toque bruxesco de sofisticação','ESTETICA_FACIAL',45,50.00,1,'2025-07-28 18:51:10.244','2025-08-06 14:38:09.378'),('55f430c4-4b60-44d2-9130-371bbb4ba771',' Loiro – Cabelo Longo','','CABELO',360,900.00,1,'2025-07-29 19:32:34.798','2025-08-06 14:31:41.126'),('55f64a3b-208d-4051-a1c9-a1a8f3ca40a1','Ritual Valsa dos Espíritos - Curto','Design de sobrancelha + Tratamento + Corte +  Escova com chapinha/babyliss','CORTE',120,270.00,1,'2025-07-29 20:14:11.221','2025-08-06 15:11:17.545'),('56271e1f-9efc-4d8c-82f5-ccbe8a2defaf','Ritual Mistério Platinado - Longo','Loiro + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',420,925.00,1,'2025-07-29 20:47:33.536','2025-08-06 14:57:51.073'),('567c0509-c220-48ae-9135-6b866f01e152','Ritual Vênus Gótica - Curto','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',180,380.00,1,'2025-07-29 20:21:20.073','2025-08-06 15:15:17.361'),('56808b33-6944-4c86-affe-400fb1c306be','Selagem Afro – Cabelo Médio','','CABELO',300,390.00,1,'2025-07-29 19:49:06.941','2025-07-29 19:49:06.941'),('589cdff5-31e9-4443-972c-66afaf048c95',' Protocolo Tratamento Acne (Sessão)','','ESTETICA_FACIAL',90,160.00,1,'2025-07-29 19:57:49.309','2025-08-06 14:33:42.516'),('58ba0e27-c4a2-42fb-b78d-7144a8269674','Corte Franja ','','CORTE',30,20.00,1,'2025-08-16 15:31:04.779','2025-08-16 15:31:04.779'),('5a316ce6-f27f-41aa-82dd-a2b3803a2852','Ritual Morana Iluminada - Longo','Morena iluminada + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',360,845.00,1,'2025-07-29 20:58:33.317','2025-08-06 14:59:22.458'),('5ab773ce-c780-448c-b184-120288347083','Escova Progressiva','Alisamento com produtos naturais','ALISAMENTO',240,200.00,0,'2025-07-25 18:44:24.110','2025-07-25 18:45:03.228'),('5b830f0e-be0f-464b-9aae-ecda6efd4cd2','Ritual Rainha da Floresta Sombria - Longo','selagem afro + Tratamento + corte + escova Babyliss/chapinha','CORTE',420,610.00,1,'2025-07-29 21:12:43.633','2025-08-06 15:03:39.365'),('5e827ab8-cfe2-4e59-8416-5b51a3c40a31','Ritual Rainha da Floresta Sombria - Curto','Selagem afro + tratamento + corte + escova babyliss/chapinha','CORTE',300,375.00,1,'2025-07-29 21:11:16.865','2025-08-06 15:03:18.999'),('5ebdca19-aff1-4a0e-a983-9c6b4f4a3916','Alisamento - Retoque de Raiz Loiras ','','ALISAMENTO',180,330.00,1,'2025-10-22 12:41:22.010','2025-10-22 12:41:22.010'),('5f04b1f0-5e50-462b-b123-32ed657d13ae',' Massagem com Pedras Quentes','','ESTETICA_CORPORAL',60,120.00,1,'2025-07-29 19:54:20.998','2025-08-06 14:31:55.592'),('62397c02-3b3a-4e8f-84d2-a440249dc863','Ritual Feitiço de Lótus - Longo','Design de sobrancelha + Tratamento + Finalização modelada','TRATAMENTO',150,180.00,1,'2025-07-29 20:10:58.093','2025-08-06 14:55:58.957'),('64f83109-a340-4463-a4be-a8b2d44edfcc','Ritual Mortícia','Drenagem linfática + Detox corporal','ESTETICA_CORPORAL',120,185.00,1,'2025-07-29 21:16:33.055','2025-08-06 15:00:13.364'),('659ef453-ad87-4790-8567-68d141f5440b',' Ombré Colorido – Cabelo Médio','','CABELO',360,500.00,1,'2025-07-29 19:40:38.892','2025-08-06 14:33:35.690'),('68e48ef0-1f16-46de-9ba7-e0392f0ed8a5',' Coloração Comum – Cabelo Longo','','CABELO',170,420.00,1,'2025-07-29 19:22:40.835','2025-08-06 14:29:05.503'),('69f47014-582d-435c-9bd0-9575a77691fc','Ritual Morana Iluminada - Curto','Morena iluminada + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',240,490.00,1,'2025-07-29 20:49:20.055','2025-08-06 14:58:38.650'),('6b672953-4f1f-47bb-bdb0-994c2a6ad161','Selagem Afro – Cabelo Extra Longo','','CABELO',420,660.00,1,'2025-07-29 19:50:07.011','2025-07-29 19:50:07.011'),('6c5c8412-b19a-48b4-a81b-8bb8a149ad76','Detox Cabelo Extra Longo','','CABELO',120,200.00,1,'2025-07-29 18:58:22.679','2025-08-06 14:38:21.177'),('6dda837c-b1eb-4fba-bbbe-20cf68bf31dc','Ritual Sussurros de Cera','Buço + Axila + Meia perna + Virilha simples','EPILACAO',120,120.00,1,'2025-07-29 21:17:10.804','2025-08-06 15:08:10.887'),('71b575d4-46cd-4cd3-9da2-aacfb05c43d3','Detox Capilar – Cabelo Curto','','CABELO',90,140.00,1,'2025-07-29 18:56:27.216','2025-07-29 18:56:27.216'),('72189b8f-838e-4f54-ab47-2e6bc1d8cab3','Ritual Encanto de Sangue de Fada - Extra Longo','Design de sobrancelha + Henna capilar + Tratamento + escova Babyliss/chapinha','COLORACAO',210,370.00,1,'2025-07-29 20:34:35.539','2025-08-06 14:52:59.619'),('735f332d-9dce-4939-bed9-a5ad76e15439','Protocolo Rejuvenescimento (Sessão)','','ESTETICA_FACIAL',90,120.00,1,'2025-07-29 19:58:21.092','2025-08-06 14:41:19.029'),('737c83b6-8057-4de3-b9c4-9f7d2ce26442','Ritual Mistério Platinado - Médio','Loiro + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',360,745.00,1,'2025-07-29 20:47:02.162','2025-08-06 14:58:04.183'),('74be93cf-1b6f-468a-b3dc-da43b67d8946','Epilação Meia Perna','','EPILACAO',30,45.00,1,'2025-07-29 20:04:36.239','2025-08-06 14:39:13.506'),('759c03e5-bef6-45a3-9442-e26bcd3046db','Ritual Segredo da Meia-Noite - Curto','Secret Hair + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',240,470.00,1,'2025-07-29 21:00:35.236','2025-08-06 15:05:58.465'),('75cbc1f2-e409-48a6-a950-10e007e75ecf','Ritual Rainha da Floresta Sombria - Médio','selagem afro + Tratamento + corte + escova Babyliss/chapinha','CORTE',360,485.00,1,'2025-07-29 21:11:58.871','2025-08-06 15:03:45.363'),('75cdecce-b79c-4a48-9761-167cb956a53d','Ritual Toque de Magia Negra - Extra Longo','Design de sobrancelha + Henna capilar + Tratamento + corte + finalização modelada','COLORACAO',210,485.00,1,'2025-07-29 20:38:32.156','2025-08-06 15:09:14.258'),('76100988-027a-41f1-b5ba-4538f49d0b43',' Protocolo Tratamento Flacidez (Sessão)','','ESTETICA_CORPORAL',90,180.00,1,'2025-07-29 20:01:00.419','2025-08-06 14:34:09.069'),('76daf4ae-2a69-446c-9e6b-fd21a911640f','Ritual Espelho das Bruxas - Médio','Alisamento + tratamento + corte + escova babyliss/chapinha','CORTE',360,620.00,1,'2025-07-29 21:09:29.701','2025-08-06 14:55:02.797'),('78693baf-667e-44f1-9815-f55d4714987e','Ritual Sonhos Pintados - Extra Longo','Ombré hair colorido + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',480,695.00,1,'2025-07-29 21:04:42.573','2025-08-06 15:07:23.413'),('7a3252b8-eeb5-4124-ba96-4d39ceb30a96','Ritual Espelho das Bruxas - Curto','Alisamento + tratamento + corte + escova babyliss/chapinha','CORTE',300,470.00,1,'2025-07-29 21:08:48.763','2025-08-06 14:54:16.096'),('7b2a735d-e997-44bf-be91-6c9b1de98271','Secret Hair – Cabelo Curto','','CABELO',180,380.00,1,'2025-07-29 19:37:25.171','2025-08-06 15:17:05.458'),('7b70f683-c7ed-41d4-8f94-568a20282a6c','Coloração Ruivo – Cabelo Médio','','CABELO',210,500.00,1,'2025-07-29 19:27:15.863','2025-08-06 14:37:11.331'),('7b9d316c-3040-45b2-ae15-51eb40502bf2','Coloração Ruivo – Cabelo Curto','','CABELO',180,400.00,1,'2025-07-29 19:25:34.233','2025-08-06 14:35:12.534'),('7bffbbdc-45d2-45c7-abd7-72cf73c9983f','Limpeza de Pele','','ESTETICA_FACIAL',120,160.00,1,'2025-07-29 19:50:45.923','2025-08-06 14:40:06.967'),('7c8e8a9a-ca52-4757-ae0c-22b60f60344c','Nutrição – Cabelo Extra Longo','','CABELO',90,170.00,1,'2025-07-29 19:15:42.369','2025-07-29 19:15:42.369'),('7db61c14-5d55-4d45-b594-d989beefb3f4',' Morena Iluminada – Cabelo Extra Longo','','CABELO',360,1000.00,1,'2025-07-29 19:35:39.757','2025-08-06 14:32:54.868'),('7f8e78d4-c50a-47e8-880c-edc99a50effb','Ritual de Transmutação - Extra Longo','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',360,720.00,1,'2025-07-29 20:29:22.015','2025-08-06 14:48:00.207'),('7fcaccac-c9a7-4cf1-b324-5028638025db','Ritual de Transmutação (Ruivas) - Curto','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',240,450.00,1,'2025-07-29 20:30:20.377','2025-08-06 14:49:02.239'),('807462a7-93e2-41eb-bc7d-32a369fa5e83',' Selagem Afro – Retoque de Raiz','','OUTROS',180,200.00,1,'2025-07-29 19:47:50.540','2025-07-29 19:47:50.540'),('80acf210-4f03-4581-9bb8-ac490c859d72','Ritual Mistério Platinado - Curto','Loiro + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',300,575.00,1,'2025-07-29 20:46:18.029','2025-08-06 14:57:27.000'),('8272b097-93cb-4983-8c4e-1cee091bb6c5',' Epilação Virilha Completa','','EPILACAO',60,60.00,1,'2025-07-29 20:05:54.506','2025-08-06 14:30:06.510'),('82ac8611-d803-430f-8a27-c9e072baaa40','Secret Hair – Cabelo Longo','','CABELO',300,520.00,1,'2025-07-29 19:38:21.618','2025-08-06 15:17:17.754'),('83d1b862-fe5b-41c8-9e1f-70c4e4e5438f','Corte Masculino ','','CORTE',60,50.00,1,'2025-08-12 14:37:19.827','2025-08-12 14:37:38.939'),('84010923-1bb7-4c2f-a6e8-0ff789806fbf','Hidratação – Cabelo Longo','','CABELO',75,150.00,1,'2025-07-29 19:00:42.087','2025-07-29 19:00:42.087'),('8447b622-ffd4-43a2-a203-f2f909fbacf7','Peeling','','ESTETICA_FACIAL',120,200.00,1,'2025-07-29 19:55:21.226','2025-08-06 14:41:01.310'),('86ca167a-a1e0-4ef0-ad75-67326f6286bc','teste','','OUTROS',90,200.00,0,'2025-07-26 22:38:16.826','2025-07-28 11:17:56.480'),('87740107-5129-4778-b81b-920d2f0f99a6','Hidratação','Tratamento capilar nutritivo',NULL,90,60.00,0,'2025-07-25 18:44:24.113','2025-07-25 18:45:04.748'),('886ad464-048d-40c8-928b-6d92ed2996c4',' Epilação Braço','','EPILACAO',40,50.00,1,'2025-07-29 20:04:08.041','2025-08-06 14:29:44.473'),('8adc1cfc-f19f-4854-ac08-a5add93dec19','Ritual Rainha da Floresta Sombria - Extra Longo','selagem afro + Tratamento + corte + escova Babyliss/chapinha','CORTE',480,730.00,1,'2025-07-29 21:13:19.128','2025-08-06 15:03:32.279'),('8b2a6ae7-d0a4-43c5-a2f0-2963c380e3c6','Henna – Cabelo Médio','','CABELO',120,140.00,1,'2025-07-29 19:29:40.399','2025-08-06 14:39:48.743'),('8d754c5d-9f82-47fd-8dd0-784bd71b53b9','Alisamento – Cabelo Médio','','ALISAMENTO',360,520.00,1,'2025-07-29 19:46:32.260','2025-07-29 19:46:32.260'),('8df2f262-bbcc-4478-bc8e-30f91e104a7d','Corte + Finalização Modelada','','CORTE',90,130.00,1,'2025-07-29 18:54:06.887','2025-07-29 18:54:52.215'),('8ffce0c8-805b-4732-942a-c694f7e3aede','Ritual Vênus Ruiva - Longo','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',360,720.00,1,'2025-07-29 20:26:11.571','2025-08-06 15:16:46.607'),('94298ff0-8c56-4c34-ab34-76356706bbaa','Ritual Poção da Lua Nova - Longo','Design de sobrancelha + detox capilar + corte + finalização modelada','CORTE',180,335.00,1,'2025-07-29 20:19:36.728','2025-08-06 15:02:09.814'),('9485c88a-9d0f-4fa9-87e8-d024e8391d76','Lavar + Escova + Chapinha/Babyliss','','ALISAMENTO',90,120.00,1,'2025-07-29 18:52:33.726','2025-07-29 18:52:33.726'),('94a2f894-7b33-4ff5-b829-bd878cf03f10','Ritual Sal Negra - Extra Longo','Design de sobrancelha + Detox capilar + finalização modelada','TRATAMENTO',150,220.00,1,'2025-07-29 20:16:51.437','2025-08-06 15:04:29.450'),('976ffadc-dcde-44fd-a81f-168e9712fadd',' Loiro – Cabelo Extra Longo','','CABELO',480,1100.00,1,'2025-07-29 19:33:18.385','2025-08-06 14:31:36.138'),('9e8c0494-8cf9-44eb-9818-28fd17cc2946','Lavar + Finalização Simples','','OUTROS',60,75.00,1,'2025-07-29 18:47:55.937','2025-07-29 18:50:03.035'),('9f1e1719-a3d8-47c8-8ef9-fce0e91ff229',' Ombré Colorido – Cabelo Longo','','CABELO',420,560.00,1,'2025-07-29 19:41:06.467','2025-08-06 14:33:27.268'),('a1ee4557-a2d7-42d9-8e3a-3a4edaded118','Ritual das Bruxas','Axila + Costas/Peito/Braço + Perna completa + Virilha completa','EPILACAO',150,175.00,1,'2025-07-29 21:19:33.417','2025-08-06 14:46:49.795'),('a3419f7a-3920-49d7-81c3-6ab8c5c8803e','progressiva','','OUTROS',90,2000.00,0,'2025-07-25 18:44:54.689','2025-07-25 18:45:06.534'),('a3eb67b8-c6b6-4ee7-9d6c-1afc56ebf310','Ritual Feitiço de Lótus - Médio','Design de sobrancelha + Tratamento + Finalização modelada','TRATAMENTO',120,160.00,1,'2025-07-29 20:10:30.964','2025-08-06 14:56:11.207'),('a5343a24-c440-4ff2-a27a-39bc4566e8d3','detox','Purificação profunda do couro cabeludo. Removemos resíduos, impurezas e energias pesadas. Um verdadeiro exorcismo capilar para abrir caminho para o crescimento saudável.','OUTROS',90,120.00,0,'2025-07-29 18:46:04.784','2025-07-29 18:46:11.312'),('a73d6dfb-48d2-4e12-8f07-fdc2bf86264d',' Loiro – Cabelo Curto','','CABELO',240,500.00,1,'2025-07-29 19:31:26.504','2025-08-06 14:31:28.256'),('a7cade05-356a-4fd5-bcd7-8087141a92d3','Henna – Cabelo Extra Longo','','CABELO',150,180.00,1,'2025-07-29 19:30:33.566','2025-08-06 14:39:31.747'),('a8b4278e-1c2a-4da0-bbec-590dee086c2b','Hidratação – Cabelo Médio','','CABELO',60,130.00,1,'2025-07-29 19:00:11.471','2025-07-29 19:00:11.471'),('ab58f02e-fac4-4c49-b17b-8cd06bc81778','Ritual Arco-Íris Sombrio - Médio',' Colorido global + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',300,875.00,1,'2025-07-29 21:06:14.056','2025-08-06 14:45:25.662'),('ae0813f3-cca1-4bef-b541-ec00040eee8b','Colorido global - infantil masc ','','CABELO',180,200.00,1,'2025-10-19 23:49:36.275','2025-10-19 23:49:36.275'),('b0f02997-0c43-4c11-887b-eb4253ce71f4','Detox Cabelo Médio','','CABELO',90,160.00,1,'2025-07-29 18:57:06.942','2025-07-29 18:57:06.942'),('b47931c6-1644-473e-9a51-670f61d8eb7e','Reconstrução – Cabelo Extra Longo','','CABELO',90,250.00,1,'2025-07-29 19:17:53.301','2025-07-29 19:17:53.301'),('b6255d0e-0293-4c9f-b4f8-ec7377297cef','Coloração Ruivo – Cabelo Longo','','CABELO',240,600.00,1,'2025-07-29 19:28:08.696','2025-08-06 14:37:06.575'),('b7cdba77-a9e8-4770-8ed7-e68b18c7016d','Hidratação – Cabelo Curto','','CABELO',60,110.00,1,'2025-07-29 18:59:15.352','2025-07-29 18:59:15.352'),('b86462a0-b24b-4a8d-b9d4-102ec548cb35','Ritual Poção da Lua Nova - Curto','Design de sobrancelha + detox capilar + corte + finalização modelada','CORTE',150,300.00,1,'2025-07-29 20:18:58.722','2025-08-06 15:01:36.244'),('b8fb5412-f884-4570-aed6-359ab6c83fd6','Ritual de Transmutação (Ruivas) - Longo','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',360,635.00,1,'2025-07-29 20:31:12.350','2025-08-06 14:49:19.194'),('bcae357b-aef0-45e7-8537-ee93877aac89','Nutrição – Cabelo Longo','','CABELO',75,150.00,1,'2025-07-29 19:15:14.680','2025-07-29 19:15:14.680'),('bd310910-c4c4-4802-bb1b-b12af55645e1','Ritual Feitiço de Lótus - Curto','Design de sobrancelha + Tratamento + Finalização modelada','TRATAMENTO',120,145.00,1,'2025-07-29 20:09:46.550','2025-08-06 14:55:44.123'),('bdccf3ff-4190-406b-98d0-7ee6547def3b','Ritual Valsa dos Espíritos - Extra Longo','Design de sobrancelha + Tratamento + Corte +  Escova com chapinha/babyliss','CORTE',150,325.00,1,'2025-07-29 20:15:08.732','2025-08-06 15:11:10.318'),('bf702607-ef43-49b7-bb1c-67ff1f7f7119','Ritual Arco-Íris Sombrio - Curto',' Colorido global + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',240,690.00,1,'2025-07-29 21:05:36.008','2025-08-06 14:44:39.845'),('c198cb5d-76b9-4337-b186-607d94d85725','Ritual Morana Iluminada - Médio','Morena iluminada + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',300,670.00,1,'2025-07-29 20:58:10.565','2025-08-06 14:59:32.846'),('c1c23642-ccde-46d8-9214-02423d93e912','Hidratação – Cabelo Extra Longo','','CABELO',90,170.00,1,'2025-07-29 19:01:14.795','2025-07-29 19:01:14.795'),('c2245cba-8116-435b-9040-fbbf61010e95','Ritual Poção da Lua Nova - Extra Longo','Design de sobrancelha + detox capilar + corte + finalização modelada','CORTE',180,355.00,1,'2025-07-29 20:19:57.797','2025-08-06 15:01:47.901'),('c6e46a78-d1a6-4b4f-8d02-dc8dccbae2e1','Ritual Encanto de Sangue de Fada - Curto','Design de sobrancelha + Henna capilar + Tratamento + escova Babyliss/chapinha','COLORACAO',180,265.00,1,'2025-07-29 20:33:21.241','2025-08-06 14:52:33.874'),('c71ea83b-e313-4d6d-9f34-6c7138a2346d','Ritual Mistério Platinado - Extra Longo','Loiro + tratamento + corte + escova babyliss/chapinha','DESCOLORACAO',480,1090.00,1,'2025-07-29 20:48:03.894','2025-08-06 14:57:35.776'),('c99b1f1b-947f-409c-bb95-89d477445a1f','Peeling de Cristal','','ESTETICA_FACIAL',60,80.00,1,'2025-07-29 19:55:45.123','2025-08-06 14:41:06.606'),('cb0b75d5-f0f5-45b8-ae1a-cbf689edcf6e','Ritual Toque de Magia Negra - Médio','Design de sobrancelha + Henna capilar + Tratamento + corte + finalização modelada','COLORACAO',180,415.00,1,'2025-07-29 20:37:22.850','2025-08-06 15:09:30.723'),('cd096432-ea6b-4b9c-b57c-3fa1db24e706','Drenagem Linfática','','ESTETICA_CORPORAL',60,100.00,1,'2025-07-29 19:53:25.485','2025-08-06 14:38:47.915'),('cdc737da-a52e-476a-b77b-796068a463bb','Ritual Valsa dos Espíritos - Longo','Design de sobrancelha + Tratamento + Corte +  Escova com chapinha/babyliss','CORTE',150,310.00,1,'2025-07-29 20:14:51.510','2025-08-06 15:11:29.185'),('ce9806c0-e70c-49f3-abf0-9a7fca0a164b','Ritual de Transmutação (Ruivas) - Médio','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',300,545.00,1,'2025-07-29 20:30:47.331','2025-08-06 14:49:26.281'),('d278b9fc-3046-4cba-8ebd-df8a98090b26','Ritual Sonhos Pintados - Médio','Ombré hair colorido + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',360,590.00,1,'2025-07-29 21:03:53.573','2025-08-06 15:07:42.143'),('d3cc77bb-dd45-4f3b-8b1b-0728a94bf599','Colorido Global – Cabelo Longo','','CABELO',360,1000.00,1,'2025-07-29 19:43:35.749','2025-08-06 14:37:32.960'),('d4a828b7-eb3f-4672-90b3-67fae9f2fe2a','Epilação Axila','','EPILACAO',30,30.00,0,'2025-07-29 20:02:40.898','2025-08-08 17:48:48.368'),('d507fa72-9e9e-4820-adb6-b93bea271938','Ritual Vênus Ruiva - Médio','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',300,610.00,1,'2025-07-29 20:25:45.679','2025-08-06 15:16:54.475'),('d5d0a949-b2a4-4f45-82b2-c074d4f4fd14','Ritual Pearl','Limpeza de pele + Drenagem facial','ESTETICA_FACIAL',150,180.00,1,'2025-07-29 21:14:49.673','2025-08-06 15:00:45.344'),('d8f4978f-ee9c-4c83-a487-6f54096cf3cd','Ritual de Transmutação - Longo','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',300,635.00,1,'2025-07-29 20:28:58.215','2025-08-06 14:48:13.248'),('da1d0d41-10b2-4f3c-b092-08317fc4eb4f','Colorido Global – Cabelo Médio','','CABELO',300,800.00,1,'2025-07-29 19:43:05.953','2025-08-06 14:37:40.804'),('dc0ac021-4bac-46af-af04-e2a373b27365','Ritual Sal Negra - Médio','Design de sobrancelha + Detox capilar + finalização modelada','TRATAMENTO',120,185.00,1,'2025-07-29 20:16:16.780','2025-08-06 15:04:45.740'),('dd36efec-bdba-40a2-a887-f81fd7fb8c10',' Epilação Virilha Simples','','EPILACAO',60,45.00,1,'2025-07-29 20:05:25.962','2025-08-06 14:30:12.623'),('ded2b7e0-060d-4d15-a052-2fef38851035','Epilação Peito','','EPILACAO',40,50.00,1,'2025-07-29 20:03:19.739','2025-08-06 14:39:19.697'),('e1376616-8fc6-440e-a885-beab5189cba2','Corte Feminino','Corte de cabelo feminino estilo gótico',NULL,60,80.00,0,'2025-07-25 18:44:24.092','2025-07-25 18:45:01.600'),('e1ae3426-d8f2-4e56-9e2f-48a00541e15c','Ritual Lydia Deetz','Design de sobrancelha + Corte + Finalização modelada','CORTE',120,160.00,1,'2025-07-29 20:08:30.995','2025-08-06 14:56:26.911'),('e1c15403-5c12-4504-bd39-53ffc568972c','Ritual Samara','Axila + Perna completa + Virilha completa','EPILACAO',120,130.00,1,'2025-07-29 21:19:01.871','2025-08-06 15:05:24.118'),('e2aeff4d-3ec6-4a80-ac0f-bf28685aa0ff',' Ombré Colorido – Cabelo Curto','','CABELO',240,450.00,1,'2025-07-29 19:39:53.770','2025-08-06 14:33:09.584'),('e572857e-7149-4798-a210-19d9700282aa','Ritual Vênus Gótica - Extra Longo','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',360,650.00,1,'2025-07-29 20:22:39.290','2025-08-06 15:15:01.227'),('e643bbe8-3d86-43c1-99e7-4c5bb2ba9cdf','Protocolo Tratamento Gordura Localizada (Sessão)','','ESTETICA_CORPORAL',90,110.00,1,'2025-07-29 19:59:42.767','2025-08-06 14:41:27.802'),('e6752b6a-5617-4bf5-aec6-eb3fb6944819',' Loiro – Cabelo Médio','','CABELO',300,700.00,1,'2025-07-29 19:32:10.949','2025-08-06 14:31:49.312'),('e7405e92-22bc-45ef-b97b-a467931f864b','Coloração','Coloração inspirada em tons sombrios','CABELO',180,150.00,0,'2025-07-25 18:44:24.106','2025-07-25 18:44:59.676'),('e898e154-4b7d-49ba-a9fa-6c9b592ba718','Reconstrução – Cabelo Curto','','CABELO',75,170.00,1,'2025-07-29 19:16:32.902','2025-07-29 19:16:32.902'),('e99d5e58-627b-468b-9fa5-69843bb13f92',' Morena Iluminada – Cabelo Longo','','CABELO',300,800.00,1,'2025-07-29 19:35:07.931','2025-08-06 14:33:02.950'),('ea0a2f44-ea87-4d5b-8b6b-e3363666feb6','Epilação Costas','','EPILACAO',40,50.00,1,'2025-07-29 20:03:41.392','2025-08-06 14:39:07.207'),('ea3fc246-b48e-4dab-8824-32990f882257','Ritual Encanto de Sangue de Fada - Longo','Design de sobrancelha + Henna capilar + Tratamento + escova Babyliss/chapinha','COLORACAO',210,335.00,1,'2025-07-29 20:34:19.267','2025-08-06 14:53:08.583'),('ed8092a1-7c03-456e-bad2-ec06d18aabb6','Ritual Sal Negra - Curto','Design de sobrancelha + Detox capilar + finalização modelada','TRATAMENTO',120,170.00,1,'2025-07-29 20:15:56.180','2025-08-06 15:04:16.743'),('edc864ed-597f-453a-8c0e-c92a98eda628','Nutrição – Cabelo Curto','','CABELO',60,110.00,1,'2025-07-29 19:13:10.537','2025-07-29 19:13:10.537'),('ee123aa5-7f3b-4144-8e93-f2a7c725b174','Drenagem Facial ','','ESTETICA_FACIAL',30,45.00,1,'2025-07-29 19:51:16.351','2025-08-06 14:38:41.289'),('ee46373b-98f9-4bea-b27b-dab0d21b2a0e','Ritual Encanto de Sangue de Fada - Médio','Design de sobrancelha + Henna capilar + Tratamento + escova Babyliss/chapinha','COLORACAO',180,300.00,1,'2025-07-29 20:33:55.650','2025-08-06 14:53:16.398'),('eee73b68-2b44-4b7e-869b-9e588c9c3294','Ritual Segredo da Meia-Noite - Longo','Secret Hair + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',360,590.00,1,'2025-07-29 21:01:25.269','2025-08-06 15:06:21.032'),('ef3d6a7b-1f64-4033-9cea-398dcd5c1ffc','Secret Hair – Cabelo Médio','','CABELO',240,450.00,1,'2025-07-29 19:37:55.521','2025-08-06 15:17:25.382'),('efdeeb92-17a4-4baa-ba60-aae818b55028','Ritual Arco-Íris Sombrio - Longo',' Colorido global + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',360,1050.00,1,'2025-07-29 21:06:55.645','2025-08-06 14:45:15.594'),('f1a4f839-732f-4f70-8ccf-37b7eeac8c73',' Epilação Rosto','','EPILACAO',30,40.00,1,'2025-07-29 20:02:14.751','2025-08-06 14:29:58.344'),('f3ade4e0-192d-4484-afa8-1f177df63adc','Ritual Sal Negra - Longo','Design de sobrancelha + Detox capilar + finalização modelada','TRATAMENTO',150,205.00,1,'2025-07-29 20:16:35.305','2025-08-06 15:04:35.679'),('f3e67608-77a5-45e1-83ca-a255eba3c286',' Protocolo Tratamento Cicatriz de Acne (Sessão)','','ESTETICA_FACIAL',90,180.00,1,'2025-07-29 19:59:13.682','2025-08-06 14:33:56.368'),('f6ca1264-a516-4aed-93f8-5dc7997bfe32','Ritual de Transmutação (Ruivas) - Extra Longo','Coloração + Corte + Tratamento + Finalização modelada','COLORACAO',420,720.00,1,'2025-07-29 20:31:40.498','2025-08-06 14:49:11.629'),('f7a93f0c-e795-4249-9513-36c6f40ec6bb','Ritual Toque de Magia Negra - Curto','Design de sobrancelha + Henna capilar + Tratamento + corte + finalização modelada','COLORACAO',180,375.00,1,'2025-07-29 20:36:10.276','2025-08-06 15:09:01.269'),('f84404be-61a5-4b37-8dea-b7e2585027e2','Ritual Poção da Lua Nova - Médio','Design de sobrancelha + detox capilar + corte + finalização modelada','CORTE',150,315.00,1,'2025-07-29 20:19:19.953','2025-08-06 15:02:16.048'),('f87990f1-d75e-491b-a393-439067608851','Barba ','','OUTROS',30,25.00,1,'2025-09-18 17:20:57.163','2025-09-18 17:20:57.163'),('fb3a7a72-8805-462a-b659-3762ee4a719f','Alisamento – Cabelo Curto','','ALISAMENTO',240,350.00,1,'2025-07-29 19:46:01.801','2025-07-29 19:46:01.801'),('fd1d88eb-387c-47bd-9c2d-0a04667bcb45','Ritual Vênus Ruiva - Extra Longo','Design de sobrancelha + Coloração + Tratamento/corte + Escova + babyliss/chapinha','COLORACAO',420,830.00,1,'2025-07-29 20:26:36.283','2025-08-06 15:16:37.425'),('fef92f84-d3f8-4e72-9837-ebfac1f25927','Ritual Arco-Íris Sombrio - Extra Longo',' Colorido global + Tratamento + corte + escova Babyliss/chapinha','DESCOLORACAO',420,1230.00,1,'2025-07-29 21:07:20.605','2025-08-06 14:45:01.364'),('ff4db5c4-b241-4279-a2e1-dfdad4ef03c3','Coloração Ruivo – Cabelo Extra Longo','','CABELO',360,700.00,1,'2025-07-29 19:28:38.000','2025-08-06 14:35:20.286');
/*!40000 ALTER TABLE `procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_usages`
--

DROP TABLE IF EXISTS `product_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_usages` (
  `id` varchar(191) NOT NULL,
  `appointmentId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `quantityUsed` decimal(10,2) NOT NULL,
  `unitCost` decimal(10,2) DEFAULT NULL,
  `totalCost` decimal(10,2) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `product_usages_appointmentId_fkey` (`appointmentId`),
  KEY `product_usages_productId_fkey` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_usages`
--

LOCK TABLES `product_usages` WRITE;
/*!40000 ALTER TABLE `product_usages` DISABLE KEYS */;
INSERT INTO `product_usages` VALUES ('1c222d70-36f3-4de1-8aa7-6f81d5b4247c','73ce9ed2-baeb-4706-8697-e90ccc5effe6','66263d37-5a83-475e-be11-112c42e39f25',75.00,0.80,0.00,'2025-08-05 15:14:52.875'),('3a08de37-3788-4580-9e7c-3359d02e56a6','73ce9ed2-baeb-4706-8697-e90ccc5effe6','28d51afa-c602-4745-8351-619125c152ab',10.00,1.60,0.00,'2025-08-05 17:37:30.135'),('4ce44a99-d1b8-4db5-8232-b6fd96aeb6d3','73ce9ed2-baeb-4706-8697-e90ccc5effe6','bfb776c2-4be9-465f-b528-8754e7ff63b7',50.00,0.12,0.00,'2025-08-05 17:35:41.164'),('81b44c3b-4e45-4a51-9b01-0e04a07fc8b0','73ce9ed2-baeb-4706-8697-e90ccc5effe6','cd96d76c-666d-4d10-9ae7-55783f1940ff',5.00,2.19,0.00,'2025-08-05 17:40:01.916'),('88801d92-b33f-4e7c-b130-98aad4db9f33','73ce9ed2-baeb-4706-8697-e90ccc5effe6','4b4e2672-1366-4fc9-9f17-dd0c83e63c70',10.00,1.03,0.00,'2025-08-05 17:37:30.054'),('8a8d9e41-0984-4930-a119-b82abc51fcee','73ce9ed2-baeb-4706-8697-e90ccc5effe6','488b778a-1b69-4a3d-bfbe-cf8ef692f455',40.00,0.31,0.00,'2025-08-05 17:37:30.238'),('aceb1ce7-ed0a-4dbe-bf01-6cabe5a0c487','73ce9ed2-baeb-4706-8697-e90ccc5effe6','9911536d-aaca-4ff2-9627-1085b501c59e',1.00,4.48,0.00,'2025-08-05 17:40:01.991'),('edb49309-c951-4530-b129-61027a5e0786','73ce9ed2-baeb-4706-8697-e90ccc5effe6','a78d96b3-fa4b-4ca0-b067-c6d657d789c7',150.00,0.12,0.00,'2025-08-05 17:35:41.078'),('f24bb34e-9ffb-455d-ace8-f45e44af1fcd','73ce9ed2-baeb-4706-8697-e90ccc5effe6','db56f67e-ebd9-4cf5-b704-838678b719f0',75.00,0.11,0.00,'2025-08-05 15:34:49.609');
/*!40000 ALTER TABLE `product_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('USO_INTERNO','VENDA_DIRETA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `minStock` int NOT NULL DEFAULT '0',
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unitQuantity` decimal(10,2) DEFAULT NULL,
  `unitMeasurement` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addToCost` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('00919440-989a-4561-850d-e71ff46fbb3b','Óleo semente de Uva',NULL,NULL,'USO_INTERNO',39.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 18:04:06.534','2025-07-29 18:33:11.437'),('03628740-f857-4467-a723-32f93d60d6ad','Bio-Hidrat Cleanser Sabonete Facial Ultra-Hidratante',NULL,NULL,'USO_INTERNO',63.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:42:41.787','2025-07-29 18:23:59.979'),('03c72e3c-5b83-4d5e-979c-11836cab13eb','K-Pak Deep Penetrating Reconstructor',NULL,NULL,'USO_INTERNO',833.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:11:32.860','2025-07-29 18:29:30.391'),('070ca476-d77d-4dd0-a9ab-9dcd6c03a06c','Bio-Hidrat Toner Tônico Facial Ultra-Hidratante',NULL,NULL,'USO_INTERNO',63.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:44:32.803','2025-07-29 18:24:14.336'),('096cefde-1aa2-40d7-9e3a-0b716c2716b8','Bio.Clean System PRO Loção Tônica Suavizante',NULL,NULL,'USO_INTERNO',113.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:28:27.461','2025-07-29 18:25:09.694'),('0a267076-4101-4c61-ba4f-b5dfb526bbcc','Lumishine 4.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:09:14.285','2025-07-29 18:09:14.285'),('0c253446-269b-4c31-a294-ee266e95c101','Máscara Mel Capilar',NULL,NULL,'VENDA_DIRETA',80.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:31:51.858','2025-07-29 17:31:51.858'),('0e10acc8-d827-4922-8ad9-8d3a2795f732','Bio.Collagen Intensive Sérum Facial Antirrugas de Colágeno Vegetal',NULL,NULL,'USO_INTERNO',116.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:39:51.904','2025-07-29 18:25:55.475'),('0eb87ad1-5316-4fc1-aabf-fea18f2589c9','Óleo Capilar Gothic',NULL,NULL,'VENDA_DIRETA',35.00,15,3,'unidade',NULL,NULL,0,0,'2025-07-25 18:44:24.130','2025-07-25 18:45:13.924'),('0f485eb4-a18e-4b55-b57f-3efc276a8c17','Máscara Pigmentante Ovelha Negra',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:58:31.997','2025-07-29 17:58:31.997'),('1469aace-6815-4c95-8e1e-b0ed9d657816','Lumishine 6.07',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:17:28.645','2025-07-29 18:17:28.645'),('155af1ce-6d3f-47c9-b750-c3d7a964a0ba','Máscara Pigmentante - Cachorro Caramelo',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 18:00:00.429','2025-07-29 18:00:00.429'),('1642dcb9-1300-4e04-8b05-a2da5962fa1e','FINALIZADOR DE ONDAS E CACHOS VOLUME UP',NULL,NULL,'VENDA_DIRETA',145.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:30:06.626','2025-07-29 18:28:14.035'),('164631c8-d307-48a5-b60c-95ee3ff7efc9','Fios de Seda Energy Skin Manta',NULL,NULL,'USO_INTERNO',213.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:41:30.737','2025-07-29 18:28:38.241'),('18b3e7a2-65ae-4290-b863-bf5312d20c63','Máscara Pigmentante Pônei',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:50:16.781','2025-07-29 17:50:16.781'),('18d99334-e86c-48e4-aee5-1b7f875de0cb','K-Pak Therapy Shampoo',NULL,NULL,'USO_INTERNO',303.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:27:13.984','2025-07-29 18:30:03.334'),('1c103883-cd7b-4b69-87cf-f14c693784b1','Folha de algodão',NULL,NULL,'USO_INTERNO',16.00,2,1,'un',NULL,NULL,0,1,'2025-07-28 18:00:14.928','2025-07-29 18:28:49.651'),('1c215d26-1082-40e1-90ce-2225c8dc9e2d','Máscara Pigmentante Carpa',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:48:42.636','2025-07-29 17:48:42.636'),('1f091896-2417-420f-94de-3053484ba46a','Protetor Solar Facial Calmante e Antioxidante FPS 65',NULL,NULL,'VENDA_DIRETA',120.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:10:47.869','2025-07-29 17:10:47.869'),('1fc7bfdf-7104-477c-9d59-9988fff39c95','Máscara Pigmentante Azulão',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:54:02.184','2025-07-29 17:54:02.184'),('202d5f5e-580a-436b-a17c-e4c1fbe28331','Fios de Seda Energy Cream',NULL,NULL,'USO_INTERNO',185.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:42:10.245','2025-07-29 18:28:29.584'),('20e9f766-69d2-46a2-b5b4-6d522b9f1916','Lumishine 6.8',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:19:23.456','2025-07-29 18:19:23.456'),('263f036b-6a9b-4171-9b99-9eda69896338','Bio.Clean System PRO Gel Esfoliante 3 em 1',NULL,NULL,'USO_INTERNO',138.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:27:07.680','2025-07-29 18:24:58.807'),('26aeb4dc-dbcb-4f6c-a6ab-e2b4f2c95859','Máscara Pigmentante Flamingo',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:37:27.450','2025-07-29 17:37:27.450'),('277f2382-c421-4778-b23a-f06ee7efaf02','Lumishine XL0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:20:34.403','2025-07-29 18:20:34.403'),('28d51afa-c602-4745-8351-619125c152ab','Defy Damage Pro Series 2','reconstrução pós química',NULL,'USO_INTERNO',801.00,2,1,'ml',500.00,'ml',0,1,'2025-07-28 19:14:26.102','2025-08-05 15:57:10.661'),('29c26a3f-6560-435d-916f-363b5c434a38','Máscara Pigmentante Lobo Guará',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:39:11.822','2025-07-29 17:39:11.822'),('2bc96b5a-aa3f-4e9a-b115-521c5e057a8a','Touca TNT',NULL,NULL,'USO_INTERNO',10.90,2,1,'un',NULL,NULL,0,1,'2025-07-28 18:41:48.496','2025-07-29 18:34:22.566'),('2d8c24ab-80da-46bf-8585-865386bccbf1','Protetor Solar Facial Calmante e Antioxidante FPS 65',NULL,NULL,'VENDA_DIRETA',130.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:12:28.662','2025-07-29 17:12:28.662'),('2f5e78c1-558f-4c55-a599-5ae8d303a6ed','K-Pak Cuticle Sealer - PH Neutralizer',NULL,NULL,'USO_INTERNO',406.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:10:46.419','2025-07-29 18:29:24.118'),('31e28841-6b4e-485d-97f5-1bfb14797dca','Máscara Pigmentante Betta',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:58:09.054','2025-07-29 17:58:09.054'),('3226420b-ea8a-4ebb-9d22-aa98aecbecac','Lumishine 9.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:10:21.158','2025-07-29 18:10:21.158'),('324b6f6d-14ca-468b-931d-7c069f36b934','Máscara Pigmentante Saírazul',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:52:59.164','2025-07-29 17:52:59.164'),('32677f6f-34cc-4d5b-8f51-8513410cda80','New Ox 20v',NULL,NULL,'USO_INTERNO',61.46,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:48:26.706','2025-07-29 18:32:47.684'),('32d34e60-07ba-42fd-b26b-72a0c94275bc','Ox 20v',NULL,NULL,'USO_INTERNO',101.50,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:06:07.541','2025-07-29 18:33:21.770'),('339cbd25-cb2f-4c87-b818-15974bbbb2d3','Lumishine 10.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:10:43.933','2025-07-29 18:10:43.933'),('34c37c20-5a94-4739-b1fe-c485eee0e9ad','Mindful Origin Shampoo',NULL,NULL,'USO_INTERNO',284.73,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:35:24.613','2025-07-29 18:32:25.362'),('378bc888-f773-4875-b12b-fa180cf00e41','Lumishine 7.07',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:17:50.161','2025-07-29 18:17:50.161'),('39d75c75-98d8-405f-bec8-99b98ac6ebfc','Ox 40v',NULL,NULL,'USO_INTERNO',101.50,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:07:40.082','2025-07-29 18:33:31.923'),('3a607194-41d4-4640-ba96-f26c854f32e2','Blonde Life Brightening Veil',NULL,NULL,'USO_INTERNO',198.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:18:47.332','2025-07-29 18:26:22.611'),('3c143f33-213f-4c39-aa66-55c5365c256b','K-Pak Intense Hydrator',NULL,NULL,'USO_INTERNO',794.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:12:00.382','2025-07-29 18:29:35.782'),('3d39cc2d-cc85-4928-988b-604cbaac0188','Blonde Life Brightening Sh.',NULL,NULL,'USO_INTERNO',319.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:15:58.637','2025-07-29 18:26:16.215'),('3d6a2be8-126e-4e9f-a93b-f3c3f4c62c19','Máscara Pigmentante Pavão',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:57:46.356','2025-07-29 17:57:46.356'),('3dc63b3d-f16d-4bfe-8748-776db2bcb3ee','Máscara Pigmentante Medusa',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:49:19.407','2025-07-29 17:49:19.407'),('3e8818fb-3ac6-4deb-8a3a-d5b17d51f543','Lumishine 7.02',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:11:35.039','2025-07-29 18:11:35.039'),('44e9419d-2b0e-43f4-a6bb-52258f6828f6','Lumishine 9.07',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:18:09.703','2025-07-29 18:18:09.703'),('461e59fa-01ae-47fd-8044-54be9788aa0f','Bio-Acne Solution Acne Color Control',NULL,NULL,'USO_INTERNO',118.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:31:48.366','2025-07-29 18:22:24.854'),('46f33442-4015-4600-b5eb-ed24d4f74817','Lumishine XL7',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:20:08.946','2025-07-29 18:20:08.946'),('4838f1ca-9f47-48d3-ba2b-9ff78479c819','Lumishine 7.04',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:15:30.886','2025-07-29 18:15:30.886'),('488b778a-1b69-4a3d-bfbe-cf8ef692f455','K-Pak Shampoo','shampoo uso diário',NULL,'USO_INTERNO',305.00,2,1,'ml',1000.00,'ml',0,1,'2025-07-28 19:30:45.147','2025-08-05 15:55:32.984'),('48b9c5c5-dba8-4fe7-be67-ffa6e06906b7','Protetor Solar Facial Antienvelhecimento FPS60',NULL,NULL,'USO_INTERNO',90.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:00:49.607','2025-07-29 18:33:47.729'),('4a35d0cf-a5de-423b-9048-f6c608577e55','Kit Mel Capilar - Máscara, Shampoo e Condicionador - NUTRIÇÃO',NULL,NULL,'VENDA_DIRETA',235.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:32:27.940','2025-07-29 17:32:27.940'),('4a3c1150-6d7a-4ffc-a649-3854441bc6ba','Máscara Pigmentante Boto Rosa',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:37:54.670','2025-07-29 17:37:54.670'),('4ac047ca-71d6-45b3-8a4e-0293b4015d45','Brightening Oil',NULL,NULL,'USO_INTERNO',282.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:24:06.474','2025-07-29 18:26:29.612'),('4b2cfd9a-d190-41ce-a88e-8124020356bd','Detoxifying Scalp Mud',NULL,NULL,'USO_INTERNO',396.04,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:37:22.412','2025-07-29 18:27:44.109'),('4b4e2672-1366-4fc9-9f17-dd0c83e63c70','Moisture Rec. Treat. Balm','hidratação intensa',NULL,'USO_INTERNO',516.50,2,1,'ml',500.00,'ml',0,1,'2025-07-28 19:26:14.131','2025-08-05 15:56:24.992'),('4b9b4fdd-7302-43cc-a7b4-8d495dcae381','Bio-Acne Solution Cleanser - 300ml',NULL,NULL,'USO_INTERNO',140.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:34:54.939','2025-07-29 18:22:57.768'),('4de30dfd-b026-4782-876b-e7dd962ae9e2','Jelly Mask',NULL,NULL,'USO_INTERNO',360.40,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:38:14.289','2025-07-29 18:29:02.336'),('4fba6800-e551-43ed-bcca-61c4cf1f08d4','Bio.Clean System PRO Trietanolamina Concentrada',NULL,NULL,'USO_INTERNO',85.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:24:49.067','2025-07-29 18:25:42.969'),('50cbf0ef-9d06-4f19-b32f-0c4f4a9f79a0','Vino-Therapy Creme De Massagem',NULL,NULL,'USO_INTERNO',150.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:55:09.000','2025-07-29 18:34:28.479'),('53598e59-586d-4169-a173-9b1dde36cb22','Luster Lock Multi Perf. Spray',NULL,NULL,'USO_INTERNO',269.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:28:53.277','2025-07-29 18:31:42.264'),('5464a3e6-7b4f-48b4-b921-7f052658cf7a','Solid Pomade',NULL,NULL,'USO_INTERNO',160.73,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:40:37.459','2025-07-29 18:34:09.374'),('57307bd5-90cf-42d3-a43b-8fe966fdad71','New Ox 40v',NULL,NULL,'USO_INTERNO',61.46,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:49:35.388','2025-07-29 18:33:02.979'),('5a25c93c-da6c-4a32-805a-c662235beb2b','Cera Roll-on',NULL,NULL,'USO_INTERNO',8.50,10,4,'un',NULL,NULL,0,1,'2025-07-28 18:38:55.115','2025-07-29 18:26:55.293'),('5c3f1edf-5417-4ef7-a026-c35f0a387c07','Lumishine 4.22',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:12:40.553','2025-07-29 18:12:40.553'),('5ce0c86d-7d7a-40cd-88be-fa32d02e0837','Máscara Pigmentante Urso Pardo',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:39:50.433','2025-07-29 17:39:50.433'),('5d26931d-6d5e-43c2-98ef-5eaafb9387a0','Joifull Volumizing Styler',NULL,NULL,'USO_INTERNO',246.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:32:05.244','2025-07-29 18:29:10.547'),('5e5dfb96-b18b-43a1-8a86-5a9c6c27f8f0','Bio.Clean System PRO Solução Pós-Extração',NULL,NULL,'USO_INTERNO',133.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:24:15.743','2025-07-29 18:25:31.210'),('5f0b7ce3-e7f5-461c-be8b-a0f45f980e2b','Máscara Pigmentante Louva Deus',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:56:57.600','2025-07-29 17:56:57.600'),('5f74e162-29a1-47d6-a8cc-04647b9410ef','Escova Sobrancelha',NULL,NULL,'USO_INTERNO',10.00,2,1,'un',NULL,NULL,0,1,'2025-07-28 18:05:24.669','2025-07-29 18:28:07.231'),('5fb76a20-4bf9-4562-b2e7-57b4480a66de','Condicionador Mel Capilar',NULL,NULL,'VENDA_DIRETA',92.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:31:21.834','2025-07-29 18:27:12.563'),('5fed4a3d-a50a-4dc9-a936-1116340b7369','Amplify Mousse',NULL,NULL,'USO_INTERNO',81.44,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:43:39.879','2025-07-29 18:21:24.904'),('616be95b-fba2-41e0-bf37-77ed8e54fe9d','Blonde Life Brightening COND',NULL,NULL,'USO_INTERNO',335.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:16:22.692','2025-07-29 18:26:02.921'),('627d90e3-6dd4-47f1-9fb5-c5eb5e7b99c7','MAGIC REPAIR Finalizador 10 x 1 Multifuncional',NULL,NULL,'VENDA_DIRETA',55.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:33:09.704','2025-07-29 17:33:09.704'),('656ae09e-4a3d-43cf-9783-365184a1324f','Lumishine 7.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:09:59.304','2025-07-29 18:09:59.304'),('66263d37-5a83-475e-be11-112c42e39f25','Lumishine 6.44','coloração',NULL,'USO_INTERNO',60.00,3,1,'g',75.00,'g',0,1,'2025-08-05 15:10:08.661','2025-08-05 15:10:08.661'),('66506cd7-20f4-4abc-9426-4a2085cfc5f0','Lipo Redux Peeling Enzimático Corporal 3 Em 1 Cafeína 24h',NULL,NULL,'USO_INTERNO',149.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:50:25.575','2025-07-29 18:31:21.476'),('66c5fc9e-354d-418a-9a76-11dbbcff3000','Bio.Clean System PRO Máscara Ultrassuavizante',NULL,NULL,'USO_INTERNO',136.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:25:27.598','2025-07-29 18:25:21.496'),('6856507f-7c65-4f10-a823-0e577850fb8b','Cera Facial',NULL,NULL,'USO_INTERNO',10.00,2,1,'un',NULL,NULL,0,1,'2025-07-28 18:28:59.837','2025-07-29 18:26:42.048'),('6a70b897-2a5c-4553-8094-b55065dcec4a','Teste',NULL,NULL,'USO_INTERNO',200.00,1000,300,'ml',NULL,NULL,0,0,'2025-07-26 22:37:25.027','2025-07-27 15:04:24.508'),('6e8e0bad-6212-430d-888b-baea639a890f','Lipo Redux Fluido Potencializador Firmestril',NULL,NULL,'USO_INTERNO',168.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:57:00.960','2025-07-29 18:31:16.343'),('6f62df00-1173-4d05-9ae1-adc03722e917','Lumishine 7.03',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:14:29.493','2025-07-29 18:14:29.493'),('6f795a2a-54aa-4e21-9b4f-efca11468246','Máscara Pigmentante Lobo Guará',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:52:23.720','2025-07-29 17:52:23.720'),('727a3354-70e3-41ca-bc88-22e5abb25591','Protetor Solar Antioleosidade Fps 30',NULL,NULL,'VENDA_DIRETA',130.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:14:38.398','2025-07-29 17:14:38.398'),('75b66580-5d6b-4389-ada0-537f1db42ebc','Máscara Capilar Dark',NULL,NULL,'VENDA_DIRETA',45.00,20,5,'unidade',NULL,NULL,0,0,'2025-07-25 18:44:24.127','2025-07-25 18:45:11.992'),('7acfcea2-d8b0-4c39-9809-f1c6d7d285fa','Blonde Life Brightening MASQUE',NULL,NULL,'USO_INTERNO',180.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:17:58.199','2025-07-29 18:26:09.417'),('7adb83ef-fb6e-47ae-a4e3-84442d373ae3','Máscara Pigmentante Vagalume',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:59:37.482','2025-07-29 17:59:37.482'),('7f27ea72-e7e0-4962-b1a7-aaf68d359a24','Lumishine 5.07',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:17:05.663','2025-07-29 18:17:05.663'),('81f203e4-0c61-4c40-8869-afb2c42b070a','FINALIZADOR DE ONDAS E CACHOS VOLUME UP',NULL,NULL,'USO_INTERNO',72.71,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:29:32.434','2025-07-29 18:28:23.275'),('827c851e-f486-4445-9bb3-109bb41f99fc','Protetor Solar FPS 70 Antiacne Incolor',NULL,NULL,'USO_INTERNO',90.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:34:00.128','2025-07-29 18:33:55.020'),('8326b867-926b-46b9-a44a-a97abcb5d089','Máscara Pigmentante Beija Flor',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:59:17.313','2025-07-29 17:59:17.313'),('8406594c-b53a-4a51-b60d-f3f2896e45c0','Máscara Pigmentante Urso Polar',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:56:17.556','2025-07-29 17:56:17.556'),('84d10a50-0df5-4df0-82bd-5f073cebed1b','Bio-Sunprotect Gel-Creme Toque Seco Ultracalmante FPS 65',NULL,NULL,'USO_INTERNO',168.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:00:03.796','2025-07-29 18:24:35.152'),('85aa55b5-6834-4b80-ac2b-d2f325149b31','Bio Essential Oil Facial',NULL,NULL,'USO_INTERNO',97.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:40:31.486','2025-07-29 18:22:07.679'),('87aea467-1a51-48c9-907c-2518eed2acdf','Lumishine 10.8',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:19:43.010','2025-07-29 18:19:43.010'),('8cccfbfa-785b-49af-b258-0b9e1d92084f','K-Pak Professional - HKP',NULL,NULL,'USO_INTERNO',182.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:13:01.393','2025-07-29 18:29:41.264'),('8cf1d8a8-5151-4bfe-a13e-66cc21cd0327','Working Hairspray',NULL,NULL,'USO_INTERNO',98.58,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:44:59.832','2025-07-29 18:34:40.362'),('8d3bbd8c-d31c-467b-a136-bfa07af2abd9','Máscara Pigmentante Kamaleão Color - Raposinha',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:36:59.089','2025-07-29 17:36:59.089'),('8db4cfb3-b2de-4a7a-b163-1b018a161221','Protetor Solar FPS 70 Antiacne Incolor',NULL,NULL,'VENDA_DIRETA',130.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:13:03.901','2025-07-29 17:13:03.901'),('8fb7241b-5796-433e-9b64-5c7387838eb3','Máscara Pigmentante Rouxinol',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:55:17.804','2025-07-29 17:55:17.804'),('90028402-f5d2-4629-84c6-f5bb3fd89150','Lumishine 10.07',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:18:49.451','2025-07-29 18:18:49.451'),('90ae8899-9917-4a43-a129-73bf323e212b','Airy Texture Spray',NULL,NULL,'USO_INTERNO',116.89,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:45:51.312','2025-07-29 18:21:15.887'),('90e3d497-e3d5-4715-b37c-2cca90ca76dc','Máscara Descartável',NULL,NULL,'USO_INTERNO',19.90,2,1,'un',NULL,NULL,0,1,'2025-07-28 18:43:09.861','2025-07-29 18:31:58.640'),('91205565-9190-4d2d-8436-8523cb87d20e','Strong Hold Hairspray',NULL,NULL,'USO_INTERNO',98.58,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:42:26.029','2025-07-29 18:34:17.364'),('92b857a1-252d-4604-b1be-65eb3f09fd78','Lumishine',NULL,NULL,'USO_INTERNO',51.00,3,2,'kg',NULL,NULL,0,0,'2025-07-28 19:02:24.500','2025-07-28 19:04:33.863'),('9331191a-6fad-4f7c-896d-1ac201bd75a2','Banho de Brilho Capivara',NULL,NULL,'USO_INTERNO',120.00,2,1,'L',NULL,NULL,0,1,'2025-07-29 18:02:01.004','2025-07-29 18:02:01.004'),('95231223-9885-4dd5-8024-06c2775453a4','New Ox 30v',NULL,NULL,'USO_INTERNO',61.46,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:49:01.539','2025-07-29 18:32:55.656'),('97c943c1-238c-4ffd-90e6-7cd971557690','Protetor Solar para o rosto com Vitamina C',NULL,NULL,'VENDA_DIRETA',130.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:13:26.095','2025-07-29 17:13:26.095'),('9911536d-aaca-4ff2-9627-1085b501c59e','Luster Lock Glossing Oil',NULL,NULL,'USO_INTERNO',269.00,2,1,'ml',60.00,'ml',0,1,'2025-07-28 19:30:21.804','2025-08-05 17:38:47.886'),('99b7568f-3e8d-482f-aa17-7b61af234ae9','Lipo Redux Essential Creme de Massagem Redutor e Anticelulite',NULL,NULL,'USO_INTERNO',83.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:52:28.738','2025-07-29 18:31:09.582'),('9c1826ee-95e5-4b0b-83c0-85e602ea9b97','Máscara Pigmentante Arara Azul',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:56:38.247','2025-07-29 17:56:38.247'),('9cfa9ad7-ead7-4299-8090-5804b69c4ba2','Lâmina',NULL,NULL,'USO_INTERNO',5.00,10,2,'un',NULL,NULL,0,1,'2025-07-28 18:06:32.559','2025-07-29 18:30:24.022'),('9dd4d991-ee68-4adf-9759-165056fd9604','Cera',NULL,NULL,'USO_INTERNO',50.00,2,1,'g',NULL,NULL,0,1,'2025-07-28 18:27:38.499','2025-07-29 18:26:35.853'),('9dd86860-5ab8-4f5d-a6f7-af73bd8a727b','RESTAURADOR DE ONDAS E CACHOS - MAGIC CURLY',NULL,NULL,'USO_INTERNO',51.15,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:28:23.732','2025-07-29 18:34:01.143'),('a1932417-d8f0-4f69-8931-a3b263ac53f3','Lumishine 6.05',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:15:48.815','2025-07-29 18:15:48.815'),('a1c4db4b-7b7c-4614-acf8-d6cd6e9a1b67','Defy Damage Pro Series 1',NULL,NULL,'USO_INTERNO',801.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:13:48.772','2025-07-29 18:27:20.997'),('a20f129e-872f-435d-af1d-3e5edf24dcf0','White Blond',NULL,NULL,'USO_INTERNO',239.56,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:47:18.689','2025-07-29 18:34:34.518'),('a253faf8-aa84-467c-b237-33a4d8cc6abb','Shampoo Hidratante',NULL,NULL,'USO_INTERNO',NULL,500,100,'ml',NULL,NULL,0,0,'2025-07-25 18:44:24.118','2025-07-25 18:45:16.014'),('a34eaca8-6352-4642-941b-07265c53ad9c','Bio-Acne Solution Acne Mask - 90g',NULL,NULL,'USO_INTERNO',161.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:32:50.231','2025-07-29 18:22:51.637'),('a565798d-1c7a-4247-8e74-23faad58e500','RESTAURADOR DE ONDAS E CACHOS - MAGIC CURLY',NULL,NULL,'VENDA_DIRETA',100.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:28:57.159','2025-07-29 17:28:57.159'),('a5fc8b6e-e6f7-42f4-83dd-20a400a97668','Máscara Pigmentante Polvo',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:55:49.450','2025-07-29 17:55:49.450'),('a78d96b3-fa4b-4ca0-b067-c6d657d789c7','Banho de Brilho Kamaleão Color - Raposinha',NULL,NULL,'USO_INTERNO',120.00,2,1,'ml',1000.00,'ml',0,1,'2025-07-29 18:01:12.539','2025-08-05 15:59:19.671'),('acb97532-58d6-4fc2-afa4-e7fedcd98a80','Lumishine 8.03',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:14:50.829','2025-07-29 18:14:50.829'),('adbe6e38-58ee-47f5-b35b-c969ae8454bd','Máscara Pigmentante Iguana',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:58:55.613','2025-07-29 17:58:55.613'),('aeb96b5f-0991-4bf2-b971-5ac04cbfc1ed','Máscara Pigmentante Pica pau',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:38:18.548','2025-07-29 17:38:18.548'),('b0241e19-a3ff-41dd-a340-a7ee41f54ae7','Lipo Redux Essential Creme de Massagem Firmador e Antiestrias',NULL,NULL,'USO_INTERNO',83.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:53:48.559','2025-07-29 18:31:03.897'),('b10bd4f9-3fb8-40ce-9869-3edb0ca89f07','Moisture Recovery Shampoo',NULL,NULL,'USO_INTERNO',355.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:24:48.397','2025-07-29 18:32:42.779'),('b19d3b3f-7c85-44cf-9dda-df3ce646f29e','Bio-Acne Solution Toner',NULL,NULL,'USO_INTERNO',129.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:36:41.778','2025-07-29 18:23:50.869'),('b34828a5-28ed-4c3b-93fe-006c8348f7b9','Banho de Brilho Carpa',NULL,NULL,'USO_INTERNO',120.00,2,1,'L',NULL,NULL,0,1,'2025-07-29 18:02:19.457','2025-07-29 18:02:19.457'),('b544a1e7-709f-44d7-8565-907dd463ead5','K-Pak Tretatment Shampoo Clarifying','shampoo reconstrução',NULL,'USO_INTERNO',353.50,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:09:57.805','2025-07-29 18:30:08.020'),('b63530da-1b01-4768-80f7-76d65f94cab5','Fios de Seda Energy Solution',NULL,NULL,'USO_INTERNO',146.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:43:53.907','2025-07-29 18:28:44.074'),('b68198c3-98f9-4e73-ae3b-5613a3d06756','Lumishine 5.66',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:16:39.679','2025-07-29 18:16:39.679'),('b76c2d75-9a48-4167-b000-8be8cd533b29','Lumishine 5.02',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:11:11.615','2025-07-29 18:11:11.615'),('b87f7b51-2b8b-4c94-b972-a7034e39d06f','Bio-Sunprotect Gel-Creme Antienvelhecimento FPS60',NULL,NULL,'VENDA_DIRETA',130.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 17:14:07.022','2025-07-29 17:14:07.022'),('bb6adbf4-48bd-41b8-8547-fdff0dbac8fe','K-PAK Therapy Luster Lock',NULL,NULL,'USO_INTERNO',438.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:28:08.431','2025-07-29 18:29:57.271'),('be77e062-cadd-4f05-8175-ba28f752a4bf','Balancing Potion',NULL,NULL,'USO_INTERNO',206.53,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:39:55.058','2025-07-29 18:21:42.688'),('bec0a61f-8460-4a38-81e5-bd29b4425eb3','K-Pak Therapy Conditioner',NULL,NULL,'USO_INTERNO',310.00,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:27:39.462','2025-07-29 18:29:51.818'),('bfb776c2-4be9-465f-b528-8754e7ff63b7','Banho de Brilho Flamingo',NULL,NULL,'USO_INTERNO',120.00,2,1,'ml',1000.00,'ml',0,1,'2025-07-29 18:01:38.277','2025-08-05 15:59:43.598'),('c152b433-c45c-4e04-b478-94cfa6e34e5a','Ox 10v',NULL,NULL,'USO_INTERNO',101.50,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:05:29.450','2025-07-29 18:33:16.042'),('c30831ef-fc72-4b12-8dea-c00aa6b89cfb','Lumishine 9.02',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:11:58.591','2025-07-29 18:11:58.591'),('c80c8a22-aefc-4659-9302-2924bafcf58b','Luva',NULL,NULL,'USO_INTERNO',21.00,2,1,'un',NULL,NULL,0,1,'2025-07-28 17:58:04.754','2025-07-29 18:31:48.359'),('c98049c6-9aeb-432a-a255-bc1e04de549a','Máscara Pigmentante Corujinha',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:49:49.459','2025-07-29 17:49:49.459'),('cb42245c-eee1-491f-afbb-f85093efc9e6','Lumishine 4.03',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:13:03.569','2025-07-29 18:13:03.569'),('cc1ebc00-f744-428d-a7b1-581d003378b9','Lumishine 1.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:08:36.884','2025-07-29 18:08:36.884'),('cd96d76c-666d-4d10-9ae7-55783f1940ff','DEFY DAMAGE PROT. SHIELD',NULL,NULL,'USO_INTERNO',219.00,2,1,'ml',100.00,'ml',0,1,'2025-07-28 19:15:12.810','2025-08-05 17:38:21.166'),('ce220a7a-8576-4172-9e72-2ada32633cf5','Henna Himalaya',NULL,NULL,'USO_INTERNO',110.60,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:53:34.425','2025-07-29 18:28:56.084'),('ce34dbea-7506-4ca6-a0c1-d106b577b1c1','Máscara Pigmentante Capivara',NULL,NULL,'USO_INTERNO',104.00,300,150,'ml',NULL,NULL,0,1,'2025-07-29 17:38:46.843','2025-07-29 17:38:46.843'),('d3407d00-8d79-4649-8faf-00651f9bf077','Banho de Brilho Corujinha',NULL,NULL,'USO_INTERNO',120.00,2,1,'L',NULL,NULL,0,1,'2025-07-29 18:02:41.035','2025-07-29 18:02:41.035'),('d3d9bda5-77c8-4a5d-b87f-0dad6f2679f1','Condicionador Reparador',NULL,NULL,'USO_INTERNO',NULL,500,100,'ml',NULL,NULL,0,0,'2025-07-25 18:44:24.124','2025-07-25 18:45:10.174'),('d509fe1f-0355-4777-a65b-afcc33298f50','Lipo Redux Creme para Drenagem Linfática Powerslim',NULL,NULL,'USO_INTERNO',147.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:51:26.202','2025-07-29 18:30:52.894'),('d62fd3a9-d6f9-4989-b275-7d5163159121','Shampoo Mel Capilar',NULL,NULL,'VENDA_DIRETA',88.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:30:58.631','2025-07-29 17:30:58.631'),('d84a981c-5632-4224-9a40-cbe8700499f6','Máscara Pigmentante Viúva Negra',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:53:21.287','2025-07-29 17:53:21.287'),('d8a808aa-b63c-4f86-b54f-74e5e12e7572','Bio-Acne Solution Acne Color Control',NULL,NULL,'USO_INTERNO',118.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:31:13.001','2025-07-29 18:22:41.149'),('db56f67e-ebd9-4cf5-b704-838678b719f0','Ox 30v',NULL,NULL,'USO_INTERNO',101.50,2,1,'ml',946.00,'ml',0,1,'2025-07-28 19:07:03.472','2025-08-05 15:33:47.022'),('decb99a9-2076-40b7-8d46-68edbbce250d','Moisture Recovery Conditioner',NULL,NULL,'USO_INTERNO',386.50,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:25:37.107','2025-07-29 18:32:37.276'),('e140cfbb-a69b-4605-8770-f772892120a0','Teste',NULL,NULL,'USO_INTERNO',200.00,10,2,'L',NULL,NULL,0,0,'2025-07-29 23:41:53.252','2025-07-29 23:42:40.722'),('e3ddc7f3-5856-48ff-aa90-eddf761653ed','K-Pak Conditioner',NULL,NULL,'USO_INTERNO',315.50,2,1,'ml',NULL,NULL,0,1,'2025-07-28 19:31:19.458','2025-07-29 18:29:17.773'),('e4096a47-95b3-40a0-9251-f35ccabca1d8','Bio-Acne Solution Peeling Vegetal - 90g',NULL,NULL,'USO_INTERNO',139.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:30:40.491','2025-07-29 18:23:06.997'),('e4ac8bc1-7141-4105-9166-9d6c7ea9fadf','Máscara Pigmentante Jubarte',NULL,NULL,'USO_INTERNO',104.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 17:47:17.306','2025-07-29 17:47:17.306'),('e69e16c5-78ce-4c76-9738-980c200e5244','Lumishine 3.66',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:16:14.093','2025-07-29 18:16:14.093'),('e6e46b66-3603-4a07-a0f6-9e6f776aee1f','Adstringente',NULL,NULL,'USO_INTERNO',34.00,2,1,'ml',500.00,'ml',0,1,'2025-07-28 18:02:21.429','2025-08-06 15:21:26.065'),('e830c810-6809-442d-8bbc-9494fc2a7f44','Máscara Pigmentante Pantera',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:54:50.177','2025-07-29 17:54:50.177'),('ef8f1e0a-6d6b-426f-b4eb-83440222ca3d','Bio-Acne Solution Serum Secativo',NULL,NULL,'USO_INTERNO',110.00,2,1,'ml',NULL,NULL,0,1,'2025-07-29 16:35:32.983','2025-07-29 18:23:18.505'),('f16c82b1-303f-4247-8904-8080356f2c3b','Lumishine 1.22',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:12:25.940','2025-07-29 18:12:25.940'),('f1e27a61-a94a-45d6-b4b1-a138b2c902ac','Bio.Clean System PRO Creme Emoliente - 100g',NULL,NULL,'USO_INTERNO',96.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:29:09.346','2025-07-29 18:24:48.269'),('f338e40d-8317-4867-baae-f4727e20e0e7','Lumishine 5.0',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:09:35.557','2025-07-29 18:09:35.557'),('f51d6169-32d9-473e-b210-0c093f51c0b3','Máscara Pigmentante Melro Violet',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:51:54.891','2025-07-29 17:51:54.891'),('f8d1af7e-6829-400b-8a7e-38b69eebf0bb','Lumishine 6.03',NULL,NULL,'USO_INTERNO',56.00,3,1,'g',NULL,NULL,0,1,'2025-07-29 18:14:09.636','2025-07-29 18:14:09.636'),('f9b4f53c-9a4e-458e-8770-b73cdcd979d5','Bio-Hidrat Creme Hidratante Facial',NULL,NULL,'USO_INTERNO',69.00,2,1,'g',NULL,NULL,0,1,'2025-07-29 16:45:27.520','2025-07-29 18:24:07.155'),('fa16ab42-f551-418f-a0d1-ea624f0cd7af','Ox 5v',NULL,NULL,'USO_INTERNO',101.50,2,1,'g',NULL,NULL,0,1,'2025-07-28 19:04:15.716','2025-07-29 18:33:36.890'),('fc772085-7129-4ce4-bd58-60de4a7c7fc2','Máscara Pigmentante Canário',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:57:18.441','2025-07-29 17:57:18.441'),('fcf3244e-5997-44d6-977a-2e0c06d2a399','Máscara Pigmentante Guará',NULL,NULL,'USO_INTERNO',64.50,3,1,'ml',NULL,NULL,0,1,'2025-07-29 17:51:22.331','2025-07-29 17:51:22.331');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('ANIVERSARIO','MANUAL','PRODUTO_BAIXO','AGENDAMENTO','DESPESA_FIXA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) NOT NULL,
  `priority` enum('POUCO_URGENTE','URGENTE','IMEDIATO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'POUCO_URGENTE',
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reminders_clientId_fkey` (`clientId`),
  KEY `reminders_userId_fkey` (`userId`),
  CONSTRAINT `reminders_clientId_fkey` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reminders_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
INSERT INTO `reminders` VALUES ('afbcf8e6-4223-45e5-b515-24354526b775','MANUAL','arrumar cafeteira ',NULL,'2025-08-05 14:30:00.000','POUCO_URGENTE',NULL,NULL,1,'2025-07-28 18:14:52.709','2025-07-28 18:14:52.709');
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goals`
--

DROP TABLE IF EXISTS `goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goals` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` enum('SEMANAL','MENSAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `targetAmount` decimal(10,2) NOT NULL,
  `currentAmount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `startDate` datetime(3) NOT NULL,
  `endDate` datetime(3) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goals`
--

LOCK TABLES `goals` WRITE;
/*!40000 ALTER TABLE `goals` DISABLE KEYS */;
/*!40000 ALTER TABLE `goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_expenses`
--

DROP TABLE IF EXISTS `fixed_expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixed_expenses` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `dueDay` int NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_expenses`
--

LOCK TABLES `fixed_expenses` WRITE;
/*!40000 ALTER TABLE `fixed_expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_movements`
--

DROP TABLE IF EXISTS `stock_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_movements` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `productId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('RECEITA','DESPESA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `stock_movements_productId_fkey` (`productId`),
  CONSTRAINT `stock_movements_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_movements`
--

LOCK TABLES `stock_movements` WRITE;
/*!40000 ALTER TABLE `stock_movements` DISABLE KEYS */;
INSERT INTO `stock_movements` VALUES ('2573ac7e-78f1-4515-b4fa-289129682dca','e6e46b66-3603-4a07-a0f6-9e6f776aee1f','RECEITA',298,'Movimento de estoque - ADJUSTMENT','2025-08-06 15:20:17.013'),('47a1458f-7d79-4007-8d1e-3774401cedcd','9cfa9ad7-ead7-4299-8090-5804b69c4ba2','DESPESA',1,'Consumo - Agendamento 978bec64-90dc-4366-a312-7177dabcbb14','2025-07-28 18:09:41.335'),('6537de33-a7c5-403e-9c97-beb5f85d52e0','c80c8a22-aefc-4659-9302-2924bafcf58b','DESPESA',2,'Consumo - Agendamento 978bec64-90dc-4366-a312-7177dabcbb14','2025-07-28 18:09:41.344'),('9552aab2-6fb6-4973-b8da-68a85dda492f','5f74e162-29a1-47d6-a8cc-04647b9410ef','DESPESA',1,'Consumo - Agendamento 978bec64-90dc-4366-a312-7177dabcbb14','2025-07-28 18:09:41.321'),('98b89493-9b56-4ddf-a714-9ff1fd72c3fe','e6e46b66-3603-4a07-a0f6-9e6f776aee1f','DESPESA',2,'Consumo - Agendamento 978bec64-90dc-4366-a312-7177dabcbb14','2025-07-28 18:09:41.351'),('cbe5ea6e-bd7f-4342-9bab-f7ca296b3e80','1c103883-cd7b-4b69-87cf-f14c693784b1','DESPESA',1,'Consumo - Agendamento 978bec64-90dc-4366-a312-7177dabcbb14','2025-07-28 18:09:41.311');
/*!40000 ALTER TABLE `stock_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('ADMIN','CABELEIREIRO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CABELEIREIRO',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_key` (`username`),
  UNIQUE KEY `users_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('21d5ecb2-d0a7-4471-8bc1-87d9998add77','aa','$2b$10$fBKXDW0q2Z1snUZBaEvRquGa.Ct7bc7tE3iV4yLyblFz15KyK7xJS','aa','aa@mailk.com','1498811111','CABELEIREIRO',0,'2025-07-26 02:17:35.368','2025-07-26 14:07:55.434'),('59286226-8fd4-40ba-8be1-5c9b8cdbb7f3','ju','$2b$10$d3x2YRqe/mJ50PX4QXDPt.2dVN9O0TkpUu7krfSID/MepM8I6QThG','ju','ju@mail.com','149999999999','CABELEIREIRO',0,'2025-07-25 18:50:40.163','2025-07-26 14:08:00.152'),('957d3c01-c3d4-41c3-9ce3-090e770bb753','Daniel','$2b$10$DuHt17EQocn/.x2N62TBL.H2klOZ9/bAReb5WbhXkugl3R8bOeksC','Daniel Cayres','dcfcontato@icloud.com','14988117592','CABELEIREIRO',0,'2025-07-26 01:12:04.466','2025-07-26 14:08:10.574'),('95ca4a82-4c0b-4a99-98a9-f5e4f3ae269e','teste','$2b$10$sesQQXEvp1Rz/hGI4EN5POxz4s2dP4j1.i3Qg2UF9aCnwvih6WVQm','Teste User','teste@teste.com',NULL,'ADMIN',0,'2025-07-26 02:14:20.299','2025-07-26 14:08:17.661'),('9ae07a9e-9613-4ec8-a469-6e7e5e010d4d','Um','$2b$10$Lg9R/zDYIvgKeI6IUuKwh.KG5XhpRE2.A9A5d/uFVQ./I3g3qbL5m','um','um@mail.com','111111','CABELEIREIRO',0,'2025-07-25 18:47:21.110','2025-07-26 14:08:23.153'),('a383a4cf-decf-4243-8e93-1ba925997f62','test_user','$2b$10$tgHvuZthOyLdl1pK.ca60OX6iA7YZvH90THgxphXEpcre65HH8bY.','Usuário Teste','test@teste.com',NULL,'CABELEIREIRO',0,'2025-07-26 01:10:30.669','2025-07-26 14:08:26.925'),('ab1417f2-2329-4aaf-9135-605ba18da1fc','Cayres','$2b$10$AMyUhVqq8J.KEjfNvKuHs.bQiMjvbBr8fQ84HuLYMPpRPybtPqCPi','Administrador Cayres','admin@covenos.com.br',NULL,'ADMIN',1,'2025-07-25 18:44:24.033','2025-07-25 18:44:24.033'),('f481ccce-2af2-447a-abe2-f97e3cba9871','Juliana','$2b$10$2.7rqNVsQ.JbEOAjkPixke/UJw1PzOeuClqq0VhIUwPtRJSL80QCy','Juliana Marques dos Santos','juliana-marques2010@hotmail.com','14996679741','CABELEIREIRO',1,'2025-07-25 18:46:22.885','2025-07-25 18:46:22.885'),('fb4d6cfe-3643-46b2-8158-3f0fc3814e39','aaa','$2b$10$Bw.h1VxYvmkVIPus3UTDPOzNvrTiJN8DjF3bU2YcZMPbjhHO0ohMK','aa','aa@mai.com','aaa','CABELEIREIRO',0,'2025-07-26 02:43:08.780','2025-07-26 14:08:34.732');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 15:56:17
