--
-- Dumping data for table "children"
--

INSERT INTO "children" VALUES (1,'Alexander',1,'alexander'),(2,'Mary-Kate',2,'mary-kate'),(3,'Ashley',2,'ashley'),(4,'Abigail',1,'abigail'),(5,'Zapp',3,'zapp');

SELECT pg_catalog.setval('children_id_seq', 5, true);

--
-- Dumping data for table "sleep_blocks"
--

INSERT INTO "sleep_blocks" VALUES (1,1,'2011-02-17 23:50:00','2011-02-18 11:00:00'),(2,1,'2011-02-18 23:50:00','2011-02-19 08:00:00'),(3,1,'2011-02-19 09:30:00','2011-02-19 11:00:00'),(4,1,'2011-02-19 23:40:00','2011-02-20 10:30:00'),(5,1,'2011-02-20 23:45:00','2011-02-21 10:10:00'),(7,1,'2011-02-21 23:55:00','2011-02-22 10:10:00'),(8,1,'2011-02-22 23:50:00','2011-02-23 10:55:00'),(9,1,'2011-02-23 23:55:00','2011-02-24 10:20:00'),(10,1,'2011-02-24 23:55:00','2011-02-25 10:35:00'),(11,1,'2011-02-25 23:55:00','2011-02-26 10:50:00'),(12,1,'2011-02-26 23:55:00','2011-02-27 10:30:00'),(13,1,'2011-02-27 23:51:00','2011-02-28 10:00:00'),(14,1,'2011-02-28 23:45:00','2011-03-01 10:30:00'),(15,1,'2011-03-01 23:47:00','2011-03-02 10:30:00'),(16,1,'2011-03-03 00:00:00','2011-03-03 10:00:00'),(17,2,'2011-02-19 00:00:00','2011-02-19 13:00:00'),(18,2,'2011-02-19 19:00:00','2011-02-19 21:00:00'),(19,2,'2011-02-20 02:00:00','2011-02-20 11:00:00'),(20,2,'2011-02-20 18:00:00','2011-02-20 22:00:00'),(21,2,'2011-02-21 00:00:00','2011-02-21 13:00:00'),(22,2,'2011-02-21 19:00:00','2011-02-21 22:00:00'),(23,2,'2011-02-22 01:00:00','2011-02-22 11:00:00'),(24,2,'2011-02-22 18:00:00','2011-02-22 22:00:00'),(25,2,'2011-02-23 02:00:00','2011-02-23 12:00:00'),(26,2,'2011-02-23 19:00:00','2011-02-23 21:00:00'),(27,2,'2011-02-24 01:00:00','2011-02-24 12:00:00'),(28,2,'2011-02-24 19:00:00','2011-02-24 21:00:00'),(29,2,'2011-02-25 01:00:00','2011-02-25 11:00:00'),(30,2,'2011-02-25 19:00:00','2011-02-25 21:00:00'),(31,2,'2011-02-26 02:00:00','2011-02-26 11:00:00'),(32,2,'2011-02-26 18:00:00','2011-02-26 20:00:00'),(33,2,'2011-02-27 02:00:00','2011-02-27 11:00:00'),(34,2,'2011-02-27 19:00:00','2011-02-27 20:00:00'),(35,2,'2011-02-28 01:00:00','2011-02-28 13:00:00'),(36,2,'2011-02-28 18:00:00','2011-02-28 21:00:00'),(37,2,'2011-03-01 01:00:00','2011-03-01 13:00:00'),(38,2,'2011-03-01 19:00:00','2011-03-01 20:00:00'),(39,2,'2011-03-02 00:00:00','2011-03-02 11:00:00'),(40,2,'2011-03-02 19:00:00','2011-03-02 20:00:00'),(41,2,'2011-03-03 02:00:00','2011-03-03 13:00:00'),(42,2,'2011-03-03 19:00:00','2011-03-03 22:00:00'),(43,2,'2011-03-04 01:00:00','2011-03-04 13:00:00'),(44,2,'2011-03-04 18:00:00','2011-03-04 21:00:00'),(45,2,'2011-03-05 01:00:00','2011-03-05 13:00:00'),(46,2,'2011-03-05 19:00:00','2011-03-05 20:00:00'),(47,3,'2011-02-19 00:00:00','2011-02-19 11:00:00'),(48,3,'2011-02-19 18:00:00','2011-02-19 21:00:00'),(49,3,'2011-02-20 00:00:00','2011-02-20 12:00:00'),(50,3,'2011-02-20 19:00:00','2011-02-20 22:00:00'),(51,3,'2011-02-21 02:00:00','2011-02-21 11:00:00'),(52,3,'2011-02-21 18:00:00','2011-02-21 21:00:00'),(53,3,'2011-02-22 02:00:00','2011-02-22 11:00:00'),(54,3,'2011-02-22 18:00:00','2011-02-22 21:00:00'),(55,3,'2011-02-23 01:00:00','2011-02-23 12:00:00'),(56,3,'2011-02-23 18:00:00','2011-02-23 21:00:00'),(57,3,'2011-02-24 02:00:00','2011-02-24 13:00:00'),(58,3,'2011-02-24 18:00:00','2011-02-24 21:00:00'),(59,3,'2011-02-25 00:00:00','2011-02-25 11:00:00'),(60,3,'2011-02-25 18:00:00','2011-02-25 22:00:00'),(61,3,'2011-02-26 00:00:00','2011-02-26 12:00:00'),(62,3,'2011-02-26 18:00:00','2011-02-26 21:00:00'),(63,3,'2011-02-27 02:00:00','2011-02-27 13:00:00'),(64,3,'2011-02-27 19:00:00','2011-02-27 22:00:00'),(65,3,'2011-02-28 01:00:00','2011-02-28 12:00:00'),(66,3,'2011-02-28 19:00:00','2011-02-28 21:00:00'),(67,3,'2011-03-01 02:00:00','2011-03-01 12:00:00'),(68,3,'2011-03-01 19:00:00','2011-03-01 22:00:00'),(69,3,'2011-03-02 02:00:00','2011-03-02 11:00:00'),(70,3,'2011-03-02 18:00:00','2011-03-02 21:00:00'),(71,3,'2011-03-03 00:00:00','2011-03-03 12:00:00'),(72,3,'2011-03-03 19:00:00','2011-03-03 21:00:00'),(73,3,'2011-03-04 01:00:00','2011-03-04 13:00:00'),(74,3,'2011-03-04 18:00:00','2011-03-04 20:00:00'),(75,3,'2011-03-05 00:00:00','2011-03-05 13:00:00'),(76,3,'2011-03-05 19:00:00','2011-03-05 22:00:00'),(77,1,'2011-03-03 20:20:00','2011-03-03 21:00:00'),(78,1,'2011-03-04 00:30:00','2011-03-04 10:20:00'),(79,1,'2011-03-04 23:30:00','2011-03-05 10:30:00'),(80,1,'2011-03-06 00:00:00','2011-03-06 10:50:00'),(81,1,'2011-03-06 23:40:00','2011-03-07 10:20:00'),(82,1,'2011-03-07 23:30:00','2011-03-08 11:00:00'),(83,1,'2011-03-08 23:40:00','2011-03-09 10:30:00'),(84,4,'2011-03-08 00:00:00','2011-03-08 11:30:00'),(85,4,'2011-03-09 00:00:00','2011-03-09 11:45:00'),(86,1,'2011-03-09 23:40:00','2011-03-10 10:45:00'),(87,4,'2011-03-10 00:05:00','2011-03-10 11:15:00'),(88,5,'2011-03-10 01:00:00','2011-03-10 10:00:00'),(89,5,'2011-03-09 02:00:00','2011-03-09 07:00:00'),(90,1,'2011-03-10 23:55:00','2011-03-11 11:00:00'),(91,4,'2011-03-11 00:05:00','2011-03-11 11:30:00'),(92,1,'2011-03-11 23:50:00','2011-03-12 11:08:00'),(93,4,'2011-03-12 00:05:00','2011-03-12 11:45:00'),(94,1,'2011-03-12 23:55:00','2011-03-13 09:20:00'),(95,1,'2011-03-13 23:00:00','2011-03-14 10:00:00'),(96,1,'2011-03-14 23:10:00','2011-03-15 10:15:00'),(97,1,'2011-03-15 22:50:00','2011-03-16 10:15:00'),(98,1,'2011-03-16 22:50:00','2011-03-17 10:05:00'),(99,1,'2011-03-17 22:50:00','2011-03-18 09:50:00'),(100,1,'2011-03-18 22:50:00','2011-03-19 09:45:00'),(101,1,'2011-03-19 22:55:00','2011-03-20 09:10:00'),(102,1,'2011-03-20 22:55:00','2011-03-21 09:10:00'),(103,1,'2012-10-15 00:45:00','2012-10-15 09:50:00'),(104,1,'2012-10-16 00:17:00','2012-10-16 09:50:00'),(105,1,'2012-10-17 00:20:00','2012-10-17 09:50:00'),(106,1,'2012-10-18 00:15:00','2012-10-18 09:50:00'),(107,1,'2012-10-19 00:15:00','2012-10-19 07:00:00'),(108,1,'2012-10-19 09:00:00','2012-10-19 10:45:00'),(109,1,'2012-10-20 00:00:00','2012-10-20 09:00:00'),(110,1,'2012-10-21 00:00:00','2012-10-21 09:30:00'),(111,1,'2012-10-22 00:30:00','2012-10-22 09:00:00'),(112,1,'2012-10-23 00:30:00','2012-10-23 10:30:00'),(113,1,'2012-10-24 00:30:00','2012-10-24 10:30:00'),(114,1,'2012-10-25 00:30:00','2012-10-25 10:30:00'),(115,1,'2012-10-26 00:40:00','2012-10-26 10:55:00'),(116,1,'2012-10-27 00:45:00','2012-10-27 10:53:00'),(117,1,'2012-10-28 00:30:00','2012-10-28 10:45:00'),(118,1,'2012-10-29 00:30:00','2012-10-29 10:30:00'),(119,1,'2012-10-30 00:30:00','2012-10-30 10:45:00'),(120,1,'2012-10-31 00:30:00','2012-10-31 10:20:00'),(121,1,'2012-11-01 01:20:00','2012-11-01 10:30:00'),(122,1,'2012-11-02 00:20:00','2012-11-02 10:15:00'),(123,1,'2012-11-03 00:30:00','2012-11-03 10:25:00'),(124,1,'2012-11-04 01:20:00','2012-11-04 11:00:00'),(125,1,'2012-11-05 01:15:00','2012-11-05 11:10:00'),(126,1,'2012-11-07 01:45:00','2012-11-07 10:45:00'),(127,1,'2012-11-06 01:15:00','2012-11-06 11:10:00'),(128,1,'2012-11-08 01:20:00','2012-11-08 11:45:00'),(129,1,'2012-11-09 01:20:00','2012-11-09 11:35:00'),(130,1,'2012-11-10 01:30:00','2012-11-10 11:40:00'),(131,1,'2012-11-11 01:15:00','2012-11-11 11:15:00'),(132,1,'2012-11-12 01:20:00','2012-11-12 11:00:00'),(133,1,'2012-11-13 01:20:00','2012-11-13 11:30:00'),(134,1,'2012-11-14 01:40:00','2012-11-14 11:50:00'),(135,1,'2012-11-15 01:40:00','2012-11-15 11:50:00'),(136,1,'2012-11-16 01:30:00','2012-11-16 10:50:00'),(137,1,'2012-11-17 01:40:00','2012-11-17 11:35:00'),(138,1,'2012-11-18 01:30:00','2012-11-18 11:15:00'),(139,1,'2012-11-19 01:20:00','2012-11-19 10:55:00'),(140,1,'2012-11-20 01:30:00','2012-11-20 11:10:00'),(141,1,'2012-11-21 01:20:00','2012-11-21 11:30:00'),(142,1,'2012-11-22 02:30:00','2012-11-22 12:30:00'),(143,1,'2012-11-23 01:20:00','2012-11-23 11:30:00'),(144,1,'2012-11-24 01:35:00','2012-11-24 11:50:00'),(145,1,'2012-11-25 02:00:00','2012-11-25 11:45:00'),(146,1,'2012-11-26 01:20:00','2012-11-26 11:40:00'),(147,1,'2012-11-27 01:20:00','2012-11-27 11:20:00'),(148,1,'2012-11-28 01:20:00','2012-11-28 11:00:00'),(149,1,'2012-11-29 01:20:00','2012-11-29 10:50:00'),(150,1,'2012-11-30 01:20:00','2012-11-30 11:00:00'),(151,1,'2012-12-01 01:20:00','2012-12-01 10:50:00'),(152,1,'2012-12-02 01:40:00','2012-12-02 11:45:00'),(153,1,'2012-12-03 01:30:00','2012-12-03 11:30:00'),(154,1,'2012-12-04 01:30:00','2012-12-04 11:23:00'),(155,1,'2012-12-05 01:50:00','2012-12-05 11:15:00');

