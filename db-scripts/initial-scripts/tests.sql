CREATE TABLE Tests (
    testId INT PRIMARY KEY,
    type VARCHAR(50),
    description VARCHAR(255),
    PreparationInstructions VARCHAR(255),
    cost DECIMAL(10,2),
    ReportReadyIn VARCHAR(50),
    MeasurementUnit VARCHAR(20),
    LowReferenceRange DECIMAL(10,2),
    HighReferenceRange DECIMAL(10,2)
);

INSERT INTO Tests (testId, type, description, PreparationInstructions, cost, ReportReadyIn, MeasurementUnit, LowReferenceRange, HighReferenceRange) VALUES
(1, 'BLOOD_TEST', 'Blood test is a common laboratory test used to evaluate various components of blood.', 'Fasting may be required for 8 hours before the test.', 1500, '24 hours', 'mg/dL', 4.5, 6.2),
(2, 'URINE_TEST', 'Urine test is a diagnostic test used to detect and monitor various medical conditions by analyzing the urine sample.', 'Collect a clean-catch urine sample.', 1000, '24 hours', 'mg/dL', 4.5, 6.2),
(3, 'XRAY', 'X-ray is a non-invasive medical imaging technique used to visualize the internal structures of the body.', 'No special preparation required.', 3000, '2 hours', '-', NULL, NULL),
(4, 'ULTRASOUND', 'Ultrasound is a diagnostic imaging technique that uses high-frequency sound waves to create images of internal organs and tissues.', 'Drink plenty of water and refrain from urinating before the test.', 4000, '48 hours', 'mm', 0.5, 2),
(5, 'MRI', 'MRI (Magnetic Resonance Imaging) is a medical imaging technique used to visualize internal structures of the body in detail.', 'Remove any metal objects and inform the technician of any implants or medical devices.', 10000, '72 hours', '-', NULL, NULL),
(6, 'CT_SCAN', 'CT scan (Computed Tomography) is a medical imaging technique used to create detailed cross-sectional images of the body.', 'May require fasting, and contrast dye may be administered.', 6000, '24 hours', '-', NULL, NULL),
(7, 'ECG', 'ECG (Electrocardiogram) is a medical test used to measure the electrical activity of the heart over a period of time.', 'No special preparation required.', 800, '1 hour', '-', NULL, NULL),
(8, 'EEG', 'EEG (Electroencephalogram) is a medical test used to record electrical activity in the brain, typically to diagnose neurological disorders.', 'Wash your hair before the test and avoid caffeine before the appointment.', 2500, '48 hours', '-', NULL, NULL),
(9, 'EMG', 'EMG (Electromyogram) is a medical test used to assess the health of muscles and nerve cells that control them.', 'No special preparation required.', 2000, '48 hours', '-', NULL, NULL),
(10, 'PFT', 'PFT (Pulmonary Function Test) is a group of tests used to assess the function of the lungs and how well they are working.', 'Avoid smoking and strenuous exercise before the test.', 1200, '24 hours', 'mL/min', 80, 120),
(11, 'COLONOSCOPY', 'Colonoscopy is a medical procedure used to examine the inside of the colon and rectum for abnormalities.', 'Follow specific dietary restrictions and bowel preparation instructions provided by your healthcare provider.', 15000, '72 hours', '-', NULL, NULL),
(12, 'ENDOSCOPY', 'Endoscopy is a medical procedure used to examine the inside of the body, typically the digestive tract, using an endoscope.', 'Follow specific dietary restrictions and fasting instructions provided by your healthcare provider.', 12000, '48 hours', '-', NULL, NULL),
(13, 'MAMMOGRAPHY', 'Mammography is a screening test used to detect breast cancer early, when it is most treatable.', 'Avoid using deodorants, lotions, or powders on the day of the test.', 2000, '48 hours', '-', NULL, NULL),
(14, 'PAP_SMEAR', 'Pap smear is a screening test used to detect cervical cancer and precancerous changes in the cervix.', 'Avoid intercourse, douching, or using vaginal creams or medications 24 hours before the test.', 1000, '48 hours', '-', NULL, NULL),
(15, 'PSA_TEST', 'PSA test is a blood test used to screen for prostate cancer.', 'No special preparation required.', 1500, '24 hours', 'ng/mL', 0, 4),
(16, 'TSH_TEST', 'TSH test is a blood test used to evaluate thyroid function.', 'No special preparation required.', 1200, '24 hours', 'uIU/mL', 0.5, 5),
(17, 'LIPID_PROFILE', 'Lipid profile is a group of tests used to measure cholesterol and triglyceride levels in the blood.', 'Fasting may be required for 8-12 hours before the test.', 1800, '24 hours', 'mg/dL', 70, 200),
(18, 'GLUCOSE_TEST', 'Glucose test is a blood test used to measure blood sugar levels and diagnose diabetes.', 'Fasting may be required for 8-12 hours before the test.', 1000, '24 hours', 'mg/dL', 70, 140),
(19, 'HEMOGLOBIN_TEST', 'Hemoglobin test is a blood test used to measure the amount of hemoglobin in the blood.', 'No special preparation required.', 800, '24 hours', 'g/dL', 12, 16),
(20, 'HIV_TEST', 'HIV test is a diagnostic test used to detect HIV antibodies or antigens in the blood.', 'No special preparation required.', 3000, '48 hours', '-', NULL, NULL);
