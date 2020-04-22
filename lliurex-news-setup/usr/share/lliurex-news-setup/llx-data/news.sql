-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: ghost
-- ------------------------------------------------------
-- Server version 5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` varchar(24) NOT NULL,
  `resource_id` varchar(24) DEFAULT NULL,
  `resource_type` varchar(50) NOT NULL,
  `actor_id` varchar(24) NOT NULL,
  `actor_type` varchar(50) NOT NULL,
  `event` varchar(50) NOT NULL,
  `context` text,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `role_id` varchar(24) DEFAULT NULL,
  `integration_id` varchar(24) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `last_seen_version` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_secret_unique` (`secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
INSERT INTO `api_keys` VALUES ('5e7b25475765162c5bea29c9','admin','786b46eb9d8f96137ca1df472d21774e613a39f42ac2d6278756afd84dffedf2','5e7b25465765162c5bea296c','5e7b25475765162c5bea29c8',NULL,NULL,'2020-03-25 09:32:56','1','2020-03-25 09:32:56','1'),('5e7b25475765162c5bea29cb','admin','8b96d72c51a65de1e8e0706d08a1143f2509ff7df73a5832ec6d9f06110d7908','5e7b25465765162c5bea296d','5e7b25475765162c5bea29ca',NULL,NULL,'2020-03-25 09:32:56','1','2020-03-25 09:32:56','1'),('5e7b25475765162c5bea29cd','admin','062616edefb1c1bb9f6ef792d1ae64849ac716afca677b59d43ddd2f0f424f76','5e7b25465765162c5bea296e','5e7b25475765162c5bea29cc',NULL,NULL,'2020-03-25 09:32:56','1','2020-03-25 09:32:56','1');
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_fields`
--

DROP TABLE IF EXISTS `app_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_fields` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'html',
  `app_id` varchar(24) NOT NULL,
  `relatable_id` varchar(24) NOT NULL,
  `relatable_type` varchar(50) NOT NULL DEFAULT 'posts',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_fields_app_id_foreign` (`app_id`),
  CONSTRAINT `app_fields_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_fields`
--

LOCK TABLES `app_fields` WRITE;
/*!40000 ALTER TABLE `app_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `app_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_settings_key_unique` (`key`),
  KEY `app_settings_app_id_foreign` (`app_id`),
  CONSTRAINT `app_settings_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_settings`
--

LOCK TABLES `app_settings` WRITE;
/*!40000 ALTER TABLE `app_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apps` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `version` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'inactive',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apps_name_unique` (`name`),
  UNIQUE KEY `apps_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apps`
--

LOCK TABLES `apps` WRITE;
/*!40000 ALTER TABLE `apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brute`
--

DROP TABLE IF EXISTS `brute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brute` (
  `key` varchar(191) NOT NULL,
  `firstRequest` bigint(20) NOT NULL,
  `lastRequest` bigint(20) NOT NULL,
  `lifetime` bigint(20) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brute`
--

LOCK TABLES `brute` WRITE;
/*!40000 ALTER TABLE `brute` DISABLE KEYS */;
INSERT INTO `brute` VALUES ('RbNOOkdpdCr+/5Atz8yk+EpDd6NiFTAsg43AYo9gf54=',1585130644530,1585130644531,1585134244537,1),('Bq0ZSLVeK0+S/h/69r+cBxm+9Hgplitnb4NrXlPVwgg=',1585131221687,1585131221687,1585134821691,1),('IH8YnWymezYrbv5kSiKbGS6lJINUGzNjnAPZ9/iUxOs=',1585131428379,1585133947153,1585137547156,3),('BbIfduwgOFcRSYf02VX2HNdIYrM/uHP1K6N13lCxb6w=',1585133549651,1585133557073,1585137157075,2),('+QW1cpRDQ70vErudDqgf9yArAh051+fT8fE8m4HL2Pc=',1585133549662,1585133549662,1597834349665,1);
/*!40000 ALTER TABLE `brute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `error` varchar(2000) DEFAULT NULL,
  `error_data` longtext,
  `meta` text,
  `stats` text,
  `email_count` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(300) DEFAULT NULL,
  `html` longtext,
  `plaintext` longtext,
  `submitted_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emails_post_id_unique` (`post_id`),
  KEY `emails_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrations` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'custom',
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `icon_image` varchar(2000) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `integrations_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrations`
--

LOCK TABLES `integrations` WRITE;
/*!40000 ALTER TABLE `integrations` DISABLE KEYS */;
INSERT INTO `integrations` VALUES ('5e7b25475765162c5bea29c8','builtin','Zapier','zapier',NULL,'Built-in Zapier integration','2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29ca','internal','Ghost Backup','ghost-backup',NULL,'Internal DB Backup integration','2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29cc','internal','Ghost Scheduler','ghost-scheduler',NULL,'Internal Scheduler integration','2020-03-25 09:32:55','1','2020-03-25 09:32:55','1');
/*!40000 ALTER TABLE `integrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invites` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `token` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `expires` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invites_token_unique` (`token`),
  UNIQUE KEY `invites_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labels`
--

DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labels` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `labels_name_unique` (`name`),
  UNIQUE KEY `labels_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labels`
--

LOCK TABLES `labels` WRITE;
/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `note` varchar(2000) DEFAULT NULL,
  `geolocation` varchar(2000) DEFAULT NULL,
  `subscribed` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `members_email_unique` (`email`),
  UNIQUE KEY `members_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_labels`
--

DROP TABLE IF EXISTS `members_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members_labels` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `label_id` varchar(24) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `members_labels_member_id_foreign` (`member_id`),
  KEY `members_labels_label_id_foreign` (`label_id`),
  CONSTRAINT `members_labels_label_id_foreign` FOREIGN KEY (`label_id`) REFERENCES `labels` (`id`),
  CONSTRAINT `members_labels_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_labels`
--

LOCK TABLES `members_labels` WRITE;
/*!40000 ALTER TABLE `members_labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_stripe_customers`
--

DROP TABLE IF EXISTS `members_stripe_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members_stripe_customers` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_stripe_customers`
--

LOCK TABLES `members_stripe_customers` WRITE;
/*!40000 ALTER TABLE `members_stripe_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_stripe_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_stripe_customers_subscriptions`
--

DROP TABLE IF EXISTS `members_stripe_customers_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members_stripe_customers_subscriptions` (
  `id` varchar(24) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `subscription_id` varchar(255) NOT NULL,
  `plan_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `cancel_at_period_end` tinyint(1) NOT NULL DEFAULT '0',
  `current_period_end` datetime NOT NULL,
  `start_date` datetime NOT NULL,
  `default_payment_card_last4` varchar(4) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  `plan_nickname` varchar(50) NOT NULL,
  `plan_interval` varchar(50) NOT NULL,
  `plan_amount` int(11) NOT NULL,
  `plan_currency` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_stripe_customers_subscriptions`
--

LOCK TABLES `members_stripe_customers_subscriptions` WRITE;
/*!40000 ALTER TABLE `members_stripe_customers_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_stripe_customers_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `version` varchar(70) NOT NULL,
  `currentVersion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_name_version_unique` (`name`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'1-create-tables.js','init','3.12'),(2,'2-create-fixtures.js','init','3.12'),(3,'1-post-excerpt.js','1.3','3.12'),(4,'1-codeinjection-post.js','1.4','3.12'),(5,'1-og-twitter-post.js','1.5','3.12'),(6,'1-add-backup-client.js','1.7','3.12'),(7,'1-add-permissions-redirect.js','1.9','3.12'),(8,'1-custom-template-post.js','1.13','3.12'),(9,'2-theme-permissions.js','1.13','3.12'),(10,'1-add-webhooks-table.js','1.18','3.12'),(11,'1-webhook-permissions.js','1.19','3.12'),(12,'1-remove-settings-keys.js','1.20','3.12'),(13,'1-add-contributor-role.js','1.21','3.12'),(14,'1-multiple-authors-DDL.js','1.22','3.12'),(15,'1-multiple-authors-DML.js','1.22','3.12'),(16,'1-update-koenig-beta-html.js','1.25','3.12'),(17,'2-demo-post.js','1.25','3.12'),(18,'1-rename-amp-column.js','2.0','3.12'),(19,'2-update-posts.js','2.0','3.12'),(20,'3-remove-koenig-labs.js','2.0','3.12'),(21,'4-permalink-setting.js','2.0','3.12'),(22,'5-remove-demo-post.js','2.0','3.12'),(23,'6-replace-fixture-posts.js','2.0','3.12'),(24,'1-add-sessions-table.js','2.2','3.12'),(25,'2-add-integrations-and-api-key-tables.js','2.2','3.12'),(26,'3-insert-admin-integration-role.js','2.2','3.12'),(27,'4-insert-integration-and-api-key-permissions.js','2.2','3.12'),(28,'5-add-mobiledoc-revisions-table.js','2.2','3.12'),(29,'1-add-webhook-columns.js','2.3','3.12'),(30,'2-add-webhook-edit-permission.js','2.3','3.12'),(31,'1-add-webhook-permission-roles.js','2.6','3.12'),(32,'1-add-members-table.js','2.8','3.12'),(33,'1-remove-empty-strings.js','2.13','3.12'),(34,'1-add-actions-table.js','2.14','3.12'),(35,'2-add-actions-permissions.js','2.14','3.12'),(36,'1-add-type-column-to-integrations.js','2.15','3.12'),(37,'2-insert-zapier-integration.js','2.15','3.12'),(38,'1-add-members-perrmissions.js','2.16','3.12'),(39,'1-normalize-settings.js','2.17','3.12'),(40,'2-posts-add-canonical-url.js','2.17','3.12'),(41,'1-restore-settings-from-backup.js','2.18','3.12'),(42,'1-update-editor-permissions.js','2.21','3.12'),(43,'1-add-member-permissions-to-roles.js','2.22','3.12'),(44,'1-insert-ghost-db-backup-role.js','2.27','3.12'),(45,'2-insert-db-backup-integration.js','2.27','3.12'),(46,'3-add-subdirectory-to-relative-canonical-urls.js','2.27','3.12'),(47,'1-add-db-backup-content-permission.js','2.28','3.12'),(48,'2-add-db-backup-content-permission-to-roles.js','2.28','3.12'),(49,'3-insert-ghost-scheduler-role.js','2.28','3.12'),(50,'4-insert-scheduler-integration.js','2.28','3.12'),(51,'5-add-scheduler-permission-to-roles.js','2.28','3.12'),(52,'6-add-type-column.js','2.28','3.12'),(53,'7-populate-type-column.js','2.28','3.12'),(54,'8-remove-page-column.js','2.28','3.12'),(55,'1-add-post-page-column.js','2.29','3.12'),(56,'2-populate-post-page-column.js','2.29','3.12'),(57,'3-remove-page-type-column.js','2.29','3.12'),(58,'1-remove-name-and-password-from-members-table.js','2.31','3.12'),(59,'01-add-members-stripe-customers-table.js','2.32','3.12'),(60,'02-add-name-to-members-table.js','2.32','3.12'),(61,'01-correct-members-stripe-customers-table.js','2.33','3.12'),(62,'01-add-stripe-customers-subscriptions-table.js','2.34','3.12'),(63,'02-add-email-to-members-stripe-customers-table.js','2.34','3.12'),(64,'03-add-name-to-members-stripe-customers-table.js','2.34','3.12'),(65,'01-add-note-to-members-table.js','2.35','3.12'),(66,'01-add-self-signup-and-from address-to-members-settings.js','2.37','3.12'),(67,'01-remove-user-ghost-auth-columns.js','3.0','3.12'),(68,'02-drop-token-auth-tables.js','3.0','3.12'),(69,'03-drop-client-auth-tables.js','3.0','3.12'),(70,'04-add-posts-meta-table.js','3.0','3.12'),(71,'05-populate-posts-meta-table.js','3.0','3.12'),(72,'06-remove-posts-meta-columns.js','3.0','3.12'),(73,'07-add-posts-type-column.js','3.0','3.12'),(74,'08-populate-posts-type-column.js','3.0','3.12'),(75,'09-remove-posts-page-column.js','3.0','3.12'),(76,'10-remove-empty-strings.js','3.0','3.12'),(77,'11-update-posts-html.js','3.0','3.12'),(78,'12-populate-members-table-from-subscribers.js','3.0','3.12'),(79,'13-drop-subscribers-table.js','3.0','3.12'),(80,'14-remove-subscribers-flag.js','3.0','3.12'),(81,'01-add-send-email-when-published-to-posts.js','3.1','3.12'),(82,'02-add-email-subject-to-posts-meta.js','3.1','3.12'),(83,'03-add-email-preview-permissions.js','3.1','3.12'),(84,'04-add-subscribed-flag-to-members.js','3.1','3.12'),(85,'05-add-emails-table.js','3.1','3.12'),(86,'06-add-email-permissions.js','3.1','3.12'),(87,'07-add-uuid-field-to-members.js','3.1','3.12'),(88,'08-add-uuid-values-to-members.js','3.1','3.12'),(89,'09-add-further-email-permissions.js','3.1','3.12'),(90,'10-add-email-error-data-column.js','3.1','3.12'),(91,'01-add-cancel-at-period-end-to-subscriptions.js','3.2','3.12'),(92,'1-add-labels-table.js','3.6','3.12'),(93,'2-add-members-labels-table.js','3.6','3.12'),(94,'3-add-labels-permissions.js','3.6','3.12'),(95,'01-fix-incorrect-member-labels-foreign-keys.js','3.7','3.12'),(96,'01-add-geolocation-to-members.js','3.8','3.12'),(97,'01-add-member-sigin-url-permissions.js','3.9','3.12'),(98,'01-remove-broken-complimentary-plan-from-members-settings.js','3.11','3.12'),(99,'01-add-identity-permission.js','3.12','3.12'),(100,'02-remove-legacy-is-paid-flag-from-settings.js','3.12','3.12');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations_lock`
--

DROP TABLE IF EXISTS `migrations_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations_lock` (
  `lock_key` varchar(191) NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `acquired_at` datetime DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  UNIQUE KEY `migrations_lock_lock_key_unique` (`lock_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations_lock`
--

LOCK TABLES `migrations_lock` WRITE;
/*!40000 ALTER TABLE `migrations_lock` DISABLE KEYS */;
INSERT INTO `migrations_lock` VALUES ('km01',0,'2020-03-25 09:32:53','2020-03-25 09:32:56');
/*!40000 ALTER TABLE `migrations_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobiledoc_revisions`
--

DROP TABLE IF EXISTS `mobiledoc_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobiledoc_revisions` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `mobiledoc` longtext,
  `created_at_ts` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mobiledoc_revisions_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobiledoc_revisions`
--

LOCK TABLES `mobiledoc_revisions` WRITE;
/*!40000 ALTER TABLE `mobiledoc_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobiledoc_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `object_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES ('5e7b25465765162c5bea296f','Export database','db','exportContent',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2970','Import database','db','importContent',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2971','Delete all content','db','deleteAllContent',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2972','Send mail','mail','send',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2973','Browse notifications','notification','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2974','Add notifications','notification','add',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2975','Delete notifications','notification','destroy',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2976','Browse posts','post','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2977','Read posts','post','read',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2978','Edit posts','post','edit',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2979','Add posts','post','add',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297a','Delete posts','post','destroy',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297b','Browse settings','setting','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297c','Read settings','setting','read',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297d','Edit settings','setting','edit',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297e','Generate slugs','slug','generate',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea297f','Browse tags','tag','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2980','Read tags','tag','read',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2981','Edit tags','tag','edit',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2982','Add tags','tag','add',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2983','Delete tags','tag','destroy',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2984','Browse themes','theme','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2985','Edit themes','theme','edit',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2986','Activate themes','theme','activate',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2987','Upload themes','theme','add',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2988','Download themes','theme','read',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2989','Delete themes','theme','destroy',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298a','Browse users','user','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298b','Read users','user','read',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298c','Edit users','user','edit',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298d','Add users','user','add',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298e','Delete users','user','destroy',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea298f','Assign a role','role','assign',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2990','Browse roles','role','browse',NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25475765162c5bea2991','Browse invites','invite','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2992','Read invites','invite','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2993','Edit invites','invite','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2994','Add invites','invite','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2995','Delete invites','invite','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2996','Download redirects','redirect','download',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2997','Upload redirects','redirect','upload',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2998','Add webhooks','webhook','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea2999','Edit webhooks','webhook','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299a','Delete webhooks','webhook','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299b','Browse integrations','integration','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299c','Read integrations','integration','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299d','Edit integrations','integration','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299e','Add integrations','integration','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea299f','Delete integrations','integration','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a0','Browse API keys','api_key','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a1','Read API keys','api_key','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a2','Edit API keys','api_key','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a3','Add API keys','api_key','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a4','Delete API keys','api_key','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a5','Browse Actions','action','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a6','Browse Members','member','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a7','Read Members','member','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a8','Edit Members','member','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29a9','Add Members','member','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29aa','Delete Members','member','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29ab','Publish posts','post','publish',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29ac','Backup database','db','backupContent',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29ad','Email preview','email_preview','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29ae','Send test email','email_preview','sendTestEmail',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29af','Browse emails','email','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b0','Read emails','email','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b1','Retry emails','email','retry',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b2','Browse labels','label','browse',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b3','Read labels','label','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b4','Edit labels','label','edit',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b5','Add labels','label','add',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b6','Delete labels','label','destroy',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b7','Read member signin urls','member_signin_url','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1'),('5e7b25475765162c5bea29b8','Read identities','identity','read',NULL,'2020-03-25 09:32:55','1','2020-03-25 09:32:55','1');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_apps`
--

DROP TABLE IF EXISTS `permissions_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_apps` (
  `id` varchar(24) NOT NULL,
  `app_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_apps`
--

LOCK TABLES `permissions_apps` WRITE;
/*!40000 ALTER TABLE `permissions_apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_roles`
--

DROP TABLE IF EXISTS `permissions_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_roles` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_roles`
--

LOCK TABLES `permissions_roles` WRITE;
/*!40000 ALTER TABLE `permissions_roles` DISABLE KEYS */;
INSERT INTO `permissions_roles` VALUES ('5e7b25475765162c5bea29ce','5e7b25465765162c5bea2967','5e7b25465765162c5bea296f'),('5e7b25475765162c5bea29cf','5e7b25465765162c5bea2967','5e7b25465765162c5bea2970'),('5e7b25475765162c5bea29d0','5e7b25465765162c5bea2967','5e7b25465765162c5bea2971'),('5e7b25475765162c5bea29d1','5e7b25465765162c5bea2967','5e7b25475765162c5bea29ac'),('5e7b25475765162c5bea29d2','5e7b25465765162c5bea2967','5e7b25465765162c5bea2972'),('5e7b25475765162c5bea29d3','5e7b25465765162c5bea2967','5e7b25465765162c5bea2973'),('5e7b25475765162c5bea29d4','5e7b25465765162c5bea2967','5e7b25465765162c5bea2974'),('5e7b25475765162c5bea29d5','5e7b25465765162c5bea2967','5e7b25465765162c5bea2975'),('5e7b25475765162c5bea29d6','5e7b25465765162c5bea2967','5e7b25465765162c5bea2976'),('5e7b25475765162c5bea29d7','5e7b25465765162c5bea2967','5e7b25465765162c5bea2977'),('5e7b25475765162c5bea29d8','5e7b25465765162c5bea2967','5e7b25465765162c5bea2978'),('5e7b25475765162c5bea29d9','5e7b25465765162c5bea2967','5e7b25465765162c5bea2979'),('5e7b25475765162c5bea29da','5e7b25465765162c5bea2967','5e7b25465765162c5bea297a'),('5e7b25475765162c5bea29db','5e7b25465765162c5bea2967','5e7b25475765162c5bea29ab'),('5e7b25475765162c5bea29dc','5e7b25465765162c5bea2967','5e7b25465765162c5bea297b'),('5e7b25475765162c5bea29dd','5e7b25465765162c5bea2967','5e7b25465765162c5bea297c'),('5e7b25475765162c5bea29de','5e7b25465765162c5bea2967','5e7b25465765162c5bea297d'),('5e7b25475765162c5bea29df','5e7b25465765162c5bea2967','5e7b25465765162c5bea297e'),('5e7b25475765162c5bea29e0','5e7b25465765162c5bea2967','5e7b25465765162c5bea297f'),('5e7b25475765162c5bea29e1','5e7b25465765162c5bea2967','5e7b25465765162c5bea2980'),('5e7b25475765162c5bea29e2','5e7b25465765162c5bea2967','5e7b25465765162c5bea2981'),('5e7b25475765162c5bea29e3','5e7b25465765162c5bea2967','5e7b25465765162c5bea2982'),('5e7b25475765162c5bea29e4','5e7b25465765162c5bea2967','5e7b25465765162c5bea2983'),('5e7b25485765162c5bea29e5','5e7b25465765162c5bea2967','5e7b25465765162c5bea2984'),('5e7b25485765162c5bea29e6','5e7b25465765162c5bea2967','5e7b25465765162c5bea2985'),('5e7b25485765162c5bea29e7','5e7b25465765162c5bea2967','5e7b25465765162c5bea2986'),('5e7b25485765162c5bea29e8','5e7b25465765162c5bea2967','5e7b25465765162c5bea2987'),('5e7b25485765162c5bea29e9','5e7b25465765162c5bea2967','5e7b25465765162c5bea2988'),('5e7b25485765162c5bea29ea','5e7b25465765162c5bea2967','5e7b25465765162c5bea2989'),('5e7b25485765162c5bea29eb','5e7b25465765162c5bea2967','5e7b25465765162c5bea298a'),('5e7b25485765162c5bea29ec','5e7b25465765162c5bea2967','5e7b25465765162c5bea298b'),('5e7b25485765162c5bea29ed','5e7b25465765162c5bea2967','5e7b25465765162c5bea298c'),('5e7b25485765162c5bea29ee','5e7b25465765162c5bea2967','5e7b25465765162c5bea298d'),('5e7b25485765162c5bea29ef','5e7b25465765162c5bea2967','5e7b25465765162c5bea298e'),('5e7b25485765162c5bea29f0','5e7b25465765162c5bea2967','5e7b25465765162c5bea298f'),('5e7b25485765162c5bea29f1','5e7b25465765162c5bea2967','5e7b25465765162c5bea2990'),('5e7b25485765162c5bea29f2','5e7b25465765162c5bea2967','5e7b25475765162c5bea2991'),('5e7b25485765162c5bea29f3','5e7b25465765162c5bea2967','5e7b25475765162c5bea2992'),('5e7b25485765162c5bea29f4','5e7b25465765162c5bea2967','5e7b25475765162c5bea2993'),('5e7b25485765162c5bea29f5','5e7b25465765162c5bea2967','5e7b25475765162c5bea2994'),('5e7b25485765162c5bea29f6','5e7b25465765162c5bea2967','5e7b25475765162c5bea2995'),('5e7b25485765162c5bea29f7','5e7b25465765162c5bea2967','5e7b25475765162c5bea2996'),('5e7b25485765162c5bea29f8','5e7b25465765162c5bea2967','5e7b25475765162c5bea2997'),('5e7b25485765162c5bea29f9','5e7b25465765162c5bea2967','5e7b25475765162c5bea2998'),('5e7b25485765162c5bea29fa','5e7b25465765162c5bea2967','5e7b25475765162c5bea2999'),('5e7b25485765162c5bea29fb','5e7b25465765162c5bea2967','5e7b25475765162c5bea299a'),('5e7b25485765162c5bea29fc','5e7b25465765162c5bea2967','5e7b25475765162c5bea299b'),('5e7b25485765162c5bea29fd','5e7b25465765162c5bea2967','5e7b25475765162c5bea299c'),('5e7b25485765162c5bea29fe','5e7b25465765162c5bea2967','5e7b25475765162c5bea299d'),('5e7b25485765162c5bea29ff','5e7b25465765162c5bea2967','5e7b25475765162c5bea299e'),('5e7b25485765162c5bea2a00','5e7b25465765162c5bea2967','5e7b25475765162c5bea299f'),('5e7b25485765162c5bea2a01','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a0'),('5e7b25485765162c5bea2a02','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a1'),('5e7b25485765162c5bea2a03','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a2'),('5e7b25485765162c5bea2a04','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a3'),('5e7b25485765162c5bea2a05','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a4'),('5e7b25485765162c5bea2a06','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a5'),('5e7b25485765162c5bea2a07','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a6'),('5e7b25485765162c5bea2a08','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a7'),('5e7b25485765162c5bea2a09','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a8'),('5e7b25485765162c5bea2a0a','5e7b25465765162c5bea2967','5e7b25475765162c5bea29a9'),('5e7b25485765162c5bea2a0b','5e7b25465765162c5bea2967','5e7b25475765162c5bea29aa'),('5e7b25485765162c5bea2a0c','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b2'),('5e7b25485765162c5bea2a0d','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b3'),('5e7b25485765162c5bea2a0e','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b4'),('5e7b25485765162c5bea2a0f','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b5'),('5e7b25485765162c5bea2a10','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b6'),('5e7b25485765162c5bea2a11','5e7b25465765162c5bea2967','5e7b25475765162c5bea29ad'),('5e7b25485765162c5bea2a12','5e7b25465765162c5bea2967','5e7b25475765162c5bea29ae'),('5e7b25485765162c5bea2a13','5e7b25465765162c5bea2967','5e7b25475765162c5bea29af'),('5e7b25485765162c5bea2a14','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b0'),('5e7b25485765162c5bea2a15','5e7b25465765162c5bea2967','5e7b25475765162c5bea29b1'),('5e7b25485765162c5bea2a16','5e7b25465765162c5bea296d','5e7b25465765162c5bea296f'),('5e7b25485765162c5bea2a17','5e7b25465765162c5bea296d','5e7b25465765162c5bea2970'),('5e7b25485765162c5bea2a18','5e7b25465765162c5bea296d','5e7b25465765162c5bea2971'),('5e7b25485765162c5bea2a19','5e7b25465765162c5bea296d','5e7b25475765162c5bea29ac'),('5e7b25485765162c5bea2a1a','5e7b25465765162c5bea296e','5e7b25475765162c5bea29ab'),('5e7b25485765162c5bea2a1b','5e7b25465765162c5bea296c','5e7b25465765162c5bea2972'),('5e7b25485765162c5bea2a1c','5e7b25465765162c5bea296c','5e7b25465765162c5bea2973'),('5e7b25485765162c5bea2a1d','5e7b25465765162c5bea296c','5e7b25465765162c5bea2974'),('5e7b25485765162c5bea2a1e','5e7b25465765162c5bea296c','5e7b25465765162c5bea2975'),('5e7b25485765162c5bea2a1f','5e7b25465765162c5bea296c','5e7b25465765162c5bea2976'),('5e7b25485765162c5bea2a20','5e7b25465765162c5bea296c','5e7b25465765162c5bea2977'),('5e7b25485765162c5bea2a21','5e7b25465765162c5bea296c','5e7b25465765162c5bea2978'),('5e7b25485765162c5bea2a22','5e7b25465765162c5bea296c','5e7b25465765162c5bea2979'),('5e7b25485765162c5bea2a23','5e7b25465765162c5bea296c','5e7b25465765162c5bea297a'),('5e7b25485765162c5bea2a24','5e7b25465765162c5bea296c','5e7b25475765162c5bea29ab'),('5e7b25485765162c5bea2a25','5e7b25465765162c5bea296c','5e7b25465765162c5bea297b'),('5e7b25485765162c5bea2a26','5e7b25465765162c5bea296c','5e7b25465765162c5bea297c'),('5e7b25485765162c5bea2a27','5e7b25465765162c5bea296c','5e7b25465765162c5bea297d'),('5e7b25485765162c5bea2a28','5e7b25465765162c5bea296c','5e7b25465765162c5bea297e'),('5e7b25485765162c5bea2a29','5e7b25465765162c5bea296c','5e7b25465765162c5bea297f'),('5e7b25485765162c5bea2a2a','5e7b25465765162c5bea296c','5e7b25465765162c5bea2980'),('5e7b25485765162c5bea2a2b','5e7b25465765162c5bea296c','5e7b25465765162c5bea2981'),('5e7b25485765162c5bea2a2c','5e7b25465765162c5bea296c','5e7b25465765162c5bea2982'),('5e7b25485765162c5bea2a2d','5e7b25465765162c5bea296c','5e7b25465765162c5bea2983'),('5e7b25485765162c5bea2a2e','5e7b25465765162c5bea296c','5e7b25465765162c5bea2984'),('5e7b25485765162c5bea2a2f','5e7b25465765162c5bea296c','5e7b25465765162c5bea2985'),('5e7b25485765162c5bea2a30','5e7b25465765162c5bea296c','5e7b25465765162c5bea2986'),('5e7b25485765162c5bea2a31','5e7b25465765162c5bea296c','5e7b25465765162c5bea2987'),('5e7b25485765162c5bea2a32','5e7b25465765162c5bea296c','5e7b25465765162c5bea2988'),('5e7b25485765162c5bea2a33','5e7b25465765162c5bea296c','5e7b25465765162c5bea2989'),('5e7b25485765162c5bea2a34','5e7b25465765162c5bea296c','5e7b25465765162c5bea298a'),('5e7b25485765162c5bea2a35','5e7b25465765162c5bea296c','5e7b25465765162c5bea298b'),('5e7b25485765162c5bea2a36','5e7b25465765162c5bea296c','5e7b25465765162c5bea298c'),('5e7b25485765162c5bea2a37','5e7b25465765162c5bea296c','5e7b25465765162c5bea298d'),('5e7b25485765162c5bea2a38','5e7b25465765162c5bea296c','5e7b25465765162c5bea298e'),('5e7b25485765162c5bea2a39','5e7b25465765162c5bea296c','5e7b25465765162c5bea298f'),('5e7b25485765162c5bea2a3a','5e7b25465765162c5bea296c','5e7b25465765162c5bea2990'),('5e7b25485765162c5bea2a3b','5e7b25465765162c5bea296c','5e7b25475765162c5bea2991'),('5e7b25485765162c5bea2a3c','5e7b25465765162c5bea296c','5e7b25475765162c5bea2992'),('5e7b25485765162c5bea2a3d','5e7b25465765162c5bea296c','5e7b25475765162c5bea2993'),('5e7b25485765162c5bea2a3e','5e7b25465765162c5bea296c','5e7b25475765162c5bea2994'),('5e7b25485765162c5bea2a3f','5e7b25465765162c5bea296c','5e7b25475765162c5bea2995'),('5e7b25485765162c5bea2a40','5e7b25465765162c5bea296c','5e7b25475765162c5bea2996'),('5e7b25485765162c5bea2a41','5e7b25465765162c5bea296c','5e7b25475765162c5bea2997'),('5e7b25485765162c5bea2a42','5e7b25465765162c5bea296c','5e7b25475765162c5bea2998'),('5e7b25485765162c5bea2a43','5e7b25465765162c5bea296c','5e7b25475765162c5bea2999'),('5e7b25485765162c5bea2a44','5e7b25465765162c5bea296c','5e7b25475765162c5bea299a'),('5e7b25485765162c5bea2a45','5e7b25465765162c5bea296c','5e7b25475765162c5bea29a5'),('5e7b25485765162c5bea2a46','5e7b25465765162c5bea296c','5e7b25475765162c5bea29a6'),('5e7b25485765162c5bea2a47','5e7b25465765162c5bea296c','5e7b25475765162c5bea29a7'),('5e7b25485765162c5bea2a48','5e7b25465765162c5bea296c','5e7b25475765162c5bea29a8'),('5e7b25485765162c5bea2a49','5e7b25465765162c5bea296c','5e7b25475765162c5bea29a9'),('5e7b25485765162c5bea2a4a','5e7b25465765162c5bea296c','5e7b25475765162c5bea29aa'),('5e7b25485765162c5bea2a4b','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b2'),('5e7b25485765162c5bea2a4c','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b3'),('5e7b25485765162c5bea2a4d','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b4'),('5e7b25485765162c5bea2a4e','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b5'),('5e7b25485765162c5bea2a4f','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b6'),('5e7b25485765162c5bea2a50','5e7b25465765162c5bea296c','5e7b25475765162c5bea29ad'),('5e7b25485765162c5bea2a51','5e7b25465765162c5bea296c','5e7b25475765162c5bea29ae'),('5e7b25485765162c5bea2a52','5e7b25465765162c5bea296c','5e7b25475765162c5bea29af'),('5e7b25485765162c5bea2a53','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b0'),('5e7b25485765162c5bea2a54','5e7b25465765162c5bea296c','5e7b25475765162c5bea29b1'),('5e7b25485765162c5bea2a55','5e7b25465765162c5bea2968','5e7b25465765162c5bea2973'),('5e7b25485765162c5bea2a56','5e7b25465765162c5bea2968','5e7b25465765162c5bea2974'),('5e7b25485765162c5bea2a57','5e7b25465765162c5bea2968','5e7b25465765162c5bea2975'),('5e7b25485765162c5bea2a58','5e7b25465765162c5bea2968','5e7b25465765162c5bea2976'),('5e7b25485765162c5bea2a59','5e7b25465765162c5bea2968','5e7b25465765162c5bea2977'),('5e7b25485765162c5bea2a5a','5e7b25465765162c5bea2968','5e7b25465765162c5bea2978'),('5e7b25485765162c5bea2a5b','5e7b25465765162c5bea2968','5e7b25465765162c5bea2979'),('5e7b25485765162c5bea2a5c','5e7b25465765162c5bea2968','5e7b25465765162c5bea297a'),('5e7b25485765162c5bea2a5d','5e7b25465765162c5bea2968','5e7b25475765162c5bea29ab'),('5e7b25485765162c5bea2a5e','5e7b25465765162c5bea2968','5e7b25465765162c5bea297b'),('5e7b25485765162c5bea2a5f','5e7b25465765162c5bea2968','5e7b25465765162c5bea297c'),('5e7b25485765162c5bea2a60','5e7b25465765162c5bea2968','5e7b25465765162c5bea297e'),('5e7b25485765162c5bea2a61','5e7b25465765162c5bea2968','5e7b25465765162c5bea297f'),('5e7b25485765162c5bea2a62','5e7b25465765162c5bea2968','5e7b25465765162c5bea2980'),('5e7b25485765162c5bea2a63','5e7b25465765162c5bea2968','5e7b25465765162c5bea2981'),('5e7b25485765162c5bea2a64','5e7b25465765162c5bea2968','5e7b25465765162c5bea2982'),('5e7b25485765162c5bea2a65','5e7b25465765162c5bea2968','5e7b25465765162c5bea2983'),('5e7b25485765162c5bea2a66','5e7b25465765162c5bea2968','5e7b25465765162c5bea298a'),('5e7b25485765162c5bea2a67','5e7b25465765162c5bea2968','5e7b25465765162c5bea298b'),('5e7b25485765162c5bea2a68','5e7b25465765162c5bea2968','5e7b25465765162c5bea298c'),('5e7b25485765162c5bea2a69','5e7b25465765162c5bea2968','5e7b25465765162c5bea298d'),('5e7b25485765162c5bea2a6a','5e7b25465765162c5bea2968','5e7b25465765162c5bea298e'),('5e7b25485765162c5bea2a6b','5e7b25465765162c5bea2968','5e7b25465765162c5bea298f'),('5e7b25485765162c5bea2a6c','5e7b25465765162c5bea2968','5e7b25465765162c5bea2990'),('5e7b25485765162c5bea2a6d','5e7b25465765162c5bea2968','5e7b25475765162c5bea2991'),('5e7b25485765162c5bea2a6e','5e7b25465765162c5bea2968','5e7b25475765162c5bea2992'),('5e7b25485765162c5bea2a6f','5e7b25465765162c5bea2968','5e7b25475765162c5bea2993'),('5e7b25485765162c5bea2a70','5e7b25465765162c5bea2968','5e7b25475765162c5bea2994'),('5e7b25485765162c5bea2a71','5e7b25465765162c5bea2968','5e7b25475765162c5bea2995'),('5e7b25485765162c5bea2a72','5e7b25465765162c5bea2968','5e7b25465765162c5bea2984'),('5e7b25485765162c5bea2a73','5e7b25465765162c5bea2968','5e7b25475765162c5bea29ad'),('5e7b25485765162c5bea2a74','5e7b25465765162c5bea2968','5e7b25475765162c5bea29ae'),('5e7b25485765162c5bea2a75','5e7b25465765162c5bea2968','5e7b25475765162c5bea29af'),('5e7b25485765162c5bea2a76','5e7b25465765162c5bea2968','5e7b25475765162c5bea29b0'),('5e7b25485765162c5bea2a77','5e7b25465765162c5bea2968','5e7b25475765162c5bea29b1'),('5e7b25485765162c5bea2a78','5e7b25465765162c5bea2969','5e7b25465765162c5bea2976'),('5e7b25485765162c5bea2a79','5e7b25465765162c5bea2969','5e7b25465765162c5bea2977'),('5e7b25485765162c5bea2a7a','5e7b25465765162c5bea2969','5e7b25465765162c5bea2979'),('5e7b25485765162c5bea2a7b','5e7b25465765162c5bea2969','5e7b25465765162c5bea297b'),('5e7b25485765162c5bea2a7c','5e7b25465765162c5bea2969','5e7b25465765162c5bea297c'),('5e7b25485765162c5bea2a7d','5e7b25465765162c5bea2969','5e7b25465765162c5bea297e'),('5e7b25485765162c5bea2a7e','5e7b25465765162c5bea2969','5e7b25465765162c5bea297f'),('5e7b25485765162c5bea2a7f','5e7b25465765162c5bea2969','5e7b25465765162c5bea2980'),('5e7b25485765162c5bea2a80','5e7b25465765162c5bea2969','5e7b25465765162c5bea2982'),('5e7b25485765162c5bea2a81','5e7b25465765162c5bea2969','5e7b25465765162c5bea298a'),('5e7b25485765162c5bea2a82','5e7b25465765162c5bea2969','5e7b25465765162c5bea298b'),('5e7b25485765162c5bea2a83','5e7b25465765162c5bea2969','5e7b25465765162c5bea2990'),('5e7b25485765162c5bea2a84','5e7b25465765162c5bea2969','5e7b25465765162c5bea2984'),('5e7b25485765162c5bea2a85','5e7b25465765162c5bea2969','5e7b25475765162c5bea29ad'),('5e7b25485765162c5bea2a86','5e7b25465765162c5bea2969','5e7b25475765162c5bea29b0'),('5e7b25485765162c5bea2a87','5e7b25465765162c5bea296a','5e7b25465765162c5bea2976'),('5e7b25485765162c5bea2a88','5e7b25465765162c5bea296a','5e7b25465765162c5bea2977'),('5e7b25485765162c5bea2a89','5e7b25465765162c5bea296a','5e7b25465765162c5bea2979'),('5e7b25485765162c5bea2a8a','5e7b25465765162c5bea296a','5e7b25465765162c5bea297b'),('5e7b25485765162c5bea2a8b','5e7b25465765162c5bea296a','5e7b25465765162c5bea297c'),('5e7b25485765162c5bea2a8c','5e7b25465765162c5bea296a','5e7b25465765162c5bea297e'),('5e7b25485765162c5bea2a8d','5e7b25465765162c5bea296a','5e7b25465765162c5bea297f'),('5e7b25485765162c5bea2a8e','5e7b25465765162c5bea296a','5e7b25465765162c5bea2980'),('5e7b25485765162c5bea2a8f','5e7b25465765162c5bea296a','5e7b25465765162c5bea298a'),('5e7b25485765162c5bea2a90','5e7b25465765162c5bea296a','5e7b25465765162c5bea298b'),('5e7b25485765162c5bea2a91','5e7b25465765162c5bea296a','5e7b25465765162c5bea2990'),('5e7b25485765162c5bea2a92','5e7b25465765162c5bea296a','5e7b25465765162c5bea2984'),('5e7b25485765162c5bea2a93','5e7b25465765162c5bea296a','5e7b25475765162c5bea29ad'),('5e7b25485765162c5bea2a94','5e7b25465765162c5bea296a','5e7b25475765162c5bea29b0');
/*!40000 ALTER TABLE `permissions_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_users`
--

DROP TABLE IF EXISTS `permissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions_users` (
  `id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_users`
--

LOCK TABLES `permissions_users` WRITE;
/*!40000 ALTER TABLE `permissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `title` varchar(2000) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `mobiledoc` longtext,
  `html` longtext,
  `comment_id` varchar(50) DEFAULT NULL,
  `plaintext` longtext,
  `feature_image` varchar(2000) DEFAULT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT 'post',
  `status` varchar(50) NOT NULL DEFAULT 'draft',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `send_email_when_published` tinyint(1) DEFAULT '0',
  `author_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `published_by` varchar(24) DEFAULT NULL,
  `custom_excerpt` varchar(2000) DEFAULT NULL,
  `codeinjection_head` text,
  `codeinjection_foot` text,
  `custom_template` varchar(100) DEFAULT NULL,
  `canonical_url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_authors`
--

DROP TABLE IF EXISTS `posts_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_authors` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `author_id` varchar(24) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_authors_post_id_foreign` (`post_id`),
  KEY `posts_authors_author_id_foreign` (`author_id`),
  CONSTRAINT `posts_authors_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_authors_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_authors`
--

LOCK TABLES `posts_authors` WRITE;
/*!40000 ALTER TABLE `posts_authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_meta`
--

DROP TABLE IF EXISTS `posts_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_meta` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `og_image` varchar(2000) DEFAULT NULL,
  `og_title` varchar(300) DEFAULT NULL,
  `og_description` varchar(500) DEFAULT NULL,
  `twitter_image` varchar(2000) DEFAULT NULL,
  `twitter_title` varchar(300) DEFAULT NULL,
  `twitter_description` varchar(500) DEFAULT NULL,
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `email_subject` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_meta_post_id_unique` (`post_id`),
  CONSTRAINT `posts_meta_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_meta`
--

LOCK TABLES `posts_meta` WRITE;
/*!40000 ALTER TABLE `posts_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_tags`
--

DROP TABLE IF EXISTS `posts_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_tags` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `tag_id` varchar(24) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_tags_post_id_foreign` (`post_id`),
  KEY `posts_tags_tag_id_foreign` (`tag_id`),
  CONSTRAINT `posts_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `posts_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_tags`
--

LOCK TABLES `posts_tags` WRITE;
/*!40000 ALTER TABLE `posts_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('5e7b25465765162c5bea2967','Administrator','Administrators','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2968','Editor','Editors','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea2969','Author','Authors','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea296a','Contributor','Contributors','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea296b','Owner','Blog Owner','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea296c','Admin Integration','External Apps','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea296d','DB Backup Integration','Internal DB Backup Client','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1'),('5e7b25465765162c5bea296e','Scheduler Integration','Internal Scheduler Client','2020-03-25 09:32:54','1','2020-03-25 09:32:54','1');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_users` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES ('5e7b25485765162c5bea2a9c','5e7b25465765162c5bea296b','1');
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(24) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `session_data` varchar(2000) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sessions_session_id_unique` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'core',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('5e7b25495765162c5bea2a9d','db_hash','316c386d-05fb-4503-8aff-f11982161a1f','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2a9e','next_update_check','1585215864','core','2020-03-25 09:32:57','1','2020-03-25 09:44:24','1'),('5e7b25495765162c5bea2a9f','notifications','[]','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa0','session_secret','b212b33b59745b57938876bfaad3c960b42c991e3d28e19cebc4a4f85eef0048','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa1','theme_session_secret','57e02e3bc6ffff9c2671d30944ffe575aff9b277705e54d8c4e4f39cdd0c6a22c2c7','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa2','ghost_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBAMWrnH5fsDPbUHwaWCa9s4h85MUcCDBTLBS53Q5Z7NSLcwQVWwreLAcxYzZqSa3S\nQNfm0ZG12coIhJrzN4dtBY80JXkmZYq4rMVAf7Y6cn/2AODcW65p5Qfbci+jHT48vdb/5JQq\nlFd2K5jIwTp8mjqYHJJcSjyABYg6Wfu/LeshAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa3','ghost_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDFq5x+X7Az21B8GlgmvbOIfOTFHAgwUywUud0OWezUi3MEFVsK3iwHMWM2\nakmt0kDX5tGRtdnKCISa8zeHbQWPNCV5JmWKuKzFQH+2OnJ/9gDg3FuuaeUH23Ivox0+PL3W\n/+SUKpRXdiuYyME6fJo6mBySXEo8gAWIOln7vy3rIQIDAQABAoGBAI/py3vuari2ebiA7aD3\nCBjc5SnkqMmWJEfKsfha3CQ6irh0W95jtqZd/J+HbrEQnIkT0YxGW5PN881kOg9s/lfmf/CG\n731dBlE5H5chMVJs0WUXRa9ENmZBRUKboiDP6vtdp1DFZKfV9DgivCER9ucKlZSdqPkF89Si\nuSjIyyphAkEA6usptlCyNzg1R5XOP7NjRcU1asMBlAEuhGxIYch9goylqqKBY92Yy1kAWG/h\np/sblwgcS+N5aICXGNTnbtWB9QJBANdovHIAirS/01TRI3n6FCrlRHKk0b0VKhFqjpraP/h2\nhCi+cFJi7qP56XMd9YzuOMKq2tmXebCIetgy3/WhDP0CQF2kWABAsomocjSS1qA11cCeF+jy\nytJAllZbA49W6BD+F5upI4K3doy4cZbPIlhflGPj68OkbWTmvVQ8qfRYT3ECQQCS6jIspsXz\nhSmDnahOlwuOPhQzBMqv5XFts3lTkCs1MM/uYgSFjEgqulZIV1SULB22V4UwBqnOhycRsZEi\nHBeZAkBCpZQuWvutDdY7YPJSGg8d9cpyYWOtJeVgFQRpGyCWh5/oEkRgm+cWGvSfbmyhEtoi\ndONKIU0ksEoIwZiVt0ax\n-----END RSA PRIVATE KEY-----\n','core','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa4','title','News','blog','2020-03-25 09:32:57','1','2020-03-25 09:44:58','1'),('5e7b25495765162c5bea2aa5','description','Site in LliureX to post news, photos, videos...','blog','2020-03-25 09:32:57','1','2020-03-25 09:44:58','1'),('5e7b25495765162c5bea2aa6','logo','/news/content/images/2020/03/news-logo.svg','blog','2020-03-25 09:32:57','1','2020-04-01 11:35:25','1'),('5e7b25495765162c5bea2aa7','cover_image','/news/content/images/2020/03/news-cover.svg','blog','2020-03-25 09:32:57','1','2020-03-25 10:19:32','1'),('5e7b25495765162c5bea2aa8','icon',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aa9','brand',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1'),('5e7b25495765162c5bea2aaa','default_locale','es','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aab','active_timezone','Europe/Paris','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aac','force_i18n','true','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aad','permalinks','/:slug/','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aae','amp','true','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aaf','ghost_head',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab0','ghost_foot',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab1','facebook','ghost','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab2','twitter','@tryghost','blog','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1'),('5e7b25495765162c5bea2ab3','labs','{}','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab4','navigation','[{\"label\":\"Log In\",\"url\":\"/ghost/\"}]','blog','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1'),('5e7b25495765162c5bea2ab5','secondary_navigation','[]','blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab6','slack','[]','blog','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1'),('5e7b25495765162c5bea2ab7','unsplash','{\"isActive\":true}','blog','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1'),('5e7b25495765162c5bea2ab8','meta_title',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ab9','meta_description',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aba','og_image',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2abb','og_title',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2abc','og_description',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2abd','twitter_image',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2abe','twitter_title',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2abf','twitter_description',NULL,'blog','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac0','active_theme','lliurex-theme','theme','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac1','is_private','false','private','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac2','password',NULL,'private','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac3','public_hash','da38658ce209cf39f5d49457e4039b','private','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac4','members_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBAL1g8kj11zEgtCAerprsmZ5UaKuyFpOn+LJo1jvYZ1avvwhPWasWAm9zWl8upC60\nk4ILsEIs6nvd+ZI0PeeLC4kRaXCsDWggiZXofJ1xgz16w+GM68PIiIpM9tk3NvjWvGojcSQm\n+UeVyq625M8RMcKceVFiHgZfA0sn/y3pWjRDAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac5','members_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICXgIBAAKBgQC9YPJI9dcxILQgHq6a7JmeVGirshaTp/iyaNY72GdWr78IT1mrFgJvc1pf\nLqQutJOCC7BCLOp73fmSND3niwuJEWlwrA1oIImV6HydcYM9esPhjOvDyIiKTPbZNzb41rxq\nI3EkJvlHlcqutuTPETHCnHlRYh4GXwNLJ/8t6Vo0QwIDAQABAoGAOU9yYwQK6HImMKY4XugF\nITYYKwWM8YheqdcyJhA6TbCH1kL1NuJFQGcfTTi3NO8uyKcy4wPmvi+RzF4E8eJRTdZDdSJH\nZVKkLa+cGYXFnW8woqmlHvn8N6Zp0fROYB6Dy/IRhlU0GYz+MHAzziqzS1+h7bxJCTLzPj/n\n6zn3rZkCQQD7nYrtAUj4qzOi/i6bOG4PrZ7f2o+a3BCfre0SGNRdC7rSd1fdpsg2O/f6V5b3\nHWZ0YNIsCApOaL53nq7bX95lAkEAwK3D+6EvljyUo+4SFVudDf7B3Z28V1m3H2jMxwdXg54K\nQNxc8omki+YokLAXWSqz0HX7tDyPSoqAq37hJ7rphwJBAK5WlWjsSARMk0WvOtm/+rqQQRG3\n3WKeckJBf47Xd2VU+EhV+qKQqg6x9HsX73kffNrMLzPlCkcT2k0FvQAxZ+UCQQCXs3g9kt/T\nqqjhFJ0aQcI69ZyPrxRNte4vBaVNAqPNlc2+2YE42FQ8bZ78pBgN9UgT1gCyHIg5CSlbXQ9K\n56fbAkEAwOnmWCfemPQY18BnOoQzjYXlwv3ZWzCUU1A5I3c0xt2r3WEDhoale2QLiTAxgFsB\nET9/QHvWjzau7ATJPQpbvg==\n-----END RSA PRIVATE KEY-----\n','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac6','members_session_secret','dc1ef8c3e21f88591cceb060fea57ed6148277466691cb5028fc32d34fe8b874','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac7','members_email_auth_secret','f1725b37a5fe5f912cd6d613cac5251eae3b2ce6479d0594856470a2fbb0df507d3125d0020db1ab359cc6fb06daa6dc146c4acfccdefba3355a21794320027e','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac8','default_content_visibility','public','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2ac9','members_subscription_settings','{\"fromAddress\":\"noreply\",\"allowSelfSignup\":true,\"paymentProcessors\":[{\"adapter\":\"stripe\",\"config\":{\"secret_token\":\"\",\"public_token\":\"\",\"product\":{\"name\":\"Ghost Subscription\"},\"plans\":[{\"name\":\"Monthly\",\"currency\":\"usd\",\"interval\":\"month\",\"amount\":\"\"},{\"name\":\"Yearly\",\"currency\":\"usd\",\"interval\":\"year\",\"amount\":\"\"}]}}]}','members','2020-03-25 09:32:57','1','2020-03-25 09:32:57','1'),('5e7b25495765162c5bea2aca','bulk_email_settings','{\"apiKey\":\"\",\"domain\":\"\",\"baseUrl\":\"\",\"provider\":\"mailgun\"}','bulk_email','2020-03-25 09:32:57','1','2020-03-25 10:04:54','1');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text,
  `feature_image` varchar(2000) DEFAULT NULL,
  `parent_id` varchar(191) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES ('5e7b25465765162c5bea2966','Getting Started','getting-started',NULL,NULL,NULL,'public',NULL,NULL,'2020-03-25 09:32:54','1','2020-03-25 09:32:54','1');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(191) NOT NULL,
  `profile_image` varchar(2000) DEFAULT NULL,
  `cover_image` varchar(2000) DEFAULT NULL,
  `bio` text,
  `website` varchar(2000) DEFAULT NULL,
  `location` text,
  `facebook` varchar(2000) DEFAULT NULL,
  `twitter` varchar(2000) DEFAULT NULL,
  `accessibility` text,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `tour` text,
  `last_seen` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_slug_unique` (`slug`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('1','{{ ADMIN_USER }}','{{ ADMIN_USER }}','{{ ADMIN_PWD }}','{{ ADMIN_EMAIL }}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'active',NULL,'public',NULL,NULL,'[\"getting-started\"]','2020-03-25 10:59:07','2020-03-25 09:32:55','1','2020-03-25 10:59:07','1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhooks`
--

DROP TABLE IF EXISTS `webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhooks` (
  `id` varchar(24) NOT NULL,
  `event` varchar(50) NOT NULL,
  `target_url` varchar(2000) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `secret` varchar(191) DEFAULT NULL,
  `api_version` varchar(50) NOT NULL DEFAULT 'v2',
  `integration_id` varchar(24) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'available',
  `last_triggered_at` datetime DEFAULT NULL,
  `last_triggered_status` varchar(50) DEFAULT NULL,
  `last_triggered_error` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhooks`
--

LOCK TABLES `webhooks` WRITE;
/*!40000 ALTER TABLE `webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhooks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-25 12:01:55
