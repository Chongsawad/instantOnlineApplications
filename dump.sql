-- MySQL dump 10.13  Distrib 5.1.48, for apple-darwin10.3.0 (i386)
--
-- Host: localhost    Database: ioa_development
-- ------------------------------------------------------
-- Server version	5.1.48

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
-- Table structure for table `delayed_jobs`
--

DROP TABLE IF EXISTS `delayed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delayed_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) DEFAULT '0',
  `attempts` int(11) DEFAULT '0',
  `handler` text COLLATE utf8_unicode_ci,
  `last_error` text COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delayed_jobs`
--

LOCK TABLES `delayed_jobs` WRITE;
/*!40000 ALTER TABLE `delayed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `delayed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `img_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_project` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_demo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `screenshot_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `screenshot_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `screenshot_file_size` int(11) DEFAULT NULL,
  `screenshot_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'FatFreeCRM ','Ruby on Rails-based customer relationship management','/images/fatfree.jpg','~/Projects/instantOnlineApplications/applications_source/_fatfree-source/ ','2010-06-18 08:47:55','2010-08-05 20:38:23','Fat Free CRM is next generation open source CRM platform. Active development has started in November 2008; new features, enhancements, and updates appear on daily basis. ','http://www.fatfreecrm.com','http://demo.fatfreecrm.com','fatfree.jpg','image/jpeg',90480,'2010-06-23 05:39:23'),(2,'Spree ','E-commerce for Ruby on Rails','/images/spree.jpg','~/InstantSOA/_spree-source/ ','2010-06-18 08:48:47','2010-06-23 06:12:38','Spree is a full featured commerce platform written for the Ruby on Rails framework. It is designed to make programming commerce applications easier by making several assumptions about what most developers needs to get started. Spree is a production ready ','http://spreecommerce.com','http://spreecommerce.com/demo','spree.jpg','image/jpeg',41874,'2010-06-23 06:12:38'),(3,'Redmine','a flexible project management web application','/images/redmine.jpg','~/InstantSOA/_redmine-source/ ','2010-06-18 08:49:44','2010-06-23 06:10:28','Redmine is a flexible project management web application. Written using Ruby on Rails framework, it is cross-platform and cross-database.  Redmine is open source and released under the terms of the GNU General Public License v2 (GPL).','http://www.redmine.org/','http://demo.redmine.org/','redmine.jpg','image/jpeg',34639,'2010-06-23 06:10:27'),(4,'El Dorado ','A full-stack community web application written in Ruby/Rails','/images/eldorado.jpg','~/InstantSOA/_eldorado-source/ ','2010-06-18 08:50:26','2010-06-23 06:18:11','El Dorado is a full-stack community web application written in Ruby/Rails. It features a forum, event calendar, group chat, file sharing, random headers, avatars, themes, and privacy settings.','http://eldorado.heroku.com/','http://eldorado.heroku.com/','eldorado.jpg','image/jpeg',78623,'2010-06-23 06:18:11'),(5,'RadiantCMS ','Content management simplified ','/images/radiant.jpg','~/InstantSOA/_radiant-source ','2010-06-18 08:51:08','2010-06-23 06:16:34','Radiant is a no-fluff, open source content management system designed for small teams. It is similar to Textpattern or MovableType, but is a general purpose content management system (not just a blogging engine).','http://radiantcms.org','http://radiantcms.org/demo/','radiant.jpg','image/jpeg',37341,'2010-06-23 06:16:33');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20100617031144'),('20100618052209'),('20100618072156'),('20100621053944'),('20100621081213'),('20100623021622'),('20100623052035');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'asddafs',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_asddafs',NULL,'Deploying!','dfsadfs','2010-06-28 08:30:18','2010-06-28 08:30:18'),(2,'xzcv',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_xzcv',NULL,'Deploying process Incomplete!','vzcx','2010-06-28 08:35:47','2010-06-28 08:47:38'),(3,'fgfhjg',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_fgfhjg',NULL,'Deploying!','fghjfghj','2010-06-28 08:36:47','2010-06-28 08:36:47'),(4,'vzcxsadf',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_vzcxsadf',NULL,'Deploying!','xzfsd','2010-06-28 08:37:17','2010-06-28 08:37:17'),(5,'asdf',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_asdf',NULL,'Deploying!','asdf;xzcv','2010-06-28 08:48:11','2010-06-28 08:48:11'),(6,'sddsfa',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_sddsfa',NULL,'Deploying!','sdfdfssdf','2010-06-28 08:49:18','2010-06-28 08:49:18'),(7,'zxcvsadf',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_zxcvsadf',NULL,'Deploying!','sadf','2010-06-28 08:50:56','2010-06-28 08:50:56'),(8,'xqwer',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_xqwer',NULL,'Deploying!','werewr','2010-06-28 08:55:36','2010-06-28 08:55:36'),(9,'zcxvbn',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_zcxvbn',NULL,'Deploying!','DFSsdf','2010-06-28 08:57:53','2010-06-28 08:57:53'),(10,'oiyio',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_oiyio',NULL,'Deploying!','uioiy','2010-06-28 09:04:41','2010-06-28 09:04:41'),(11,'1234567',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_1234567',NULL,'Deploying!','7654321','2010-06-28 09:16:38','2010-06-28 09:16:38'),(12,'fdfsaadf33zsd3',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_fdfsaadf33zsd3',NULL,'Deploying process Incomplete!','scvzczvwersdds','2010-06-28 09:20:07','2010-06-29 10:20:17'),(13,'bnm,',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_bnm,',NULL,'Deploying process Incomplete!','adsf','2010-06-28 09:20:48','2010-06-29 10:21:53'),(14,'f8sdgdgs',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_f8sdgdgs',NULL,'Deploying process Incomplete!','iduwe','2010-06-28 09:25:25','2010-06-28 09:32:47'),(15,'awete',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_awete',NULL,'Deploying!','3142','2010-06-28 09:26:45','2010-06-28 09:26:45'),(16,'awetes4',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_awetes4',NULL,'Deploying process Incomplete!','3142sadf','2010-06-28 09:27:16','2010-06-28 09:28:05'),(17,'rlyu',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_rlyu',NULL,'Deploying process Incomplete!','yul','2010-06-28 09:28:32','2010-06-28 09:29:19'),(18,'qtg52',5,6,'/home/inice/InstantSOA/deploy_cap/inice/6_qtg52',NULL,'Online','waabwt2','2010-06-28 09:29:32','2010-06-28 09:31:45'),(19,'gdssadgadgs',1,6,'/home/inice/InstantSOA/deploy_cap/inice/6_gdssadgadgs',NULL,'Deploying process Incomplete!','dgsdsgsadg','2010-06-28 09:30:31','2010-06-28 09:32:49'),(20,'testfatfree',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_testfatfree',NULL,'Deploying process Incomplete!','asd;flkj','2010-06-29 10:20:05','2010-06-29 10:21:59'),(21,'fatfree',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_fatfree',NULL,'Deploying process Incomplete!','asdfasdfasdf','2010-06-29 10:26:14','2010-06-29 10:26:34'),(22,'fatfree_test',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_fatfree_test',NULL,'Deploying process Incomplete!','asdfasdf\r\n','2010-06-29 10:27:50','2010-06-29 11:26:31'),(23,'wetwet',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_wetwet',NULL,'Online','adfsasdf','2010-06-29 11:27:22','2010-06-29 11:30:39'),(25,'spree',2,3,'/home/inice/InstantSOA/deploy_cap/inice/3_spree',NULL,'Online','test','2010-06-29 23:34:04','2010-06-29 23:42:40'),(26,'redmine',3,3,'/home/inice/InstantSOA/deploy_cap/inice/3_redmine',NULL,'Online','testestsetsetset','2010-06-29 23:49:51','2010-06-29 23:54:02'),(27,'eldorado',4,3,'/home/inice/InstantSOA/deploy_cap/inice/3_eldorado',NULL,'Deploying process Incomplete!','as;dklafjsd;lfkajsd;flkajsd;lfkajsdk;lfjasd','2010-06-29 23:56:31','2010-06-29 23:59:04'),(28,'Eldorado',4,3,'/home/inice/InstantSOA/deploy_cap/inice/3_Eldorado',NULL,'Online','testtest','2010-06-30 04:11:49','2010-06-30 04:16:36'),(29,'fatfree_test',1,7,'/home/inice/InstantSOA/deploy_cap/inice/7_fatfree_test',NULL,'Online','testtesttesttest','2010-06-30 04:35:58','2010-06-30 04:37:39'),(30,'lvlv',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_lvlv',NULL,'Deploying process Incomplete!','asoqine','2010-07-12 09:42:22','2010-07-12 09:42:26'),(31,'lvlv',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_lvlv',NULL,'Deploying process Incomplete!','asoqine','2010-07-12 09:43:42','2010-07-12 09:43:50'),(32,'fatfree',1,3,'/home/inice/InstantSOA/deploy_cap/inice/3_fatfree',NULL,'Deploying process Incomplete!','dsdfsadf','2010-07-27 13:23:25','2010-07-27 13:25:30'),(33,'fsdfdg',4,8,'/home/inice/InstantSOA/deploy_cap/inice/8_fsdfdg',NULL,'Deploying process Incomplete!','sagags','2010-07-27 13:32:16','2010-07-27 13:32:51'),(34,'spree111',1,3,'~/Project/deployApps/3_spree111',NULL,'Deploying process Incomplete!','asdf','2010-07-29 10:01:56','2010-07-29 10:02:03'),(35,'wewrk',2,3,'~/Project/deployApps/3_wewrk',NULL,'Deploying process Incomplete!','fasdlkfj','2010-08-01 09:35:22','2010-08-04 12:40:42'),(36,'dkwj',1,3,'~/Project/deployApps/3_dkwj',NULL,'Deploying process Incomplete!','asdlk','2010-08-01 16:10:54','2010-08-04 12:40:42'),(37,'fatfreeTEST',1,3,'~/Project/deployApps/3_fatfreeTEST',NULL,'Deploying process Incomplete!','fatfreeTest','2010-08-04 12:41:26','2010-08-04 12:41:28'),(38,'testFatFree',1,3,'~/Project/deployApps/3_testFatFree',NULL,'Deploying process Incomplete!','asdfasdfadsf','2010-08-05 20:35:43','2010-08-05 20:35:48'),(39,'macFatFree',1,3,'~/Project/deployApps/3_macFatFree',NULL,'Deploying process Incomplete!','asdfasdf','2010-08-05 20:37:12','2010-08-05 20:37:13'),(40,'macFatFree111',1,3,'~/Project/deployApps/3_macFatFree111',NULL,'Deploying process Incomplete!','asdfasdf','2010-08-05 20:38:34','2010-08-05 20:38:46'),(41,'FatFreeMac',1,3,'~/Project/deployApps/3_FatFreeMac',NULL,'Deploying process Incomplete!','asdfasdf','2010-08-05 20:45:31','2010-08-05 20:49:36'),(42,'MACFATFREE32',1,3,'~/Project/deployApps/3_MACFATFREE32',NULL,'Deploying process Incomplete!','aasl;dkj','2010-08-06 13:00:06','2010-08-06 13:00:24'),(43,'sdaffsd',1,3,'~/Project/deployApps/3_sdaffsd',NULL,'Deploying process Incomplete!','sfddfsdfs','2010-08-06 14:21:29','2010-08-06 14:37:36');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'chongsawad252@gmail.com','54f57795e648a974cfd10d1ac9b6e07e5b3d1de5','gSPOa4hfTR1E1BpZ_fRi',NULL,NULL,NULL,NULL,NULL,NULL,6,'2010-06-23 05:11:04','2010-06-23 04:43:36','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-22 08:29:43','2010-06-23 06:40:28','admin'),(3,'admin@project.com','14e8042265c172679ba35ca30dff7273b9595cb5','I5uuUTAlXTdLJq1zJQGs',NULL,NULL,NULL,NULL,'mOs9mj1ujEGpuPO0mbDX','2010-08-05 20:32:59',34,'2010-08-06 14:21:14','2010-08-06 12:59:40','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-23 06:48:04','2010-08-06 14:21:14','admin'),(4,'user1@project.com','9c635afcbde12dc3b78f0251648fc7e1c87427db','locuoT1axuFofoVzm8GO',NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-06-25 04:07:14','2010-06-24 16:33:25','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-24 14:50:36','2010-06-25 06:18:49','user1'),(5,'test@test.com','130708eaccfbf68a58cc7dda9e6cd3ad96a306b0','7BRnIULKXfSjuy6iFLoO',NULL,NULL,NULL,NULL,NULL,NULL,1,'2010-06-25 06:42:43','2010-06-25 06:42:43','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-25 06:42:43','2010-06-25 06:42:43','test'),(6,'customer1@project.com','442a418def8e0988940a54e57fe299437a03ae43','HGb_SwNgdWsHwUdWSSX6',NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-06-28 19:38:20','2010-06-28 13:41:55','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-28 06:47:23','2010-06-28 19:38:20','customer1'),(7,'user123@project.com','3255cc3d74fb29996c087a7780b2c5e1e37f198e','dSYseq_DVuZzOUy2unfm',NULL,NULL,NULL,NULL,NULL,NULL,1,'2010-06-30 04:32:50','2010-06-30 04:32:50','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-06-30 04:32:50','2010-06-30 04:32:50','user1'),(8,'test111@project.com','47033ece54fadb640e236b16c93174444fce40e5','g60iUw5Pz5TNpxuG1vkc',NULL,NULL,NULL,NULL,NULL,NULL,2,'2010-07-27 13:31:44','2010-07-27 13:30:44','127.0.0.1','127.0.0.1',0,NULL,NULL,'2010-07-27 13:30:44','2010-07-27 13:31:44','test111');
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

-- Dump completed on 2010-08-14  2:12:09
