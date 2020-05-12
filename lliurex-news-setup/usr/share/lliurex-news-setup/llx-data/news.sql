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
INSERT INTO `api_keys` VALUES ('5eba560ec0b8bb7cdd6c05c6','admin','29fd58e528c72b60ab5e8775a8b2d2246b480b4e6cfcd248363422663e10ad06','5eba560dc0b8bb7cdd6c0569','5eba560ec0b8bb7cdd6c05c5',NULL,NULL,'2020-05-12 07:53:50','1','2020-05-12 07:53:50','1'),('5eba560ec0b8bb7cdd6c05c8','admin','7f23180600115b0adf9d6722fc61f131b00d558378538f4b1fad84aa56abee43','5eba560dc0b8bb7cdd6c056a','5eba560ec0b8bb7cdd6c05c7',NULL,NULL,'2020-05-12 07:53:50','1','2020-05-12 07:53:50','1'),('5eba560ec0b8bb7cdd6c05ca','admin','e690b3e402ced7bb7f711846c4701f5fa8ef99e2be34b27a2f80f8ab9e950def','5eba560dc0b8bb7cdd6c056b','5eba560ec0b8bb7cdd6c05c9',NULL,NULL,'2020-05-12 07:53:50','1','2020-05-12 07:53:50','1');

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
INSERT INTO `integrations` VALUES ('5eba560ec0b8bb7cdd6c05c5','builtin','Zapier','zapier',NULL,'Built-in Zapier integration','2020-05-12 07:53:50','1','2020-05-12 07:53:50','1'),('5eba560ec0b8bb7cdd6c05c7','internal','Ghost Backup','ghost-backup',NULL,'Internal DB Backup integration','2020-05-12 07:53:50','1','2020-05-12 07:53:50','1'),('5eba560ec0b8bb7cdd6c05c9','internal','Ghost Scheduler','ghost-scheduler',NULL,'Internal Scheduler integration','2020-05-12 07:53:50','1','2020-05-12 07:53:50','1');
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
INSERT INTO `migrations` VALUES (1,'1-create-tables.js','init','3.14'),(2,'2-create-fixtures.js','init','3.14'),(3,'1-post-excerpt.js','1.3','3.14'),(4,'1-codeinjection-post.js','1.4','3.14'),(5,'1-og-twitter-post.js','1.5','3.14'),(6,'1-add-backup-client.js','1.7','3.14'),(7,'1-add-permissions-redirect.js','1.9','3.14'),(8,'1-custom-template-post.js','1.13','3.14'),(9,'2-theme-permissions.js','1.13','3.14'),(10,'1-add-webhooks-table.js','1.18','3.14'),(11,'1-webhook-permissions.js','1.19','3.14'),(12,'1-remove-settings-keys.js','1.20','3.14'),(13,'1-add-contributor-role.js','1.21','3.14'),(14,'1-multiple-authors-DDL.js','1.22','3.14'),(15,'1-multiple-authors-DML.js','1.22','3.14'),(16,'1-update-koenig-beta-html.js','1.25','3.14'),(17,'2-demo-post.js','1.25','3.14'),(18,'1-rename-amp-column.js','2.0','3.14'),(19,'2-update-posts.js','2.0','3.14'),(20,'3-remove-koenig-labs.js','2.0','3.14'),(21,'4-permalink-setting.js','2.0','3.14'),(22,'5-remove-demo-post.js','2.0','3.14'),(23,'6-replace-fixture-posts.js','2.0','3.14'),(24,'1-add-sessions-table.js','2.2','3.14'),(25,'2-add-integrations-and-api-key-tables.js','2.2','3.14'),(26,'3-insert-admin-integration-role.js','2.2','3.14'),(27,'4-insert-integration-and-api-key-permissions.js','2.2','3.14'),(28,'5-add-mobiledoc-revisions-table.js','2.2','3.14'),(29,'1-add-webhook-columns.js','2.3','3.14'),(30,'2-add-webhook-edit-permission.js','2.3','3.14'),(31,'1-add-webhook-permission-roles.js','2.6','3.14'),(32,'1-add-members-table.js','2.8','3.14'),(33,'1-remove-empty-strings.js','2.13','3.14'),(34,'1-add-actions-table.js','2.14','3.14'),(35,'2-add-actions-permissions.js','2.14','3.14'),(36,'1-add-type-column-to-integrations.js','2.15','3.14'),(37,'2-insert-zapier-integration.js','2.15','3.14'),(38,'1-add-members-perrmissions.js','2.16','3.14'),(39,'1-normalize-settings.js','2.17','3.14'),(40,'2-posts-add-canonical-url.js','2.17','3.14'),(41,'1-restore-settings-from-backup.js','2.18','3.14'),(42,'1-update-editor-permissions.js','2.21','3.14'),(43,'1-add-member-permissions-to-roles.js','2.22','3.14'),(44,'1-insert-ghost-db-backup-role.js','2.27','3.14'),(45,'2-insert-db-backup-integration.js','2.27','3.14'),(46,'3-add-subdirectory-to-relative-canonical-urls.js','2.27','3.14'),(47,'1-add-db-backup-content-permission.js','2.28','3.14'),(48,'2-add-db-backup-content-permission-to-roles.js','2.28','3.14'),(49,'3-insert-ghost-scheduler-role.js','2.28','3.14'),(50,'4-insert-scheduler-integration.js','2.28','3.14'),(51,'5-add-scheduler-permission-to-roles.js','2.28','3.14'),(52,'6-add-type-column.js','2.28','3.14'),(53,'7-populate-type-column.js','2.28','3.14'),(54,'8-remove-page-column.js','2.28','3.14'),(55,'1-add-post-page-column.js','2.29','3.14'),(56,'2-populate-post-page-column.js','2.29','3.14'),(57,'3-remove-page-type-column.js','2.29','3.14'),(58,'1-remove-name-and-password-from-members-table.js','2.31','3.14'),(59,'01-add-members-stripe-customers-table.js','2.32','3.14'),(60,'02-add-name-to-members-table.js','2.32','3.14'),(61,'01-correct-members-stripe-customers-table.js','2.33','3.14'),(62,'01-add-stripe-customers-subscriptions-table.js','2.34','3.14'),(63,'02-add-email-to-members-stripe-customers-table.js','2.34','3.14'),(64,'03-add-name-to-members-stripe-customers-table.js','2.34','3.14'),(65,'01-add-note-to-members-table.js','2.35','3.14'),(66,'01-add-self-signup-and-from address-to-members-settings.js','2.37','3.14'),(67,'01-remove-user-ghost-auth-columns.js','3.0','3.14'),(68,'02-drop-token-auth-tables.js','3.0','3.14'),(69,'03-drop-client-auth-tables.js','3.0','3.14'),(70,'04-add-posts-meta-table.js','3.0','3.14'),(71,'05-populate-posts-meta-table.js','3.0','3.14'),(72,'06-remove-posts-meta-columns.js','3.0','3.14'),(73,'07-add-posts-type-column.js','3.0','3.14'),(74,'08-populate-posts-type-column.js','3.0','3.14'),(75,'09-remove-posts-page-column.js','3.0','3.14'),(76,'10-remove-empty-strings.js','3.0','3.14'),(77,'11-update-posts-html.js','3.0','3.14'),(78,'12-populate-members-table-from-subscribers.js','3.0','3.14'),(79,'13-drop-subscribers-table.js','3.0','3.14'),(80,'14-remove-subscribers-flag.js','3.0','3.14'),(81,'01-add-send-email-when-published-to-posts.js','3.1','3.14'),(82,'02-add-email-subject-to-posts-meta.js','3.1','3.14'),(83,'03-add-email-preview-permissions.js','3.1','3.14'),(84,'04-add-subscribed-flag-to-members.js','3.1','3.14'),(85,'05-add-emails-table.js','3.1','3.14'),(86,'06-add-email-permissions.js','3.1','3.14'),(87,'07-add-uuid-field-to-members.js','3.1','3.14'),(88,'08-add-uuid-values-to-members.js','3.1','3.14'),(89,'09-add-further-email-permissions.js','3.1','3.14'),(90,'10-add-email-error-data-column.js','3.1','3.14'),(91,'01-add-cancel-at-period-end-to-subscriptions.js','3.2','3.14'),(92,'1-add-labels-table.js','3.6','3.14'),(93,'2-add-members-labels-table.js','3.6','3.14'),(94,'3-add-labels-permissions.js','3.6','3.14'),(95,'01-fix-incorrect-member-labels-foreign-keys.js','3.7','3.14'),(96,'01-add-geolocation-to-members.js','3.8','3.14'),(97,'01-add-member-sigin-url-permissions.js','3.9','3.14'),(98,'01-remove-broken-complimentary-plan-from-members-settings.js','3.11','3.14'),(99,'01-add-identity-permission.js','3.12','3.14'),(100,'02-remove-legacy-is-paid-flag-from-settings.js','3.12','3.14');

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
INSERT INTO `migrations_lock` VALUES ('km01',0,'2020-05-12 07:53:40','2020-05-12 07:53:51');

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
INSERT INTO `permissions` VALUES ('5eba560dc0b8bb7cdd6c056c','Export database','db','exportContent',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c056d','Import database','db','importContent',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c056e','Delete all content','db','deleteAllContent',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c056f','Send mail','mail','send',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0570','Browse notifications','notification','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0571','Add notifications','notification','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0572','Delete notifications','notification','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0573','Browse posts','post','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0574','Read posts','post','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0575','Edit posts','post','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0576','Add posts','post','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0577','Delete posts','post','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0578','Browse settings','setting','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0579','Read settings','setting','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057a','Edit settings','setting','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057b','Generate slugs','slug','generate',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057c','Browse tags','tag','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057d','Read tags','tag','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057e','Edit tags','tag','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c057f','Add tags','tag','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0580','Delete tags','tag','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0581','Browse themes','theme','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0582','Edit themes','theme','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0583','Activate themes','theme','activate',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0584','Upload themes','theme','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0585','Download themes','theme','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0586','Delete themes','theme','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0587','Browse users','user','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0588','Read users','user','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0589','Edit users','user','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058a','Add users','user','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058b','Delete users','user','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058c','Assign a role','role','assign',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058d','Browse roles','role','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058e','Browse invites','invite','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c058f','Read invites','invite','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0590','Edit invites','invite','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0591','Add invites','invite','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0592','Delete invites','invite','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0593','Download redirects','redirect','download',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0594','Upload redirects','redirect','upload',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0595','Add webhooks','webhook','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0596','Edit webhooks','webhook','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0597','Delete webhooks','webhook','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0598','Browse integrations','integration','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0599','Read integrations','integration','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059a','Edit integrations','integration','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059b','Add integrations','integration','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059c','Delete integrations','integration','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059d','Browse API keys','api_key','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059e','Read API keys','api_key','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c059f','Edit API keys','api_key','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a0','Add API keys','api_key','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a1','Delete API keys','api_key','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a2','Browse Actions','action','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a3','Browse Members','member','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a4','Read Members','member','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a5','Edit Members','member','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a6','Add Members','member','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a7','Delete Members','member','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a8','Publish posts','post','publish',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05a9','Backup database','db','backupContent',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05aa','Email preview','email_preview','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05ab','Send test email','email_preview','sendTestEmail',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05ac','Browse emails','email','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05ad','Read emails','email','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05ae','Retry emails','email','retry',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05af','Browse labels','label','browse',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b0','Read labels','label','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b1','Edit labels','label','edit',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b2','Add labels','label','add',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b3','Delete labels','label','destroy',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b4','Read member signin urls','member_signin_url','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c05b5','Read identities','identity','read',NULL,'2020-05-12 07:53:49','1','2020-05-12 07:53:49','1');

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
INSERT INTO `permissions_roles` VALUES ('5eba560ec0b8bb7cdd6c05cb','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c056c'),('5eba560ec0b8bb7cdd6c05cc','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c056d'),('5eba560ec0b8bb7cdd6c05cd','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c056e'),('5eba560ec0b8bb7cdd6c05ce','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a9'),('5eba560ec0b8bb7cdd6c05cf','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c056f'),('5eba560ec0b8bb7cdd6c05d0','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0570'),('5eba560ec0b8bb7cdd6c05d1','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0571'),('5eba560ec0b8bb7cdd6c05d2','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0572'),('5eba560ec0b8bb7cdd6c05d3','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0573'),('5eba560ec0b8bb7cdd6c05d4','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0574'),('5eba560ec0b8bb7cdd6c05d5','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0575'),('5eba560ec0b8bb7cdd6c05d6','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0576'),('5eba560ec0b8bb7cdd6c05d7','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0577'),('5eba560ec0b8bb7cdd6c05d8','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a8'),('5eba560ec0b8bb7cdd6c05d9','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0578'),('5eba560ec0b8bb7cdd6c05da','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0579'),('5eba560ec0b8bb7cdd6c05db','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057a'),('5eba560ec0b8bb7cdd6c05dc','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057b'),('5eba560ec0b8bb7cdd6c05dd','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057c'),('5eba560ec0b8bb7cdd6c05de','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057d'),('5eba560ec0b8bb7cdd6c05df','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057e'),('5eba560ec0b8bb7cdd6c05e0','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c057f'),('5eba560ec0b8bb7cdd6c05e1','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0580'),('5eba560ec0b8bb7cdd6c05e2','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0581'),('5eba560ec0b8bb7cdd6c05e3','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0582'),('5eba560ec0b8bb7cdd6c05e4','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0583'),('5eba560ec0b8bb7cdd6c05e5','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0584'),('5eba560ec0b8bb7cdd6c05e6','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0585'),('5eba560ec0b8bb7cdd6c05e7','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0586'),('5eba560ec0b8bb7cdd6c05e8','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0587'),('5eba560ec0b8bb7cdd6c05e9','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0588'),('5eba560ec0b8bb7cdd6c05ea','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0589'),('5eba560ec0b8bb7cdd6c05eb','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058a'),('5eba560ec0b8bb7cdd6c05ec','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058b'),('5eba560ec0b8bb7cdd6c05ed','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058c'),('5eba560ec0b8bb7cdd6c05ee','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058d'),('5eba560ec0b8bb7cdd6c05ef','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058e'),('5eba560ec0b8bb7cdd6c05f0','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c058f'),('5eba560ec0b8bb7cdd6c05f1','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0590'),('5eba560ec0b8bb7cdd6c05f2','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0591'),('5eba560ec0b8bb7cdd6c05f3','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0592'),('5eba560ec0b8bb7cdd6c05f4','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0593'),('5eba560ec0b8bb7cdd6c05f5','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0594'),('5eba560ec0b8bb7cdd6c05f6','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0595'),('5eba560ec0b8bb7cdd6c05f7','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0596'),('5eba560ec0b8bb7cdd6c05f8','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0597'),('5eba560ec0b8bb7cdd6c05f9','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0598'),('5eba560ec0b8bb7cdd6c05fa','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c0599'),('5eba560ec0b8bb7cdd6c05fb','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059a'),('5eba560ec0b8bb7cdd6c05fc','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059b'),('5eba560ec0b8bb7cdd6c05fd','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059c'),('5eba560ec0b8bb7cdd6c05fe','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059d'),('5eba560ec0b8bb7cdd6c05ff','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059e'),('5eba560ec0b8bb7cdd6c0600','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c059f'),('5eba560ec0b8bb7cdd6c0601','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a0'),('5eba560ec0b8bb7cdd6c0602','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a1'),('5eba560ec0b8bb7cdd6c0603','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a2'),('5eba560ec0b8bb7cdd6c0604','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a3'),('5eba560ec0b8bb7cdd6c0605','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a4'),('5eba560ec0b8bb7cdd6c0606','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a5'),('5eba560ec0b8bb7cdd6c0607','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a6'),('5eba560ec0b8bb7cdd6c0608','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05a7'),('5eba560ec0b8bb7cdd6c0609','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05af'),('5eba560ec0b8bb7cdd6c060a','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05b0'),('5eba560ec0b8bb7cdd6c060b','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05b1'),('5eba560ec0b8bb7cdd6c060c','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05b2'),('5eba560ec0b8bb7cdd6c060d','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05b3'),('5eba560ec0b8bb7cdd6c060e','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05aa'),('5eba560ec0b8bb7cdd6c060f','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05ab'),('5eba560ec0b8bb7cdd6c0610','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05ac'),('5eba560ec0b8bb7cdd6c0611','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05ad'),('5eba560ec0b8bb7cdd6c0612','5eba560dc0b8bb7cdd6c0564','5eba560dc0b8bb7cdd6c05ae'),('5eba560ec0b8bb7cdd6c0613','5eba560dc0b8bb7cdd6c056a','5eba560dc0b8bb7cdd6c056c'),('5eba560ec0b8bb7cdd6c0614','5eba560dc0b8bb7cdd6c056a','5eba560dc0b8bb7cdd6c056d'),('5eba560ec0b8bb7cdd6c0615','5eba560dc0b8bb7cdd6c056a','5eba560dc0b8bb7cdd6c056e'),('5eba560ec0b8bb7cdd6c0616','5eba560dc0b8bb7cdd6c056a','5eba560dc0b8bb7cdd6c05a9'),('5eba560ec0b8bb7cdd6c0617','5eba560dc0b8bb7cdd6c056b','5eba560dc0b8bb7cdd6c05a8'),('5eba560ec0b8bb7cdd6c0618','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c056f'),('5eba560ec0b8bb7cdd6c0619','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0570'),('5eba560ec0b8bb7cdd6c061a','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0571'),('5eba560ec0b8bb7cdd6c061b','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0572'),('5eba560ec0b8bb7cdd6c061c','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0573'),('5eba560ec0b8bb7cdd6c061d','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0574'),('5eba560ec0b8bb7cdd6c061e','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0575'),('5eba560ec0b8bb7cdd6c061f','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0576'),('5eba560ec0b8bb7cdd6c0620','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0577'),('5eba560ec0b8bb7cdd6c0621','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a8'),('5eba560ec0b8bb7cdd6c0622','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0578'),('5eba560ec0b8bb7cdd6c0623','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0579'),('5eba560ec0b8bb7cdd6c0624','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057a'),('5eba560ec0b8bb7cdd6c0625','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057b'),('5eba560ec0b8bb7cdd6c0626','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057c'),('5eba560ec0b8bb7cdd6c0627','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057d'),('5eba560ec0b8bb7cdd6c0628','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057e'),('5eba560ec0b8bb7cdd6c0629','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c057f'),('5eba560ec0b8bb7cdd6c062a','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0580'),('5eba560ec0b8bb7cdd6c062b','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0581'),('5eba560ec0b8bb7cdd6c062c','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0582'),('5eba560ec0b8bb7cdd6c062d','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0583'),('5eba560ec0b8bb7cdd6c062e','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0584'),('5eba560ec0b8bb7cdd6c062f','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0585'),('5eba560ec0b8bb7cdd6c0630','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0586'),('5eba560ec0b8bb7cdd6c0631','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0587'),('5eba560ec0b8bb7cdd6c0632','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0588'),('5eba560ec0b8bb7cdd6c0633','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0589'),('5eba560ec0b8bb7cdd6c0634','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058a'),('5eba560ec0b8bb7cdd6c0635','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058b'),('5eba560ec0b8bb7cdd6c0636','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058c'),('5eba560ec0b8bb7cdd6c0637','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058d'),('5eba560ec0b8bb7cdd6c0638','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058e'),('5eba560ec0b8bb7cdd6c0639','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c058f'),('5eba560ec0b8bb7cdd6c063a','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0590'),('5eba560ec0b8bb7cdd6c063b','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0591'),('5eba560ec0b8bb7cdd6c063c','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0592'),('5eba560ec0b8bb7cdd6c063d','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0593'),('5eba560ec0b8bb7cdd6c063e','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0594'),('5eba560ec0b8bb7cdd6c063f','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0595'),('5eba560ec0b8bb7cdd6c0640','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0596'),('5eba560ec0b8bb7cdd6c0641','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c0597'),('5eba560ec0b8bb7cdd6c0642','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a2'),('5eba560ec0b8bb7cdd6c0643','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a3'),('5eba560ec0b8bb7cdd6c0644','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a4'),('5eba560ec0b8bb7cdd6c0645','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a5'),('5eba560ec0b8bb7cdd6c0646','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a6'),('5eba560ec0b8bb7cdd6c0647','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05a7'),('5eba560ec0b8bb7cdd6c0648','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05af'),('5eba560ec0b8bb7cdd6c0649','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05b0'),('5eba560ec0b8bb7cdd6c064a','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05b1'),('5eba560ec0b8bb7cdd6c064b','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05b2'),('5eba560ec0b8bb7cdd6c064c','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05b3'),('5eba560ec0b8bb7cdd6c064d','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05aa'),('5eba560ec0b8bb7cdd6c064e','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05ab'),('5eba560ec0b8bb7cdd6c064f','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05ac'),('5eba560ec0b8bb7cdd6c0650','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05ad'),('5eba560ec0b8bb7cdd6c0651','5eba560dc0b8bb7cdd6c0569','5eba560dc0b8bb7cdd6c05ae'),('5eba560ec0b8bb7cdd6c0652','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0570'),('5eba560ec0b8bb7cdd6c0653','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0571'),('5eba560ec0b8bb7cdd6c0654','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0572'),('5eba560ec0b8bb7cdd6c0655','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0573'),('5eba560ec0b8bb7cdd6c0656','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0574'),('5eba560ec0b8bb7cdd6c0657','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0575'),('5eba560ec0b8bb7cdd6c0658','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0576'),('5eba560ec0b8bb7cdd6c0659','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0577'),('5eba560ec0b8bb7cdd6c065a','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05a8'),('5eba560ec0b8bb7cdd6c065b','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0578'),('5eba560ec0b8bb7cdd6c065c','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0579'),('5eba560ec0b8bb7cdd6c065d','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c057b'),('5eba560ec0b8bb7cdd6c065e','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c057c'),('5eba560ec0b8bb7cdd6c065f','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c057d'),('5eba560ec0b8bb7cdd6c0660','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c057e'),('5eba560ec0b8bb7cdd6c0661','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c057f'),('5eba560ec0b8bb7cdd6c0662','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0580'),('5eba560ec0b8bb7cdd6c0663','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0587'),('5eba560ec0b8bb7cdd6c0664','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0588'),('5eba560ec0b8bb7cdd6c0665','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0589'),('5eba560ec0b8bb7cdd6c0666','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058a'),('5eba560ec0b8bb7cdd6c0667','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058b'),('5eba560ec0b8bb7cdd6c0668','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058c'),('5eba560ec0b8bb7cdd6c0669','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058d'),('5eba560ec0b8bb7cdd6c066a','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058e'),('5eba560ec0b8bb7cdd6c066b','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c058f'),('5eba560ec0b8bb7cdd6c066c','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0590'),('5eba560ec0b8bb7cdd6c066d','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0591'),('5eba560ec0b8bb7cdd6c066e','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0592'),('5eba560ec0b8bb7cdd6c066f','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c0581'),('5eba560ec0b8bb7cdd6c0670','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05aa'),('5eba560ec0b8bb7cdd6c0671','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05ab'),('5eba560ec0b8bb7cdd6c0672','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05ac'),('5eba560ec0b8bb7cdd6c0673','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05ad'),('5eba560ec0b8bb7cdd6c0674','5eba560dc0b8bb7cdd6c0565','5eba560dc0b8bb7cdd6c05ae'),('5eba560ec0b8bb7cdd6c0675','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0573'),('5eba560ec0b8bb7cdd6c0676','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0574'),('5eba560ec0b8bb7cdd6c0677','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0576'),('5eba560ec0b8bb7cdd6c0678','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0578'),('5eba560ec0b8bb7cdd6c0679','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0579'),('5eba560ec0b8bb7cdd6c067a','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c057b'),('5eba560ec0b8bb7cdd6c067b','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c057c'),('5eba560ec0b8bb7cdd6c067c','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c057d'),('5eba560ec0b8bb7cdd6c067d','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c057f'),('5eba560ec0b8bb7cdd6c067e','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0587'),('5eba560ec0b8bb7cdd6c067f','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0588'),('5eba560ec0b8bb7cdd6c0680','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c058d'),('5eba560ec0b8bb7cdd6c0681','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c0581'),('5eba560ec0b8bb7cdd6c0682','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c05aa'),('5eba560ec0b8bb7cdd6c0683','5eba560dc0b8bb7cdd6c0566','5eba560dc0b8bb7cdd6c05ad'),('5eba560ec0b8bb7cdd6c0684','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0573'),('5eba560ec0b8bb7cdd6c0685','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0574'),('5eba560ec0b8bb7cdd6c0686','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0576'),('5eba560ec0b8bb7cdd6c0687','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0578'),('5eba560ec0b8bb7cdd6c0688','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0579'),('5eba560ec0b8bb7cdd6c0689','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c057b'),('5eba560ec0b8bb7cdd6c068a','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c057c'),('5eba560ec0b8bb7cdd6c068b','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c057d'),('5eba560ec0b8bb7cdd6c068c','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0587'),('5eba560ec0b8bb7cdd6c068d','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0588'),('5eba560ec0b8bb7cdd6c068e','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c058d'),('5eba560ec0b8bb7cdd6c068f','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c0581'),('5eba560ec0b8bb7cdd6c0690','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c05aa'),('5eba560ec0b8bb7cdd6c0691','5eba560dc0b8bb7cdd6c0567','5eba560dc0b8bb7cdd6c05ad');

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
INSERT INTO `roles` VALUES ('5eba560dc0b8bb7cdd6c0564','Administrator','Administrators','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0565','Editor','Editors','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0566','Author','Authors','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0567','Contributor','Contributors','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0568','Owner','Blog Owner','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c0569','Admin Integration','External Apps','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c056a','DB Backup Integration','Internal DB Backup Client','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1'),('5eba560dc0b8bb7cdd6c056b','Scheduler Integration','Internal Scheduler Client','2020-05-12 07:53:49','1','2020-05-12 07:53:49','1');

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
INSERT INTO `roles_users` VALUES ('5eba560ec0b8bb7cdd6c0699','5eba560dc0b8bb7cdd6c0568','1');

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
INSERT INTO `settings` VALUES ('5eba5610c0b8bb7cdd6c069a','db_hash','501232df-d365-4b38-962c-4757c9e273d1','core','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c069b','next_update_check','1589357100','core','2020-05-12 07:53:52','1','2020-05-12 08:04:59','1'),('5eba5610c0b8bb7cdd6c069c','notifications','[{\"dismissible\":true,\"location\":\"bottom\",\"status\":\"alert\",\"id\":\"a6587390-912a-11ea-ab29-e3714305e054\",\"custom\":false,\"createdAt\":\"2020-05-08T11:51:35.000Z\",\"type\":\"info\",\"top\":false,\"message\":\"Ghost <a href=\\\"https://github.com/TryGhost/Ghost/releases\\\">3.15.3</a> has been released, <a href=\\\"https://ghost.org/update/?v=3.14.0\\\">click here</a> to upgrade.\",\"seen\":false,\"addedAt\":\"2020-05-12T08:04:59.827Z\"}]','core','2020-05-12 07:53:52','1','2020-05-12 08:04:59','1'),('5eba5610c0b8bb7cdd6c069d','session_secret','014aef7da9b643bac4c8bfc02305c55113297de004e782eae1c3f69fe92c8cd5','core','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c069e','theme_session_secret','838ec84189a16e3b927da1a41a8a961c40863ea7557adac77e88470233b0c86c','core','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c069f','ghost_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBAJAU/cZdieFz/zALaTqWuc9Mbk6DBEkR8ellVOtlcILRMvbCyb9q4L0LRppDfUk9\n+WaMg+rEakXfx70xeKnF+/riNQ/RAlT0jhnIvu8m+/f7EC7KTnRvVM/ZUGwWVkedyiBhW4p5\nTEHq8DJZ3TiCd7PyBebgY7N6Bkgutf9w90mJAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','core','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a0','ghost_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCQFP3GXYnhc/8wC2k6lrnPTG5OgwRJEfHpZVTrZXCC0TL2wsm/auC9C0aa\nQ31JPflmjIPqxGpF38e9MXipxfv64jUP0QJU9I4ZyL7vJvv3+xAuyk50b1TP2VBsFlZHncog\nYVuKeUxB6vAyWd04gnez8gXm4GOzegZILrX/cPdJiQIDAQABAoGAUP37yc46+6khAfjoJi8k\nNAta1nd/qTOVMQXtPoW/QUonw96rWhbSTnJQNddKTimwUJ0capQOyUiKFygAFC9e/UZo6GBD\nXI2P+1ER/xn+EqVse+5BRtfkDF7e7CSjrEzDgr8UriHi96ZM7hDndLFlx0QHH7oM0X/q7oF2\nvG8nCaECQQDe6aerW+qnFrIArhEkMnvL+QAFfPWuQ805dvEcNL+iuYSQyJwnvBY/d+Mh87Fl\ncyaBAPdPYdx3cHdUxD6oubKrAkEApXfjfzzsmm3y3WBOgDi/Xr0dWX116C7VWjnMyItfD+nA\n4F2xgt2LKuj2rQFy7Xg7/K1MEB0qllE6ABl1zbhUmwJAL9ws8r7Gb9+QklLNPV9VcyLgHU2K\nFkNacccW135/0rlQPCHGXUWl5TShYK3I3cZOcw45CyMwybgs9tc3uNQ+BwJAUbXZXtzMDhqb\nYtyLB2B+iB8lXirJTcXKz8pZKPNCF06cU2+RGAmlDqSKI7bidQf5v3YoaJCulho4ZRItjVAo\nXwJBAApzzVAvIyG8wrDlrkHt1yjo7OLYJtcyrlU8gP2/6XFx8RYD8DVAwEBTlkh4PxTPDr/F\nJDI7TAc/sehCzSWICfM=\n-----END RSA PRIVATE KEY-----\n','core','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a1','title','news','blog','2020-05-12 07:53:52','1','2020-05-12 08:05:35','1'),('5eba5610c0b8bb7cdd6c06a2','description','Site in LliureX to post news, photos, videos...','blog','2020-05-12 07:53:52','1','2020-05-12 08:05:35','1'),('5eba5610c0b8bb7cdd6c06a3','logo','/news/content/images/2020/03/news-logo.svg','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a4','cover_image','/news/content/images/2020/03/news-cover.png','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a5','icon',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a6','brand','{\"primaryColor\":\"\"}','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a7','default_locale','{{ DEFAULT_LOCALE }}','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a8','active_timezone','Europe/Paris','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06a9','force_i18n','true','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06aa','permalinks','/:slug/','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06ab','amp','true','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06ac','ghost_head',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06ad','ghost_foot',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06ae','facebook','ghost','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06af','twitter','tryghost','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b0','labs','{}','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b1','navigation','[{\"label\":\"Sign In\",\"url\":\"/ghost/\"}]','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b2','secondary_navigation','[]','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b3','slack','[{\"url\":\"\", \"username\":\"Ghost\"}]','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b4','unsplash','{\"isActive\": true}','blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b5','meta_title',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b6','meta_description',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b7','og_image',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b8','og_title',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06b9','og_description',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06ba','twitter_image',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06bb','twitter_title',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06bc','twitter_description',NULL,'blog','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06bd','active_theme','lliurex-theme','theme','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06be','is_private','false','private','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06bf','password',NULL,'private','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c0','public_hash','0d015473a97654c583f6351a5ae713','private','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c1','members_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBALg27wmtT1Jby8atN8WrAmD/rWrQW3xvTOZmp/A7dsbeoZePpO0jHdaBfljeeb/3\naDRF8hOlgoONSnGebQin32Ex//UcvT8JY623cPdyGJUIJq1fHpPuhjBPHg5xUzEow8mdUXbO\nF1QN+zoJEWdgY9ZqtPXSsoeFke/OZTvGpyFLAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c2','members_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQC4Nu8JrU9SW8vGrTfFqwJg/61q0Ft8b0zmZqfwO3bG3qGXj6TtIx3WgX5Y\n3nm/92g0RfITpYKDjUpxnm0Ip99hMf/1HL0/CWOtt3D3chiVCCatXx6T7oYwTx4OcVMxKMPJ\nnVF2zhdUDfs6CRFnYGPWarT10rKHhZHvzmU7xqchSwIDAQABAoGAdAgmCLJhhD7N3Ba/SoKs\nvOxPDziuZ3KzvWxr26WY6yrQHeccu0GjSbnHG7MGfSQZPtPP5xAZZUNZ4LcpdopG6J7sENOo\n9kHTywRa/eh1CMmK7U9k5fC/n7Mq4pNqoTn4yNuQvFOYVS4NIMBvWmpV+3XvnA8Yx48cR01h\nUErfmgECQQDvwVXe4lnWnAxr1mdjeIPj1cA2xzol0nK+rFjLLBVAIbPFc3Shsk6OvS/0z6v7\n/+3W1d8RYzWlDxJMAivWHO9tAkEAxLI4ckjGXyuRqp+1WCHxy69x9KGjE3us+fQnkdQ6PjO6\n071QiL53w7Fx+4yUVjLbAlbXQl8OKCCxMfYgu3SIlwJAWFORnxsknbu/l7rVPAAaFsWYmpWr\nBmQRgc1cqP0ElyvTXtq6DRfzeQKZuEcJxTz0EkGYfH9gM/7pbrceDzN5wQJAVT4vfEfRwJjv\nLhS80I8VbQKBzlTmiaEFm+WV6HsjKqXch7r51elFmgeisDOCbcDobSEZdOghCH7yjAZwtQyR\nzQJAXpiOx6LPv7a/InIvJGapnumuHkp2gLxI9+vvKBAGsI+rX+x0HQ98LH+N1c5Li3rNbwr6\nSOcD5uxBwOf/H5bwHQ==\n-----END RSA PRIVATE KEY-----\n','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c3','members_session_secret','bc0b771f47666dafe344f0dc246c8b8e001f65a08812155d67b5f859172dbb0b','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c4','members_email_auth_secret','b2e76012ea61486aaa883195f1f70012de2638a435dc7999adb9e1ce84609a70f5fadfbd04300838cbaaa3c80c3d0d96463c486dc2002871bae52353f38910be','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c5','default_content_visibility','public','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c6','members_subscription_settings','{\"fromAddress\":\"noreply\",\"allowSelfSignup\":true,\"paymentProcessors\":[{\"adapter\":\"stripe\",\"config\":{\"secret_token\":\"\",\"public_token\":\"\",\"product\":{\"name\":\"Ghost Subscription\"},\"plans\":[{\"name\":\"Monthly\",\"currency\":\"usd\",\"interval\":\"month\",\"amount\":\"\"},{\"name\":\"Yearly\",\"currency\":\"usd\",\"interval\":\"year\",\"amount\":\"\"}]}}]}','members','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1'),('5eba5610c0b8bb7cdd6c06c7','bulk_email_settings','{\"provider\":\"mailgun\", \"apiKey\": \"\", \"domain\": \"\", \"baseUrl\": \"\"}','bulk_email','2020-05-12 07:53:52','1','2020-05-12 07:53:52','1');

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
INSERT INTO `users` VALUES ('1','{{ ADMIN_USER }}','{{ ADMIN_USER }}','{{ ADMIN_PWD }}','{{ ADMIN_EMAIL }}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'active',NULL,'public',NULL,NULL,NULL,'2020-05-12 08:05:36','2020-05-12 07:53:49','1','2020-05-12 08:05:36','1');

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
