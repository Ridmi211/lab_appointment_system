CREATE TABLE User (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    phoneNumber VARCHAR(15),
    email VARCHAR(100),
    password VARCHAR(255),
    birthdate DATE,
    gender VARCHAR(10),
    accessRight VARCHAR(20),
    educationalQualifications VARCHAR(255),
    specializedJobs VARCHAR(255),
    registrationDate DATE,
    registrationStatus VARCHAR(20),
    selectedTestType VARCHAR(50)
);

INSERT INTO User (name, phoneNumber, email, password, birthdate, gender, accessRight, educationalQualifications, specializedJobs, registrationDate, registrationStatus, selectedTestType) VALUES
('admin', '94713558091', 'admin@gmail.com', 'AAAAAAAAAAAAAAAAAAAAAPCnP9q27gAMPp7pUfUnlWY941b+eCi02fUBhmpN5D0/', '2024-03-12', 'Male','ROLE_ADMIN',null, null, '2024-03-01', 'APPROVED', 'DEFAULT')
