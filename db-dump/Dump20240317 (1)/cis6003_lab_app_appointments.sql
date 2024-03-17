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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointmentId` int NOT NULL AUTO_INCREMENT,
  `technitianId` int DEFAULT NULL,
  `seekerId` int DEFAULT NULL,
  `startTime` varchar(45) DEFAULT NULL,
  `notes` longtext,
  `costOfTest` varchar(45) DEFAULT NULL,
  `scheduledDate` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `recomendedDoctor` varchar(45) DEFAULT NULL,
  `appointmentRefId` varchar(45) DEFAULT NULL,
  `testType` varchar(45) DEFAULT NULL,
  `testResults` varchar(150) DEFAULT NULL,
  `testResultsDescription` longtext,
  `testUpdatedBy` varchar(150) DEFAULT NULL,
  `testUpdatedOn` date DEFAULT NULL,
  PRIMARY KEY (`appointmentId`),
  UNIQUE KEY `appointmentId_UNIQUE` (`appointmentId`),
  UNIQUE KEY `appointmentRefId_UNIQUE` (`appointmentRefId`),
  KEY `technitianId_idx` (`technitianId`),
  KEY `seekerId_idx` (`seekerId`),
  CONSTRAINT `seekerId` FOREIGN KEY (`seekerId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT,
  CONSTRAINT `technitianId` FOREIGN KEY (`technitianId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (71,39,80,'','d','1500.00','2024-03-07','COMPLETED','doctor','REF-24031113253424','BLOOD_TEST','All values fall within normal ranges. No abnormalities detected.','Complete Blood Count (CBC):\r\n\r\nWhite Blood Cell Count (WBC): 6.5 x 10^9/L\r\nRed Blood Cell Count (RBC): 4.5 x 10^12/L\r\nHemoglobin (Hgb): 14 g/dL\r\nHematocrit (Hct): 42%\r\nMean Corpuscular Volume (MCV): 90 fL\r\nMean Corpuscular Hemoglobin (MCH): 30 pg\r\nMean Corpuscular Hemoglobin Concentration (MCHC): 33 g/dL\r\nPlatelet Count: 250 x 10^9/L\r\nBasic Metabolic Panel (BMP):\r\n\r\nGlucose: 90 mg/dL\r\nSodium: 140 mEq/L\r\nPotassium: 4.2 mEq/L\r\nChloride: 100 mEq/L\r\nCarbon Dioxide (CO2): 25 mEq/L\r\nCalcium: 9.0 mg/dL\r\nBUN (Blood Urea Nitrogen): 15 mg/dL\r\nCreatinine: 0.8 mg/dL\r\nLiver Function Tests (LFTs):\r\n\r\nTotal Bilirubin: 0.8 mg/dL\r\nDirect Bilirubin: 0.2 mg/dL\r\nAST (Aspartate Aminotransferase): 20 U/L\r\nALT (Alanine Aminotransferase): 25 U/L\r\nALP (Alkaline Phosphatase): 70 U/L\r\nTotal Protein: 7.0 g/dL\r\nAlbumin: 4.0 g/dL\r\nLipid Panel:\r\n\r\nTotal Cholesterol: 180 mg/dL\r\nTriglycerides: 120 mg/dL\r\nHDL (High-Density Lipoprotein): 50 mg/dL\r\nLDL (Low-Density Lipoprotein): 110 mg/dL\r\nThyroid Function Tests:\r\n\r\nTSH (Thyroid-Stimulating Hormone): 2.5 mIU/L\r\nFree T4 (Thyroxine): 1.2 ng/dL\r\nOther Tests:\r\n\r\nVitamin D (25-hydroxyvitamin D): 30 ng/mL\r\nNotes:\r\nAll values fall within normal ranges. No abnormalities detected. Further interpretation and clinical correlation may be necessary based on individual health status and medical history.','Technician 9','2024-03-11'),(72,205,227,'04:37','Reason for Test: Monitoring cholesterol levels due to family history of heart disease\r\n\r\nMedications or Supplements: Taking birth control pills (Ortho Tri-Cyclen)\r\nMedical History: Family history of heart disease; otherwise, no known medical conditions\r\n','1800.00','2024-03-23','COMPLETED','Alex Berminham','REF-2403120031b194','LIPID_PROFILE','Normal','Test Results:\r\n1. Total Cholesterol: 200 mg/dL (Desirable: <200 mg/dL)\r\n2. LDL Cholesterol (Low-Density Lipoprotein): 130 mg/dL (Optimal: <100 mg/dL)\r\n3. HDL Cholesterol (High-Density Lipoprotein): 50 mg/dL (Desirable: >40 mg/dL)\r\n4. Triglycerides: 150 mg/dL (Normal: <150 mg/dL)\r\n\r\nInterpretation:\r\n- Total Cholesterol: Within desirable range\r\n- LDL Cholesterol: Borderline high\r\n- HDL Cholesterol: Within desirable range\r\n- Triglycerides: Within normal range\r\n\r\nRecommendations:\r\n- Given the borderline high LDL cholesterol level, lifestyle modifications such as dietary changes, exercise, and weight management are recommended to lower cholesterol levels.\r\n- Follow-up testing may be necessary to monitor cholesterol levels and assess the effectiveness of lifestyle changes or medication, if prescribed.\r\n\r\nAdditional Notes:\r\n- The patient fasted for 12 hours prior to the test, as instructed.\r\n- No abnormalities were noted in other laboratory parameters tested concurrently.','Technician 9','2024-03-12'),(73,39,30,'','x','1500.00','2024-02-28','REQUESTED','x','REF-2403120057b3e0','BLOOD_TEST','','','admin','2024-03-12'),(74,220,80,'07:00','Medical History:\r\n\r\nNo history of colorectal cancer or polyps\r\nNo current symptoms, but routine screening recommended due to age and family history.\r\nPurpose of the Test:\r\n\r\nRoutine colorectal cancer screening as recommended by primary care physician.','15000.00','2024-03-06','COMPLETED','Dammika Peiris','REF-240312010433ab','COLONOSCOPY','No abnormalities ','Procedure Findings:\r\n\r\nPreparation Quality: Adequate\r\nCecal Intubation: Achieved\r\nColonoscope Insertion: Complete to the cecum\r\nMucosal Inspection: Normal throughout the colon\r\nPolyps Detected: No polyps identified\r\nBiopsies Taken: No biopsies taken\r\nAssessment:\r\n\r\nColonoscopy Result: Normal\r\nRecommendation: Routine screening colonoscopy in 10 years.\r\nConclusion:\r\nThe colonoscopy was completed successfully, with no abnormalities detected. Based on the findings, routine screening colonoscopy in 10 years is recommended.','Noah Taylor','2024-03-12'),(75,207,234,'14:43','Medical History:\r\n\r\nNo known medical conditions\r\nNo history of blood disorders or anemia\r\nPurpose of the Test:\r\n\r\nRoutine check-up to monitor overall health\r\nNo specific symptoms, just part of regular preventive care','800.00','2024-03-23','COMPLETED','Peter Parker','REF-2403121137f902','HEMOGLOBIN_TEST',' No abnormalities detected.','Hemoglobin Level: 14.5 g/dL\r\nReference Range:\r\nMale: 13.8 - 17.2 g/dL\r\nFemale: 12.1 - 15.1 g/dL\r\nInterpretation: Within normal range for a male adult.\r\n\r\nNext Steps:\r\n\r\nNo further action required at this time.','Evelyn Adams','2024-03-12'),(76,213,30,NULL,'Medical History:\r\n\r\nNo history of abnormal Pap smear results\r\nNo history of cervical cancer or abnormalities\r\nNo current symptoms\r\nPurpose of the Test:\r\n\r\nRoutine screening as recommended by primary care physician.','1000.00','2024-03-22','REQUESTED','Chandler Bing','REF-2403121234e07d','PAP_SMEAR',NULL,NULL,NULL,NULL),(79,206,80,NULL,'I\'m scheduling a glucose test following my recent doctor\'s appointment. I\'ll be fasting for 10 hours prior to the test. I\'m currently taking metformin for type 2 diabetes. No recent illnesses or pregnancy. Family history of diabetes.','1000.00','2024-03-30','REQUESTED','Drake Ramorey','REF-240316132894f4','GLUCOSE_TEST',NULL,NULL,NULL,NULL),(80,215,80,NULL,'Currently not taking any medications affecting thyroid function. No recent illnesses or stress. Not pregnant. Family history of thyroid disorders.','1200.00','2024-03-30','REQUESTED','Drake Ramorey','REF-240316133755c7','TSH_TEST',NULL,NULL,NULL,NULL),(81,208,80,NULL,'None','3000.00','2024-03-30','REQUESTED','Drake Ramorey','REF-24031613371fc8','HIV_TEST',NULL,NULL,NULL,NULL),(82,206,80,NULL,'none','1000.00','2024-03-20','REQUESTED','Drake Ramorey','REF-2403161338d8eb','GLUCOSE_TEST',NULL,NULL,NULL,NULL),(83,206,80,NULL,'none','1000.00','2024-03-29','REQUESTED','Drake Ramorey','REF-2403161340bb18','GLUCOSE_TEST',NULL,NULL,NULL,NULL),(104,206,230,'09:00:00','Blood pressure test','1000.00','2024-03-17','REQUESTED','Dr. Smith','APPT001','BLOOD_TEST',NULL,NULL,NULL,NULL),(105,207,231,'10:00:00','Urine analysis','1000.00','2024-03-17','ADMIN_CONFIRMED','Dr. Johnson','APPT002','URINE_TEST',NULL,NULL,NULL,NULL),(106,208,232,'11:00:00','X-Ray of chest','1000.00','2024-03-18','CON_CONFIRMED','Dr. Lee','APPT003','XRAY',NULL,NULL,NULL,NULL),(107,209,230,'12:00:00','Ultrasound for abdomen','1000.00','2024-03-18','REQUESTED','Dr. Wilson','APPT004','ULTRASOUND',NULL,NULL,NULL,NULL),(108,210,231,'13:00:00','MRI scan for brain','1000.00','2024-03-19','ADMIN_CONFIRMED','Dr. Anderson','APPT005','MRI',NULL,NULL,NULL,NULL),(109,206,232,'14:00:00','CT scan for spine','1000.00','2024-03-19','CON_CONFIRMED','Dr. Brown','APPT006','CT_SCAN',NULL,NULL,NULL,NULL),(110,207,230,'15:00:00','ECG for heart','1000.00','2024-03-20','REQUESTED','Dr. Martin','APPT007','ECG',NULL,NULL,NULL,NULL),(111,208,231,'16:00:00','EEG for brain activity','1000.00','2024-03-20','ADMIN_CONFIRMED','Dr. Miller','APPT008','EEG',NULL,NULL,NULL,NULL),(112,209,232,'17:00:00','EMG for muscle activity','1000.00','2024-03-21','CON_CONFIRMED','Dr. Taylor','APPT009','EMG',NULL,NULL,NULL,NULL),(113,210,230,'09:00:00','Pulmonary function test','1000.00','2024-03-21','REQUESTED','Dr. Harris','APPT010','PFT',NULL,NULL,NULL,NULL),(114,206,231,'10:00:00','Colonoscopy','1000.00','2024-03-22','ADMIN_CONFIRMED','Dr. White','APPT011','COLONOSCOPY',NULL,NULL,NULL,NULL),(115,207,232,'11:00:00','Endoscopy','1000.00','2024-03-22','CON_CONFIRMED','Dr. Young','APPT012','ENDOSCOPY',NULL,NULL,NULL,NULL),(116,208,230,'12:00:00','Mammography','1000.00','2024-03-23','REQUESTED','Dr. Clark','APPT013','MAMMOGRAPHY',NULL,NULL,NULL,NULL),(117,209,231,'13:00:00','Pap smear','1000.00','2024-03-23','ADMIN_CONFIRMED','Dr. Lewis','APPT014','PAP_SMEAR',NULL,NULL,NULL,NULL),(118,210,232,'14:00:00','Prostate-specific antigen test','1000.00','2024-03-24','CON_CONFIRMED','Dr. Adams','APPT015','PSA_TEST',NULL,NULL,NULL,NULL),(119,206,230,'15:00:00','Thyroid-stimulating hormone test','1000.00','2024-03-24','REQUESTED','Dr. King','APPT016','TSH_TEST',NULL,NULL,NULL,NULL),(120,207,231,'16:00:00','Lipid profile','1000.00','2024-03-25','ADMIN_CONFIRMED','Dr. Turner','APPT017','LIPID_PROFILE',NULL,NULL,NULL,NULL),(121,208,232,'17:00:00','Glucose test','1000.00','2024-03-25','CON_CONFIRMED','Dr. Scott','APPT018','GLUCOSE_TEST',NULL,NULL,NULL,NULL),(122,209,230,'09:00:00','Hemoglobin test','1000.00','2024-03-26','REQUESTED','Dr. Green','APPT019','HEMOGLOBIN_TEST',NULL,NULL,NULL,NULL),(123,210,231,'10:00:00','HIV test','1000.00','2024-03-26','ADMIN_CONFIRMED','Dr. Carter','APPT020','HIV_TEST',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-17 12:23:36
