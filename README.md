# lab_appointment_system

Introduction
Welcome to the technical documentation for the ABC Laboratories Appointment System. This document provides a detailed overview of the system architecture, technologies used, deployment process, and security considerations. 

Audience
•	Developers 
•	System Administrators 

 System Overview
The system is built on a three-tier architecture consisting of:
•	Presentation Layer: Implemented using HTML, CSS, JSP, and Bootstrap for frontend development.
•	Application Layer: Developed using Java with the Spring MVC framework and Java Servlets for backend logic and business processes.
•	Data Layer: Utilizes a MySQL database for storing appointment details, user information, test records etc. 

Key components and modules in the system include.
1.	User Management: Handles user registration, authentication, and profile management.
2.	Appointment Booking: Allows patients to schedule test appointments.
3.	Admin Dashboard: Administration can oversee and manage users and appointments.
4.	Technician Dashboard: Technicians can manage their appointments
5.	Reporting: Generates reports for administration decision-making.

Project Structure
•	/labSchedulerSystem/src/main/java/: Contains the source code files for the Lab Appointment System.
•	/labSchedulerSystem/src/test/java/: Includes the unit tests, integration tests, and end-to-end tests for the system.
•	/labSchedulerSystem/docs/: Contains documentation files related to the project.
•	.github/: Includes GitHub Actions workflows for continuous integration and deployment.

Technologies Used
1.	Java: 
2.	HTML, CSS, JavaScript: 
3.	Spring Framework:
4.	Bootstrap:
5.	MySQL: 
6.	Chart.js: 
7.	Font Awesome: 
8.	SLF4J Logging: 
9.	Maven: 

Installation and Setup

Prerequisites
Ensure the following prerequisites are met.
•	Java Development Kit (JDK)
•	Apache Tomcat Server
•	MySQL Database Server
•	Integrated Development Environment (IDE) like Eclipse or IntelliJ

Configuration
Database Configuration
Configure the database connection details in the application's configuration files, specifying the JDBC URL, username, and password.

Email Configuration
Configure email services to enable appointment notifications, including SMTP server settings. Add your email address and password to enable email sending

Design Patterns
Singleton
Factory

Logging and Monitoring
Logging is implemented using SLF4J with Logback as the logging framework. Log files capture system events, errors, and debug information.

Testing Approach
The ABC Laboratories Appointment System follows a comprehensive testing approach to ensure the reliability and functionality of the application. Unit tests are conducted using JUnit to validate individual components and ensure proper integration. 

 Version Control
Git Repository
A public GitHub repository was created for the software project. 
The repository URL: https://github.com/Ridmi211/lab_appointment_system.git 

Workflow Demonstration
 Branches
•	main: Contains the stable version of the application.
•	feature: Branches created for developing specific features.
•	dev: Feature branches are initially merged to this.
Pull Requests
•	Pull requests are used to review and merge changes into the dev and main branches.
