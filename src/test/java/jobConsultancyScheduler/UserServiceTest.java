package jobConsultancyScheduler;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;
import java.sql.SQLException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.service.UserService;

@TestMethodOrder(MethodOrderer.MethodName.class)
class UserServiceTest {

	public static int userID;

	public String conEmail = "testConsultanr" + System.currentTimeMillis() + "@example.com";
	public String userPassword = "AAAAAAAAAAAAAAAAAAAAAPCnP9q27gAMPp7pUfUnlWY941b+eCi02fUBhmpN5D0/";
	public String userEmail = "testUser" + System.currentTimeMillis() + "@example.com";


	@Test
	@DisplayName("Register User and Consultant")
	void testA() throws ClassNotFoundException, SQLException {
		// Register a user
		User user = new User();
		user.setName("User Name");
		user.setEmail(userEmail);
		user.setPhoneNumber("0766786227");
		user.setPassword(userPassword);
		user.setBirthdate("1992-03-20");
		user.setGender("Female");
		user.setAccessRight(AccessRight.ROLE_USER);
		user.setRegistrationStatus(RegistrationStatus.APPROVED);
		user.setRegistrationDate(new Date(2024 - 01 - 22));

		// Register a consultant
		User consultant = new User();
		consultant.setName("Consultant Name");
		consultant.setEmail(conEmail);
		consultant.setPhoneNumber("0766786228");
		consultant.setPassword(userPassword);
		consultant.setBirthdate("1988-07-10");
		consultant.setGender("Male");
		consultant.setEducationalQualifications("Master's in IT Consulting");
		consultant.setSpecializedJobs("IT Consulting,Project Management");
		consultant.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		consultant.setRegistrationStatus(RegistrationStatus.PENDING);
		consultant.setRegistrationDate(new Date(2024 - 01 - 23));

		UserService userService = UserService.getUserService();

		// Register the user
		boolean userResult = false;
		try {
			userResult = userService.addUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Register the consultant
		boolean consultantResult = false;
		try {
			consultantResult = userService.addUser(consultant);
		} catch (Exception e) {
			e.printStackTrace();
		}

		assertTrue(userResult, "User registration should be successful");
		assertTrue(consultantResult, "Consultant registration should be successful");
	}

	@Test
	@DisplayName("Register User and Consultant with Duplicate Email")
	void testB() throws ClassNotFoundException, SQLException {
		// Register a user
		User user = new User();
		user.setName("User Name");
		user.setEmail(userEmail);
		user.setPhoneNumber("0766786227");
		user.setPassword(userPassword);
		user.setBirthdate("1992-03-20");
		user.setGender("Female");
		user.setAccessRight(AccessRight.ROLE_USER);
		user.setRegistrationStatus(RegistrationStatus.APPROVED);
		user.setRegistrationDate(new Date(2024 - 01 - 22));

		// Register a consultant with the same email as the user
		User consultant = new User();
		consultant.setName("Consultant Name");
		consultant.setEmail(userEmail); 
		consultant.setPhoneNumber("0766786228");
		consultant.setPassword(userPassword);
		consultant.setBirthdate("1988-07-10");
		consultant.setGender("Male");
		consultant.setEducationalQualifications("Master's in IT Consulting");
		consultant.setSpecializedJobs("IT Consulting,Project Management");
		consultant.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		consultant.setRegistrationStatus(RegistrationStatus.PENDING);
		consultant.setRegistrationDate(new Date(2024 - 01 - 23));

		UserService userService = UserService.getUserService();

		// Register the user
		boolean userResult = false;
		try {
			userResult = userService.addUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Register the consultant
		boolean consultantResult = false;
		try {
			consultantResult = userService.addUser(consultant);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Assert that the user registration was successful
		assertTrue(userResult, "User registration should be successful");

		// Assert that the consultant registration failed due to duplicate email
		assertFalse(consultantResult, "Consultant registration should fail due to duplicate email");
	}

	/*
	 * @Test
	 * 
	 * @DisplayName("Register As A Consultant") void testB() throws
	 * ClassNotFoundException, SQLException {
	 * 
	 * User user = new User(); user.setName("Test Name"); user.setEmail(conEmail);
	 * user.setPhoneNumber("0766786225"); user.setPassword(userPassword);
	 * user.setBirthdate("1990-01-01"); // Set the birthdate according to your needs
	 * user.setGender("Male"); // Set the gender according to your needs
	 * user.setOccupation("Tester"); // Set the occupation according to your needs
	 * user.setCountry("United Kingdom");
	 * user.setEducationalQualifications("Bachelor's in Testing"); // Set
	 * educational qualifications
	 * user.setSpecializedCountries("United Kingdom,USA"); // Set specialized
	 * countries user.setSpecializedJobs("Testing,QA"); // Set specialized jobs
	 * user.setAvailableDays("Monday,Wednesday"); // Set available days
	 * user.setAvailableTimeSlots("Morning,Afternoon"); // Set available time slots
	 * user.setAccessRight(AccessRight.ROLE_CONSULTANT);
	 * user.setRegistrationStatus(RegistrationStatus.PENDING);
	 * user.setRegistrationDate(new Date(2024-01-20));
	 * 
	 * UserService userService = UserService.getUserService();
	 * 
	 * boolean result = false; try { result = userService.addUser(user); } catch
	 * (Exception e) { e.printStackTrace(); }
	 * 
	 * assertTrue(result, "This should register the user into the database"); }
	 */

	/*
	 * @Test
	 * 
	 * @DisplayName("Try To Register An Admin For An Existing Email") void testB()
	 * throws ClassNotFoundException { Admin admin = new Admin();
	 * admin.setName("Test Name"); admin.setEmail(userEmail);
	 * admin.setNumber("0766786225"); admin.setPassword(userPassword);
	 * admin.setField("Cybersecurity"); admin.setState("active");
	 * admin.setCountry("United Kingdom");
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * try { adminService.addAdmin(admin);
	 * 
	 * } catch (MysqlDataTruncation e) { assertEquals(MysqlDataTruncation.class,
	 * e.getClass(), "Expected exception was not thrown."); } catch (SQLException e)
	 * { assertEquals(SQLIntegrityConstraintViolationException.class, e.getClass(),
	 * "Expected exception was not thrown."); }
	 * 
	 * }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Admin Login") void testC() throws ClassNotFoundException,
	 * SQLException { final String email = userEmail; final String password =
	 * userPassword;
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * Admin admin = adminService.loginAdmin(email, password);
	 * System.out.println(admin.getId()); adminID = admin.getId();
	 * 
	 * if (!(admin.getId() > 0)) { admin = null; }
	 * 
	 * assertNotNull(admin, "This should login the user"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Admin With Invalid Password") void testD() throws
	 * ClassNotFoundException, SQLException { final String email = userEmail; final
	 * String password = "igiuiags687687ahdkjhk";
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * Admin admin = adminService.loginAdmin(email, password);
	 * 
	 * if (!(admin.getId() > 0)) { admin = null; } assertNull(admin,
	 * "This should fail login"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Admin Login With Invalid Email") void testE() throws
	 * ClassNotFoundException, SQLException { final String email =
	 * "wrong@gmail.com"; final String password = userPassword;
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * Admin admin = adminService.loginAdmin(email, password);
	 * System.out.println(admin.getId());
	 * 
	 * if (!(admin.getId() > 0)) { admin = null; } assertNull(admin,
	 * "This should fail login"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Get Admin By Id") void testF() throws ClassNotFoundException,
	 * SQLException {
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * Admin admin = adminService.fetchSingleAdmin(adminID);
	 * 
	 * if (!(admin.getId() > 0)) { admin = null; } assertNotNull(admin,
	 * "This should get the admin by id"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Get All Job Seekers") void testG() throws
	 * ClassNotFoundException, SQLException {
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * List<Admin> result = adminService.fetchAllAdmins(); boolean haveData = true;
	 * 
	 * if (!(result.size() > 0)) { haveData = false; }
	 * 
	 * assertTrue(haveData, "This should get all the admins"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Edit An Admin") void testH() throws ClassNotFoundException,
	 * SQLException { Admin admin = new Admin(); admin.setName("Test Name");
	 * admin.setEmail(userEmail); admin.setNumber("0766786225");
	 * admin.setPassword(userPassword); admin.setField("Cybersecurity");
	 * admin.setState("active"); admin.setCountry("United Kingdom");
	 * admin.setId(adminID);
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * boolean result = adminService.editAdmin(admin);
	 * 
	 * assertTrue(result, "This should edit the admin"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Change Admin State") void testI() throws
	 * ClassNotFoundException, SQLException {
	 * 
	 * Admin admin = new Admin(); admin.setId(adminID); admin.setState("inactive");
	 * 
	 * AdminService adminService = AdminService.getAdminService(); boolean result =
	 * adminService.changeAdminState(admin); assertTrue(result,
	 * "This should change state of the admin"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Delete An Admin") void testJ() throws ClassNotFoundException,
	 * SQLException { System.out.println(adminID); AdminService adminService =
	 * AdminService.getAdminService();
	 * 
	 * boolean result = adminService.deleteAdmin(adminID);
	 * 
	 * assertTrue(result, "This should delete the user"); }
	 * 
	 * 
	 * @Test
	 * 
	 * @DisplayName("Get Admin By Non Existing Id") void testK() throws
	 * ClassNotFoundException, SQLException {
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * Admin admin = adminService.fetchSingleAdmin(adminID);
	 * 
	 * if (!(admin.getId() > 0)) { admin = null; } assertNull(admin,
	 * "This should retirn null"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Edit An Admin For A Non Existing Id") void testL() throws
	 * ClassNotFoundException, SQLException { Admin admin = new Admin();
	 * admin.setName("Test Name"); admin.setEmail(userEmail);
	 * admin.setNumber("0766786225"); admin.setPassword(userPassword);
	 * admin.setField("Cybersecurity"); admin.setState("active");
	 * admin.setCountry("United Kingdom"); admin.setId(adminID);
	 * 
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * boolean result = adminService.editAdmin(admin);
	 * 
	 * assertFalse(result, "This should return false"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Change Admin State For A Non Existing Id") void testM() throws
	 * ClassNotFoundException, SQLException {
	 * 
	 * Admin admin = new Admin(); admin.setId(adminID); admin.setState("inactive");
	 * 
	 * AdminService adminService = AdminService.getAdminService(); boolean result =
	 * adminService.changeAdminState(admin); assertFalse(result,
	 * "This should return false"); }
	 * 
	 * @Test
	 * 
	 * @DisplayName("Delete An Non Existing Admin") void testN() throws
	 * ClassNotFoundException, SQLException { System.out.println(adminID);
	 * AdminService adminService = AdminService.getAdminService();
	 * 
	 * boolean result = adminService.deleteAdmin(adminID);
	 * 
	 * assertFalse(result, "This should return falser"); }
	 */
}
