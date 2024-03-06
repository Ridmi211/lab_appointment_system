package com.labSchedulerSystem.service;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.logging.Logger;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import com.labSchedulerSystem.controller.UserController;
import com.labSchedulerSystem.dao.UserManager;
import com.labSchedulerSystem.dao.UserManagerImpl;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;

public class UserService implements UserManager {

	private static UserService appointmentServiceObj;

	public UserService() {
	}

	public synchronized static UserService getUserService() {

		if (appointmentServiceObj == null) {
			appointmentServiceObj = new UserService();
		}

		return appointmentServiceObj;
	}

	private UserManager getUserManager() {
		return new UserManagerImpl();
	}
	private static final Logger LOGGER = Logger.getLogger(UserManager.class.getName());
	
	 public boolean addUser(User user) throws ClassNotFoundException, SQLException
	 {
	if (isEmailAlreadyExists(user.getEmail())) {
	 System.out.println("ERROR: Attempted to add a user with a duplicate email: "
	 + user.getEmail()); return false; } return getUserManager().addUser(user); }
	
	public boolean editUser(User user) throws ClassNotFoundException, SQLException {
		return getUserManager().editUser(user);
	}

	public boolean deleteUser(int userId) throws ClassNotFoundException, SQLException {
		return getUserManager().deleteUser(userId);
	}

	public User fetchSingleUser(int userId) throws ClassNotFoundException, SQLException {
		return getUserManager().fetchSingleUser(userId);
	}

	public List<User> fetchAllUsers() throws ClassNotFoundException, SQLException {
		return getUserManager().fetchAllUsers();
	}

	public int getAllUsersCount() throws ClassNotFoundException, SQLException {
		return getUserManager().fetchAllUsers().size();
	}

	public User fetchUserByEmail(String email) throws ClassNotFoundException, SQLException {
		return getUserManager().fetchUserByEmail(email);
	}

	public boolean isEmailAlreadyExists(String email) throws ClassNotFoundException, SQLException {
		return getUserManager().isEmailAlreadyExists(email);
	}

	public List<User> fetchAllConsultantUsers() throws SQLException, ClassNotFoundException {
		return getUserManager().fetchAllConsultantUsers();
	}

	public boolean updateRegistrationStatus(int userId, RegistrationStatus status)
			throws SQLException, ClassNotFoundException {
		return getUserManager().updateRegistrationStatus(userId, status);
	}

	public boolean approveUser(int userId) throws ClassNotFoundException, SQLException {
		return getUserManager().updateRegistrationStatus(userId, RegistrationStatus.APPROVED);
	}

	public boolean rejectUser(int userId) throws ClassNotFoundException, SQLException {
		return getUserManager().updateRegistrationStatus(userId, RegistrationStatus.REJECTED);
	}

	public List<User> fetchPendingUsers() throws SQLException, ClassNotFoundException {
		return getUserManager().fetchPendingUsers();
	}

	public int getPendingUsersCount() throws ClassNotFoundException, SQLException {
		return getUserManager().fetchPendingUsers().size();
	}

