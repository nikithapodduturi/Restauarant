-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `CategoryName` varchar(255) NOT NULL,
  `Description` text,
  PRIMARY KEY (`CategoryID`),
  KEY `RestaurantID` (`RestaurantID`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,'Appetizers','Start your meal with our delicious appetizers.'),(2,1,'Main Courses','Enjoy our mouthwatering main course dishes.'),(3,1,'Desserts','Indulge in our delightful dessert offerings.'),(4,2,'Starters','Begin your dining experience with our flavorful starters.'),(5,2,'Entrees','Savor our tempting entrees for a satisfying meal.'),(6,2,'Beverages','Quench your thirst with our refreshing beverages.'),(7,3,'Breakfast','Start your day with a hearty breakfast.'),(8,3,'Lunch','Enjoy a delicious lunch with us.'),(9,3,'Dinner','Satisfy your dinner cravings with our dishes.'),(10,4,'Burgers','Taste our mouthwatering burger creations.'),(11,4,'Sides','Pair your burger with our delectable sides.'),(12,4,'Desserts','End your meal with our sweet dessert options.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `MenuItemID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `CategoryID` int DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`MenuItemID`),
  KEY `RestaurantID` (`RestaurantID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`),
  CONSTRAINT `menuitems_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
INSERT INTO `menuitems` VALUES (1,1,1,'Garlic Bread','Toasted bread with garlic and herbs.',5.99),(2,1,1,'Bruschetta','Toasted baguette topped with diced tomatoes, garlic, and basil.',6.99),(3,1,2,'Spaghetti Carbonara','Classic Italian pasta dish with bacon and eggs.',12.99),(4,1,2,'Margherita Pizza','Traditional pizza with tomato, mozzarella, and basil.',10.99),(5,1,3,'Tiramisu','Italian dessert with coffee-soaked ladyfingers and mascarpone cheese.',6.99),(6,2,1,'Mozzarella Sticks','Fried mozzarella sticks served with marinara sauce.',7.99),(7,2,1,'Nachos','Tortilla chips topped with cheese, jalapeños, and salsa.',8.99),(8,2,2,'Grilled Salmon','Grilled salmon fillet with lemon butter sauce.',18.99),(9,2,2,'Chicken Alfredo','Creamy Alfredo sauce with grilled chicken and fettuccine.',14.99),(10,2,3,'Soda','Variety of sodas and soft drinks.',2.49),(11,3,1,'Pancakes','Stack of fluffy pancakes with maple syrup.',8.99),(12,3,1,'Omelette','Customizable omelette with your choice of ingredients.',10.99),(13,3,2,'Club Sandwich','Triple-decker sandwich with turkey, bacon, lettuce, and tomato.',11.99),(14,3,2,'Caesar Salad','Classic Caesar salad with romaine lettuce and Caesar dressing.',9.99),(15,3,3,'Grilled Steak','Juicy grilled steak with mashed potatoes and vegetables.',19.99),(16,4,1,'Classic Burger','Our signature beef burger with lettuce, tomato, and cheese.',9.99),(17,4,1,'Veggie Burger','Delicious veggie burger with lettuce and special sauce.',8.99),(18,4,2,'French Fries','Crispy golden fries served with ketchup.',3.99),(19,4,2,'Onion Rings','Crispy deep-fried onion rings.',4.99),(20,4,3,'Chocolate Brownie Sundae','Warm chocolate brownie topped with ice cream and hot fudge.',6.99),(21,3,7,'Idly','Healthy breakfast',8.99),(22,3,7,'Dosa','crispy floor with spice and your choice of ingredients.',10.99),(23,3,8,'Meals','South Indian Food good for health',11.99),(24,3,9,'Mandi','Classic Caesar salad with romaine lettuce and Caesar dressing.',9.99),(25,3,9,'Biryani','Juicy grilled steak with mashed potatoes and vegetables.',19.99),(26,3,4,'Manchuria','FastFood and crispy',8.99),(27,3,4,'Dosa','crispy floor with spice and your choice of ingredients.',10.99),(28,3,5,'Fish','South Indian fish good for health',11.99),(29,3,6,'Pepsi','Classic drink  after meal.',9.99),(30,3,6,'Coke','Juicy and taste of sweet.',19.99),(31,2,4,'Manchuria','FastFood and crispy',8.99),(32,2,4,'Dosa','crispy floor with spice and your choice of ingredients.',10.99),(33,2,5,'Fish','South Indian fish good for health',11.99),(34,2,6,'Pepsi','Classic drink  after meal.',9.99),(35,2,6,'Coke','Juicy and taste of sweet.',19.99),(36,4,10,'Veg Burger','Good for health',8.99),(37,4,10,'Chicken Burger','crispy meat with spiciness.',10.99),(38,4,11,'Fried Chicken','Food with high minerals.',11.99),(39,4,12,'Veg Desert','Classic food.',9.99),(40,4,12,'Ice cream','Juicy and taste of sweet.',19.99);
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantimages`
--

DROP TABLE IF EXISTS `restaurantimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurantimages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantimages`
--

LOCK TABLES `restaurantimages` WRITE;
/*!40000 ALTER TABLE `restaurantimages` DISABLE KEYS */;
INSERT INTO `restaurantimages` VALUES (1,1,'https://media-cdn.tripadvisor.com/media/photo-s/1d/30/57/59/altitude-rooftop-outside.jpg'),(2,1,'https://media-cdn.tripadvisor.com/media/photo-s/1d/30/57/59/altitude-rooftop-outside.jpg'),(3,2,'https://media-cdn.tripadvisor.com/media/photo-s/1d/30/57/59/altitude-rooftop-outside.jpg'),(4,3,'<!DOCTYPE html>\r\n<html>\r\n<head>\r\n<title>Sample HTML Page</title>\r\n</head>\r\n<body>\r\n<h1>Hello, HTML Page!</h1>\r\n<p>This is a sample HTML page sent as a response from a Node.js API.</p>\r\n</body>\r\n</html>');
/*!40000 ALTER TABLE `restaurantimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `RestaurantID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Website` varchar(255) DEFAULT NULL,
  `Cuisine` varchar(255) DEFAULT NULL,
  `Rating` decimal(3,1) DEFAULT NULL,
  `OpenHours` varchar(255) DEFAULT NULL,
  `DeliveryOptions` tinyint(1) DEFAULT NULL,
  `images` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RestaurantID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Restaurant A','123 Main St','(555) 123-4567','http://www.restaurantA.com','Italian',4.5,'Monday-Friday: 10:00 AM - 10:00 PM',1,'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?cs=srgb&dl=pexels-chan-walrus-958545.jpg&fm=jpg'),(2,'Restaurant B','456 Elm St','(555) 987-6543','http://www.restaurantB.com','Mexican',3.8,'Tuesday-Saturday: 11:00 AM - 9:00 PM',0,'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?cs=srgb&dl=pexels-chan-walrus-958545.jpg&fm=jpg'),(3,'Restaurant C','789 Main St','(555) 146-4567','http://www.restaurantC.com','French',4.0,'Monday-Friday: 10:00 AM - 10:00 PM',1,'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?cs=srgb&dl=pexels-chan-walrus-958545.jpg&fm=jpg'),(4,'Restaurant D','321 Elm St','(555) 124-6543','http://www.restaurantD.com','Indian',4.5,'Tuesday-Saturday: 11:00 AM - 9:00 PM',1,'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?cs=srgb&dl=pexels-chan-walrus-958545.jpg&fm=jpg'),(5,'Restaurant E','145 Opp Road','9846716845','http://www.restaurantE.com','American',4.6,'Monday-Friday: 10:00 AM - 10:00 PM',1,'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?cs=srgb&dl=pexels-chan-walrus-958545.jpg&fm=jpg');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `CustomerName` varchar(255) NOT NULL,
  `Rating` int NOT NULL,
  `Comment` text,
  `DatePosted` date DEFAULT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `RestaurantID` (`RestaurantID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,'John Doe',4,'Great food and service!','2023-09-14'),(2,1,'Alice Smith',5,'Highly recommended!','2023-09-15'),(3,2,'Bob Johnson',3,'Decent food, slow service.','2023-09-16'),(4,3,'Emily Wilson',4,'Excellent Chinese dishes.','2023-09-17'),(5,3,'Mike Brown',5,'Love this place!','2023-09-18');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

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
  `password` varchar(255) NOT NULL,
  `otp` int DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'Nikitha','nikitha.podduturi@gmail.com','$2b$10$uiGc6hjA6Z0f4JbEosOOPOOcSmcMQt0zmagZWgHZpMzcbOhEkAoj6',474028,1);
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

-- Dump completed on 2023-09-26 10:57:02
