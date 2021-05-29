-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: whiteboard
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `assignment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `std_id` int NOT NULL,
  `course_id` int unsigned NOT NULL,
  `type_id` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `score` float(8,2) NOT NULL,
  `daedline` datetime DEFAULT NULL,
  PRIMARY KEY (`assignment_id`,`std_id`,`course_id`,`type_id`,`score`),
  UNIQUE KEY `std_id_UNIQUE` (`std_id`),
  KEY `assignment_course_id_idx` (`course_id`),
  KEY `assignment_type_id_idx` (`type_id`),
  CONSTRAINT `assignment_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `assignment_std_id` FOREIGN KEY (`std_id`) REFERENCES `student` (`std_id`),
  CONSTRAINT `assignment_type_id` FOREIGN KEY (`type_id`) REFERENCES `assignment_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_type`
--

DROP TABLE IF EXISTS `assignment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment_type` (
  `type_id` int NOT NULL,
  `midterm_exam` float(8,2) DEFAULT NULL,
  `final_exam` float(8,2) DEFAULT NULL,
  `quiz` float(8,2) DEFAULT NULL,
  `homework` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_type`
--

LOCK TABLES `assignment_type` WRITE;
/*!40000 ALTER TABLE `assignment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `post_id` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `c_material` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`,`user_id`,`post_id`),
  KEY `comment_user_id_idx` (`user_id`),
  KEY `post_comment_id_idx` (`post_id`),
  CONSTRAINT `comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `post_comment_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'Chanathip','test','9999-12-31 23:59:59'),(2,1,1,'Chanathip','test1','9999-12-31 23:59:59'),(3,1,1,'Chanathip','test2','9999-12-31 23:59:59'),(4,1,2,'Chanathip','test3','9999-12-31 23:59:59'),(5,1,2,'Chanathip','test4','9999-12-31 23:59:59'),(6,2,1,'test','test5','9999-12-31 23:59:59'),(7,2,1,'test','test6','9999-12-31 23:59:59'),(8,2,2,'test','test7','9999-12-31 23:59:59'),(9,2,2,'test','test8','9999-12-31 23:59:59'),(10,2,2,'test','test9','9999-12-31 23:59:59');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int unsigned NOT NULL,
  `teacher_id` int unsigned NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) DEFAULT NULL,
  `semester` enum('1','2') DEFAULT NULL,
  PRIMARY KEY (`course_id`,`teacher_id`),
  KEY `course_taecher_id_idx` (`teacher_id`),
  CONSTRAINT `course_taecher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teacher`
--

DROP TABLE IF EXISTS `course_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_teacher` (
  `teacher_id` int unsigned NOT NULL,
  `course_id` int unsigned NOT NULL,
  PRIMARY KEY (`teacher_id`,`course_id`),
  KEY `ct_course_id_idx` (`course_id`),
  CONSTRAINT `ct_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `ct_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teacher`
--

LOCK TABLES `course_teacher` WRITE;
/*!40000 ALTER TABLE `course_teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('student','teacher') DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `p_material` varchar(255) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `user_post_id_idx` (`user_id`),
  CONSTRAINT `post_usert_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Chanathip','teacher','test','test','9999-12-31 23:59:59'),(2,1,'Chanathip','teacher','test1','test1','9999-12-31 23:59:59'),(3,2,'test','student','test2','test2','9999-12-31 23:59:59'),(4,2,'test','student','test3','test3','9999-12-31 23:59:59'),(5,2,'test','student','test4','test4','9999-12-31 23:59:59'),(6,2,'test','student','test5','test5','9999-12-31 23:59:59'),(7,2,'test','student','test6','test6','9999-12-31 23:59:59'),(8,3,'test2','teacher','test7','test7','9999-12-31 23:59:59'),(9,3,'test2','teacher','test8','test8','9999-12-31 23:59:59'),(10,3,'test2','teacher','test9','test9','9999-12-31 23:59:59');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int unsigned NOT NULL,
  `year` int NOT NULL,
  `std_id` int NOT NULL,
  PRIMARY KEY (`id`,`std_id`),
  UNIQUE KEY `std_id_UNIQUE` (`std_id`),
  CONSTRAINT `user_student_id` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,1,2),(2,1,3),(3,1,5),(4,1,8),(5,2,10),(6,1,11),(7,1,12),(8,2,13),(9,2,14),(10,1,16);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_assignment`
--

DROP TABLE IF EXISTS `student_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_assignment` (
  `assignment_id` int unsigned NOT NULL,
  `std_id` int NOT NULL,
  `score` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`std_id`,`assignment_id`),
  UNIQUE KEY `std_id_UNIQUE` (`std_id`),
  KEY `stdasm_assignment_id_idx` (`assignment_id`),
  CONSTRAINT `stdasm_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`assignment_id`),
  CONSTRAINT `stdasm_std_id` FOREIGN KEY (`std_id`) REFERENCES `student` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_assignment`
--

LOCK TABLES `student_assignment` WRITE;
/*!40000 ALTER TABLE `student_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course`
--

DROP TABLE IF EXISTS `student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course` (
  `enroll_id` int NOT NULL,
  `std_id` int NOT NULL,
  `course_id` int unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`enroll_id`,`std_id`,`date`,`course_id`),
  UNIQUE KEY `std_id_UNIQUE` (`std_id`),
  KEY `stdcourse_course_id_idx` (`course_id`),
  CONSTRAINT `stdcourse_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `stdcourse_std_id` FOREIGN KEY (`std_id`) REFERENCES `student` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course`
--

LOCK TABLES `student_course` WRITE;
/*!40000 ALTER TABLE `student_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course_check`
--

DROP TABLE IF EXISTS `student_course_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course_check` (
  `check_no` int unsigned NOT NULL,
  `enroll_id` int NOT NULL,
  `check` tinyint NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`check_no`,`enroll_id`),
  KEY `scc_enroll_id_idx` (`enroll_id`),
  CONSTRAINT `scc_enroll_id` FOREIGN KEY (`enroll_id`) REFERENCES `student_course` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course_check`
--

LOCK TABLES `student_course_check` WRITE;
/*!40000 ALTER TABLE `student_course_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_course_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacher_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`teacher_id`,`user_id`),
  KEY `user_teacher_id_idx` (`user_id`),
  CONSTRAINT `user_teacher_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,1),(2,4),(3,6),(4,7),(5,9),(6,15),(7,17),(8,18),(9,19),(10,20);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `type` enum('student','teacher') NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Chanathip','Amoncheewasilapakul','teacher','test_test1@hotmail.com'),(2,'test2','test2','student','test_test2@hotmail.com'),(3,'test3','test3','student','test_test3@hotmail.com'),(4,'test4','test4','teacher','test_test4@hotmail.com'),(5,'test5','test5','student','test_test5@hotmail.com'),(6,'test6','test6','teacher','test_test6@hotmail.com'),(7,'test7','test7','teacher','test_test7@hotmail.com'),(8,'test8','test8','student','test_test8@hotmail.com'),(9,'test9','test9','teacher','test_test9@hotmail.com'),(10,'test10','test10','student','test_test10@hotmail.com'),(11,'test11','test11','student','test_test11@hotmail.com'),(12,'test12','test12','student','test_test12@hotmail.com'),(13,'test13','test13','student','test_test13@hotmail.com'),(14,'test14','test14','student','test_test14@hotmail.com'),(15,'test15','test15','teacher','test_test15@hotmail.com'),(16,'test16','test16','student','test_test16@hotmail.com'),(17,'test17','test17','teacher','test_test17@hotmail.com'),(18,'test18','test18','teacher','test_test18@hotmail.com'),(19,'test19','test19','teacher','test_test19@hotmail.com'),(20,'test20','test20','teacher','test_test20@hotmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-30 16:19:54