	public static boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
		return email.matches(emailRegex);
	}

	public static String hashPassword(String plainPassword) {
		byte[] salt = generateSalt();
		int iterations = 10000;

		int keyLength = 256;

		char[] passwordChars = plainPassword.toCharArray();
		PBEKeySpec spec = new PBEKeySpec(passwordChars, salt, iterations, keyLength);
		try {
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
			byte[] hash = skf.generateSecret(spec).getEncoded();
			byte[] combined = new byte[salt.length + hash.length];
			System.arraycopy(salt, 0, combined, 0, salt.length);
			System.arraycopy(hash, 0, combined, salt.length, hash.length);

			return Base64.getEncoder().encodeToString(combined);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static byte[] generateSalt() {

		byte[] salt = new byte[16];

		return salt;
	}

	public void sendDeleteEmail(User user) {
		String subject = "Account Deletion";
		String messageBody = "Dear " + user.getName() + ",\n\nYour account has been deleted!";
		EmailService.sendEmail(user.getEmail(), subject, messageBody);
	}

	public static boolean sendRegistrationEmail(User user) {
	    String subject = "Welcome to MediCheck Laboratory Services";
	    String body = "Dear " + user.getName() + ",\n\n"
	            + "Thank you for choosing MediCheck Laboratory Services to explore our comprehensive range of medical tests and services. We are delighted to welcome you to our community.\n\n"
	            + "Your account registration has been successfully completed.\n\n" + "Account Details:\n" + "Name: "
	            + user.getName() + "\n" + "Email: " + user.getEmail() + "\n" + "User Type: " + user.getAccessRight()
	            + "\n\n"
	            + "Please keep your login credentials secure. You can now access our platform to schedule your tests and manage your health appointments.\n\n"
	            + "If you have any questions or require assistance, please feel free to reach out to our dedicated team of laboratory technicians.\n\n"
	            + "Best regards,\n" + "The MediCheck Laboratory Services Team";
	    try {
	        EmailService.sendEmail(user.getEmail(), subject, body);
	        LOGGER.info("Registration email sent successfully to: " + user.getEmail());
	         
	    } catch (Exception e) {
	        e.printStackTrace();
	        LOGGER.severe("Failed to send registration email to: " + user.getEmail());	          
	    }
	    return false;
	}

	public static boolean sendConsultantRegistrationEmail(User consultant) {
		 String subject = "Welcome to MediCheck Laboratory Services - Technician Registration Confirmation";
		    String body = "Dear " + consultant.getName() + ",\n\n"
		            + "Congratulations on successfully registering as a technician with MediCheck Laboratory Services. We are delighted to welcome you to our team dedicated to providing accurate and reliable medical tests.\n\n"
		            + "Your registration status is currently pending approval. Our team will review your qualifications and expertise to ensure the highest quality of service to our patients.\n\n"
		            + "Technician Details:\n" + "Name: " + consultant.getName() + "\n" + "Email: " + consultant.getEmail()
		            + "\n" + "Specializations: " + consultant.getSpecializedJobs() + "\n" + "Qualifications: " + consultant.getEducationalQualifications() +  "\n\n" +
		            "We will notify you as soon as your registration is approved, and you can start conducting tests and assisting patients on their healthcare journey.\n\n"
		            + "If you have any questions or need further information, please feel free to contact our support team at [Support Email Address].\n\n"
		            + "Thank you for choosing to be a part of MediCheck Laboratory Services.\n\n" + "Best regards,\n"
		            + "The MediCheck Laboratory Services Team";
		try {
			EmailService.sendEmail(consultant.getEmail(), subject, body);
			 LOGGER.info("Technician registration email sent successfully to: " + consultant.getEmail());
		} catch (Exception e) {
			LOGGER.severe("Failed to send technician registration email to: " + consultant.getEmail());
		       
			e.printStackTrace();
		}
		return false;
	}

	public static void sendApprovalEmail(User consultant) {
	    String subject = "Congratulations! Your Technician Registration Has Been Approved";
	    String messageBody = "Dear " + consultant.getName() + ",\n\n"
	            + "We are delighted to inform you that your technician registration with MediCheck Laboratory Services has been approved!\n\n"
	            + "You are now an official member of our team and can begin conducting tests and assisting patients on their healthcare journey.\n\n"
	            + "Technician Details:\n" + "Name: " + consultant.getName() + "\n" + "Email: " + consultant.getEmail()
	            + "\n" + "Specializations: " + consultant.getSpecializedJobs() + "\n" + "Qualifications: " + consultant.getEducationalQualifications() +  "\n\n" +
	            "Considering your qualifications, we have assigned you to perform " + consultant.getSelectedTestType().getDisplayName() + " tests.\n\n" +
	            "If you have any questions or need assistance, please feel free to contact our support team at [Support Email Address].\n\n"
	            + "Thank you for choosing to be a part of MediCheck Laboratory Services.\n\n" + "Best regards,\n"
	            + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(consultant.getEmail(), subject, messageBody);
	}

	public static void sendRejectionEmail(User user) {
		 String subject = "Registration Rejection";
		    String messageBody = "Dear " + user.getName() + ",\n\n"
		            + "We regret to inform you that your registration with MediCheck Laboratory Services has been rejected.\n\n"
		            + "Rejection Reason:\n"
		            + "Unfortunately, your registration did not meet our current requirements. We encourage you to review your profile and qualifications to better align with our laboratory's needs.\n\n"
		            + "Suggestions for Improvement:\n"
		            + "1. Enhance your professional qualifications and expertise in your specialization areas.\n"
		            + "2. Update your availability for greater flexibility.\n"
		            + "3. Provide more comprehensive information in your profile.\n\n"
		            + "We appreciate your interest in joining our team and encourage you to reapply once you have made the necessary improvements. Our doors are always open to dedicated professionals like you.\n\n"
		            + "If you have any questions or need further information, please feel free to contact our support team at [Support Email Address].\n\n"
		            + "Thank you for considering MediCheck Laboratory Services, and we look forward to receiving your improved application in the future.\n\n"
		            + "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(user.getEmail(), subject, messageBody);
	}
}
