-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: cis6003_lab_app
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `testId` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `PreparationInstructions` varchar(455) DEFAULT NULL,
  `cost` varchar(50) DEFAULT NULL,
  `ReportReadyIn` varchar(50) DEFAULT NULL,
  `MeasurementUnit` varchar(50) DEFAULT NULL,
  `LowReferenceRange` varchar(50) DEFAULT NULL,
  `HighReferenceRange` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`testId`),
  UNIQUE KEY `testId_UNIQUE` (`testId`),
  UNIQUE KEY `type_UNIQUE` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'BLOOD_TEST','Blood test is a common laboratory test used to evaluate various components of blood.','Fasting may be required for 8 hours before the test.','1500.00','24 hours','mg/dL','4.5','6.2'),(2,'URINE_TEST','Urine test is a diagnostic test used to detect and monitor various medical conditions by analyzing the urine sample.','Collect a clean-catch urine sample.','1000.00','24 hours','mg/dL','4.5','6.2'),(3,'XRAY','X-ray is a non-invasive medical imaging technique used to visualize the internal structures of the body.','No special preparation required.','3000.00','2 hours','-','-','-'),(4,'ULTRASOUND','Ultrasound is a diagnostic imaging technique that uses high-frequency sound waves to create images of internal organs and tissues.','Drink plenty of water and refrain from urinating before the test.','4000.00','48 hours','mm','0.5','2.0'),(5,'MRI','MRI (Magnetic Resonance Imaging) is a medical imaging technique used to visualize internal structures of the body in detail.','Remove any metal objects and inform the technician of any implants or medical devices.','10000.00','72 hours','-','-','-'),(6,'CT_SCAN','CT scan (Computed Tomography) is a medical imaging technique used to create detailed cross-sectional images of the body.','May require fasting, and contrast dye may be administered.','6000.00','24 hours','-','-','-'),(7,'ECG','ECG (Electrocardiogram) is a medical test used to measure the electrical activity of the heart over a period of time.','No special preparation required.','800.00','1 hour','-','-','-'),(8,'EEG','EEG (Electroencephalogram) is a medical test used to record electrical activity in the brain, typically to diagnose neurological disorders.','Wash your hair before the test and avoid caffeine before the appointment.','2500.00','48 hours','-','-','-'),(9,'EMG','EMG (Electromyogram) is a medical test used to assess the health of muscles and nerve cells that control them.','No special preparation required.','2000.00','48 hours','-','-','-'),(10,'PFT','PFT (Pulmonary Function Test) is a group of tests used to assess the function of the lungs and how well they are working.','Avoid smoking and strenuous exercise before the test.','1200.00','24 hours','mL/min','80','120'),(11,'COLONOSCOPY','Colonoscopy is a medical procedure used to examine the inside of the colon and rectum for abnormalities.','Follow specific dietary restrictions and bowel preparation instructions provided by your healthcare provider.','15000.00','72 hours','-','-','-'),(12,'ENDOSCOPY','Endoscopy is a medical procedure used to examine the inside of the body, typically the digestive tract, using an endoscope.','Follow specific dietary restrictions and fasting instructions provided by your healthcare provider.','12000.00','48 hours','-','-','-'),(13,'MAMMOGRAPHY','Mammography is a screening test used to detect breast cancer early, when it is most treatable.','Avoid using deodorants, lotions, or powders on the day of the test.','2000.00','48 hours','-','-','-'),(14,'PAP_SMEAR','Pap smear is a screening test used to detect cervical cancer and precancerous changes in the cervix.','Avoid intercourse, douching, or using vaginal creams or medications 24 hours before the test.','1000.00','48 hours','-','-','-'),(15,'PSA_TEST','PSA test is a blood test used to screen for prostate cancer.','No special preparation required.','1500.00','24 hours','ng/mL','0','4'),(16,'TSH_TEST','TSH test is a blood test used to evaluate thyroid function.','No special preparation required.','1200.00','24 hours','uIU/mL','0.5','5.0'),(17,'LIPID_PROFILE','Lipid profile is a group of tests used to measure cholesterol and triglyceride levels in the blood.','Fasting may be required for 8-12 hours before the test.','1800.00','24 hours','mg/dL','70','200'),(18,'GLUCOSE_TEST','Glucose test is a blood test used to measure blood sugar levels and diagnose diabetes.','Fasting may be required for 8-12 hours before the test.','1000.00','24 hours','mg/dL','70','140'),(19,'HEMOGLOBIN_TEST','Hemoglobin test is a blood test used to measure the amount of hemoglobin in the blood.','No special preparation required.','800.00','24 hours','g/dL','12','16'),(20,'HIV_TEST','HIV test is a diagnostic test used to detect HIV antibodies or antigens in the blood.','No special preparation required.','3000.00','48 hours','-','-','-');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-17 12:23:35
