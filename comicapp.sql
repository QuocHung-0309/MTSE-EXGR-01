-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: comic_app
-- ------------------------------------------------------
-- Server version	8.4.6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alternatenames`
--

DROP TABLE IF EXISTS `alternatenames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alternatenames` (
  `nameId` int NOT NULL AUTO_INCREMENT,
  `comicId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`nameId`),
  KEY `idx_alternatename_comicid` (`comicId`),
  CONSTRAINT `alternatenames_ibfk_1` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chapterimages`
--

DROP TABLE IF EXISTS `chapterimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapterimages` (
  `imageId` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chapterId` int NOT NULL,
  `imageUrl` varchar(500) NOT NULL,
  `pageNumber` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`imageId`),
  KEY `idx_chapterId_pageNumber` (`chapterId`,`pageNumber`),
  CONSTRAINT `chapterimages_ibfk_1` FOREIGN KEY (`chapterId`) REFERENCES `chapters` (`chapterId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3089455 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chapters`
--

DROP TABLE IF EXISTS `chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapters` (
  `chapterId` int NOT NULL AUTO_INCREMENT,
  `chapterNumber` decimal(10,2) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `comicId` int DEFAULT NULL,
  `views` int NOT NULL DEFAULT '0',
  `isLocked` tinyint(1) NOT NULL DEFAULT '0',
  `cost` int DEFAULT '1',
  PRIMARY KEY (`chapterId`),
  KEY `comicId` (`comicId`),
  CONSTRAINT `Chapters_comicId_foreign_idx` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chapters_ibfk_1` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64442 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chapterunlocks`
--

DROP TABLE IF EXISTS `chapterunlocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapterunlocks` (
  `unlockId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `chapterId` int NOT NULL,
  `unlockedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`unlockId`),
  UNIQUE KEY `unique_user_chapter` (`userId`,`chapterId`),
  UNIQUE KEY `chapterunlocks_user_id_chapter_id` (`userId`,`chapterId`),
  KEY `idx_chapter_id` (`chapterId`),
  CONSTRAINT `chapterunlocks_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `chapterunlocks_ibfk_2` FOREIGN KEY (`chapterId`) REFERENCES `chapters` (`chapterId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checkins`
--

DROP TABLE IF EXISTS `checkins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `day` int NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `checkins_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comic`
--

DROP TABLE IF EXISTS `comic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comic` (
  `comicId` int NOT NULL AUTO_INCREMENT,
  `author` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `coverImage` varchar(500) DEFAULT NULL,
  `description` text,
  `status` enum('In Progress','On Hold','Completed') DEFAULT 'In Progress',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`comicId`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `title_UNIQUE` (`title`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=679 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comicfollows`
--

DROP TABLE IF EXISTS `comicfollows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comicfollows` (
  `followId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `comicId` int NOT NULL,
  `followDate` datetime NOT NULL,
  PRIMARY KEY (`followId`),
  UNIQUE KEY `userId` (`userId`,`comicId`),
  KEY `comicfollows_ibfk_2` (`comicId`),
  CONSTRAINT `comicfollows_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `comicfollows_ibfk_2` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comiclikes`
--

DROP TABLE IF EXISTS `comiclikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comiclikes` (
  `likeId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `comicId` int DEFAULT NULL,
  `likeDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`likeId`),
  UNIQUE KEY `userId` (`userId`,`comicId`),
  KEY `comicId` (`comicId`),
  CONSTRAINT `comiclikes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `comiclikes_ibfk_2` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comicratings`
--

DROP TABLE IF EXISTS `comicratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comicratings` (
  `ratingId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `comicId` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `ratingAt` datetime NOT NULL,
  PRIMARY KEY (`ratingId`),
  UNIQUE KEY `userId` (`userId`,`comicId`),
  KEY `comicId` (`comicId`),
  CONSTRAINT `comicratings_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `comicratings_ibfk_2` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`),
  CONSTRAINT `comicratings_chk_1` CHECK ((`score` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commentlikes`
--

DROP TABLE IF EXISTS `commentlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentlikes` (
  `likeId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `commentId` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`likeId`),
  UNIQUE KEY `userId` (`userId`,`commentId`),
  KEY `commentId` (`commentId`),
  CONSTRAINT `commentlikes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `commentlikes_ibfk_2` FOREIGN KEY (`commentId`) REFERENCES `comments` (`commentId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `comicId` int NOT NULL,
  `chapterId` int DEFAULT NULL,
  `userId` int NOT NULL,
  `content` text NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `parentId` int DEFAULT NULL,
  PRIMARY KEY (`commentId`),
  KEY `comicId` (`comicId`),
  KEY `userId` (`userId`),
  KEY `parentId` (`parentId`),
  KEY `fk_comments_chapter` (`chapterId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parentId`) REFERENCES `comments` (`commentId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_chapter` FOREIGN KEY (`chapterId`) REFERENCES `chapters` (`chapterId`) ON DELETE CASCADE,
  CONSTRAINT `fk_parent_comment` FOREIGN KEY (`parentId`) REFERENCES `comments` (`commentId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genreId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`genreId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genrecomic`
--

DROP TABLE IF EXISTS `genrecomic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genrecomic` (
  `comicId` int NOT NULL,
  `genreId` int NOT NULL,
  UNIQUE KEY `comicId` (`comicId`,`genreId`),
  KEY `genreId` (`genreId`),
  CONSTRAINT `genrecomic_ibfk_1` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE CASCADE,
  CONSTRAINT `genrecomic_ibfk_2` FOREIGN KEY (`genreId`) REFERENCES `genre` (`genreId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificationdeliveries`
--

DROP TABLE IF EXISTS `notificationdeliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificationdeliveries` (
  `deliveryId` int NOT NULL AUTO_INCREMENT,
  `notificationId` int NOT NULL,
  `userId` int NOT NULL,
  `isRead` tinyint(1) DEFAULT '0',
  `deliveredAt` datetime NOT NULL,
  PRIMARY KEY (`deliveryId`),
  UNIQUE KEY `NotificationDeliveries_notificationId_userId_unique` (`notificationId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `notificationdeliveries_ibfk_1` FOREIGN KEY (`notificationId`) REFERENCES `notifications` (`notificationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificationdeliveries_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notificationId` int NOT NULL AUTO_INCREMENT,
  `category` enum('comic_update','system','follow','comment','promotion') NOT NULL,
  `audienceType` enum('global','direct') NOT NULL DEFAULT 'direct',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`notificationId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest`
--

DROP TABLE IF EXISTS `quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quest` (
  `questId` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `targetValue` int DEFAULT '1',
  `rewardCoins` int DEFAULT '50',
  `category` enum('checkin','reading','comment','favorite','rating') DEFAULT NULL,
  PRIMARY KEY (`questId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `readinghistory`
--

DROP TABLE IF EXISTS `readinghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readinghistory` (
  `historyId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `comicId` int NOT NULL,
  `chapterId` int NOT NULL,
  `lastReadAt` datetime NOT NULL,
  PRIMARY KEY (`historyId`),
  UNIQUE KEY `user_comic_unique` (`userId`,`comicId`),
  KEY `comicId` (`comicId`),
  KEY `chapterId` (`chapterId`),
  CONSTRAINT `readinghistory_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `readinghistory_ibfk_2` FOREIGN KEY (`comicId`) REFERENCES `comic` (`comicId`) ON DELETE CASCADE,
  CONSTRAINT `readinghistory_ibfk_3` FOREIGN KEY (`chapterId`) REFERENCES `chapters` (`chapterId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `reportId` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` enum('comment','chapter') NOT NULL,
  `userId` int NOT NULL,
  `isResolved` tinyint(1) DEFAULT '0',
  `resolvedAt` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `targetId` int NOT NULL,
  PRIMARY KEY (`reportId`),
  KEY `fk_reports_user` (`userId`),
  CONSTRAINT `fk_reports_user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transactionId` int NOT NULL AUTO_INCREMENT,
  `chapterId` int DEFAULT NULL,
  `amount` int NOT NULL,
  `type` enum('credit','debit') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transactionDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('success','pending','failed') NOT NULL DEFAULT 'pending',
  `walletId` int DEFAULT NULL,
  PRIMARY KEY (`transactionId`),
  KEY `idx_chapter_id` (`chapterId`),
  KEY `fk_transactions_wallet` (`walletId`),
  CONSTRAINT `fk_transactions_wallet` FOREIGN KEY (`walletId`) REFERENCES `wallets` (`walletId`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`chapterId`) REFERENCES `chapters` (`chapterId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userquests`
--

DROP TABLE IF EXISTS `userquests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userquests` (
  `userquestId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `questId` int NOT NULL,
  `assignedDate` date NOT NULL,
  `progress` int DEFAULT '0',
  `isClaimed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userquestId`),
  UNIQUE KEY `unique_user_quest` (`userId`,`questId`,`assignedDate`),
  KEY `idx_user_date` (`userId`,`assignedDate`),
  KEY `userquests_ibfk_1_idx` (`questId`),
  CONSTRAINT `fk_userquests_users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `userquests_ibfk_1` FOREIGN KEY (`questId`) REFERENCES `quest` (`questId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `resetToken` varchar(255) DEFAULT NULL,
  `resetExpiration` datetime DEFAULT NULL,
  `isVerified` tinyint NOT NULL DEFAULT '0',
  `role` enum('user','admin','moderator') NOT NULL DEFAULT 'user',
  `status` enum('active','suspended','deleted') NOT NULL DEFAULT 'active',
  `lastLogin` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `walletId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `balance` int NOT NULL DEFAULT '0',
  `lastUpdated` datetime NOT NULL,
  PRIMARY KEY (`walletId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-24 23:15:05