SELECT pg_catalog.setval('sleep_blocks_id_seq', 155, true);

--
-- Dumping data for table "tracked_days"
--

INSERT INTO "tracked_days" VALUES (1,1,'2011-02-17',NULL,18600),(2,1,'2011-02-18',NULL,40200),(3,1,'2011-02-19',NULL,35400),(4,1,'2011-02-20',NULL,42300),(5,1,'2011-02-21',NULL,36900),(6,1,'2011-02-22',NULL,37200),(7,1,'2011-02-23',NULL,39600),(8,1,'2011-02-24',NULL,37500),(9,1,'2011-02-25',NULL,38400),(10,1,'2011-02-26',NULL,39300),(11,1,'2011-02-27',NULL,38340),(12,1,'2011-02-28',NULL,36900),(13,1,'2011-03-01',NULL,38580),(14,1,'2011-03-02',NULL,37800),(15,1,'2011-03-03',NULL,36600),(16,2,'2011-02-18',NULL,18000),(17,2,'2011-02-19',NULL,46800),(18,2,'2011-02-20',NULL,54000),(19,2,'2011-02-21',NULL,54000),(20,2,'2011-02-22',NULL,46800),(21,2,'2011-02-23',NULL,46800),(22,2,'2011-02-24',NULL,46800),(23,2,'2011-02-25',NULL,39600),(24,2,'2011-02-26',NULL,39600),(25,2,'2011-02-27',NULL,39600),(26,2,'2011-02-28',NULL,54000),(27,2,'2011-03-01',NULL,50400),(28,2,'2011-03-02',NULL,36000),(29,2,'2011-03-03',NULL,54000),(30,2,'2011-03-04',NULL,54000),(31,2,'2011-03-05',NULL,32400),(32,3,'2011-02-18',NULL,18000),(33,3,'2011-02-19',NULL,50400),(34,3,'2011-02-20',NULL,46800),(35,3,'2011-02-21',NULL,43200),(36,3,'2011-02-22',NULL,46800),(37,3,'2011-02-23',NULL,46800),(38,3,'2011-02-24',NULL,57600),(39,3,'2011-02-25',NULL,54000),(40,3,'2011-02-26',NULL,46800),(41,3,'2011-02-27',NULL,54000),(42,3,'2011-02-28',NULL,43200),(43,3,'2011-03-01',NULL,46800),(44,3,'2011-03-02',NULL,50400),(45,3,'2011-03-03',NULL,46800),(46,3,'2011-03-04',NULL,54000),(47,3,'2011-03-05',NULL,39600),(48,1,'2011-03-04',NULL,39000),(49,1,'2011-03-05',NULL,37800),(50,1,'2011-03-06',NULL,40200),(51,1,'2011-03-07',NULL,39000),(52,1,'2011-03-08',NULL,40800),(53,4,'2011-03-07',NULL,18000),(54,4,'2011-03-08',NULL,41400),(55,1,'2011-03-09',NULL,39000),(56,4,'2011-03-09',NULL,42000),(57,5,'2011-03-09',NULL,21600),(58,5,'2011-03-10',NULL,18000),(59,5,'2011-03-08',NULL,10800),(60,1,'2011-03-10',NULL,39000),(61,4,'2011-03-10',NULL,40200),(62,1,'2011-03-11',NULL,40200),(63,4,'2011-03-11',NULL,41100),(64,4,'2011-03-12',NULL,24300),(65,1,'2011-03-12',NULL,40380),(66,1,'2011-03-13',NULL,33600),(67,1,'2011-03-14',NULL,39000),(68,1,'2011-03-15',NULL,41100),(69,1,'2011-03-16',NULL,41100),(70,1,'2011-03-17',NULL,40500),(71,1,'2011-03-18',NULL,39600),(72,1,'2011-03-19',NULL,39000),(73,1,'2011-03-20',NULL,36900),(74,1,'2011-03-21',NULL,18600),(75,1,'2012-10-14',NULL,11700),(76,1,'2012-10-15',NULL,34380),(77,1,'2012-10-16',NULL,34200),(78,1,'2012-10-17',NULL,34500),(79,1,'2012-10-18',NULL,34500),(80,1,'2012-10-19',NULL,31500),(81,1,'2012-10-20',NULL,32400),(82,1,'2012-10-21',NULL,32400),(83,1,'2012-10-22',NULL,30600),(84,1,'2012-10-23',NULL,36000),(85,1,'2012-10-24',NULL,36000),(86,1,'2012-10-25',NULL,35400),(87,1,'2012-10-26',NULL,36600),(88,1,'2012-10-27',NULL,37380),(89,1,'2012-10-28',NULL,36900),(90,1,'2012-10-29',NULL,36000),(91,1,'2012-10-30',NULL,36900),(92,1,'2012-10-31',NULL,32400),(93,1,'2012-11-01',NULL,36600),(94,1,'2012-11-02',NULL,35100),(95,1,'2012-11-03',NULL,32700),(96,1,'2012-11-04',NULL,38700),(97,1,'2012-11-05',NULL,35700),(98,1,'2012-11-06',NULL,33900),(99,1,'2012-11-07',NULL,33900),(100,1,'2012-11-08',NULL,37500),(101,1,'2012-11-09',NULL,36300),(102,1,'2012-11-10',NULL,37500),(103,1,'2012-11-11',NULL,35700),(104,1,'2012-11-12',NULL,34800),(105,1,'2012-11-13',NULL,35400),(106,1,'2012-11-14',NULL,36600),(107,1,'2012-11-15',NULL,37200),(108,1,'2012-11-16',NULL,33000),(109,1,'2012-11-17',NULL,36300),(110,1,'2012-11-18',NULL,35700),(111,1,'2012-11-19',NULL,33900),(112,1,'2012-11-20',NULL,35400),(113,1,'2012-11-21',NULL,32400),(114,1,'2012-11-22',NULL,40200),(115,1,'2012-11-23',NULL,35700),(116,1,'2012-11-24',NULL,35400),(117,1,'2012-11-25',NULL,37500),(118,1,'2012-11-26',NULL,37200),(119,1,'2012-11-27',NULL,36000),(120,1,'2012-11-28',NULL,34800),(121,1,'2012-11-29',NULL,34200),(122,1,'2012-11-30',NULL,34800),(123,1,'2012-12-01',NULL,33000),(124,1,'2012-12-02',NULL,36900),(125,1,'2012-12-03',NULL,36000),(126,1,'2012-12-04',NULL,34380),(127,1,'2012-12-05',NULL,22500);

SELECT pg_catalog.setval('tracked_days_id_seq', 127, true);

--
-- Dumping data for table "users"
--

INSERT INTO "users" VALUES (1,'wesgibbs@gmail.com','$2a$10$7d8OgZAh83.xCVjw/3RHtezlMxbDPFnNpph9aysSqjUaGkCp5ZHbK','$2a$10$7d8OgZAh83.xCVjw/3RHte',NULL,NULL,NULL,NULL,NULL,'2012-11-21 22:57:32','2011-02-21 20:23:02','2012-12-02 14:53:56','Eastern Time (US & Canada)');

SELECT pg_catalog.setval('users_id_seq', 1, true);