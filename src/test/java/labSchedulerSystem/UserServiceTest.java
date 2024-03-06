package labSchedulerSystem;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.labSchedulerSystem.dao.UserManagerImpl;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.Test.TestType;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.service.UserService;

class UserServiceTest {

	private UserService userService;
	private UserManagerImpl userMangerImpl;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private RequestDispatcher requestDispatcher;
	private int addedUserId;
	private int addedTechnicianId;
	private int updateId;

	@BeforeEach
	void setUp() {
		userService = new UserService();
		userMangerImpl = new UserManagerImpl();
		request = mock(HttpServletRequest.class);
		response = mock(HttpServletResponse.class);
		requestDispatcher = mock(RequestDispatcher.class);
		userService = spy(new UserService());
	}

	@Test
	void testAddUser() throws ServletException, IOException, SQLException, ClassNotFoundException {
		User user = new User();
		user.setName("John Doe");
		user.setEmail("john55@example.com");
		user.setPassword("password");
		user.setBirthdate("1990-01-01");
		user.setGender("Male");
		user.setAccessRight(AccessRight.ROLE_USER);
		user.setRegistrationStatus(RegistrationStatus.APPROVED);
		user.setEducationalQualifications("Bachelor's degree");
		user.setSpecializedJobs("Software Engineer");
		user.setSelectedTestType(TestType.DEFAULT);
		user.setRegistrationDate(new Date());
		when(request.getParameter("name")).thenReturn(user.getName());
		when(request.getParameter("telephone")).thenReturn("");
		when(request.getParameter("email")).thenReturn(user.getEmail());
		when(request.getParameter("password")).thenReturn(user.getPassword());
		when(request.getParameter("birthdate")).thenReturn(user.getBirthdate());
		when(request.getParameter("gender")).thenReturn(user.getGender());
		when(request.getParameter("usertype")).thenReturn(AccessRight.ROLE_USER.toString());
		when(request.getParameter("educationalQualifications")).thenReturn(user.getEducationalQualifications());
		when(request.getParameter("specializedJobs")).thenReturn(user.getSpecializedJobs());
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.isEmailAlreadyExists(user.getEmail())).thenReturn(false);
		when(mockedUserService.addUser(user)).thenReturn(true);
		boolean result = userService.addUser(user);
		user = userMangerImpl.fetchUserByEmail("john55@example.com");
		addedUserId = user.getUserId();
		assertTrue(result, "User should be added successfully");
	}

	@Test
	void testAddTechnician() throws SQLException, ClassNotFoundException {
		User technician = new User();
		technician.setName("Alice Technician");
		technician.setEmail("alic@example.com");
		technician.setPassword("password");
		technician.setBirthdate("1985-03-15");
		technician.setGender("Female");
		technician.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		technician.setRegistrationStatus(RegistrationStatus.PENDING);
		technician.setEducationalQualifications("Bachelor's degree in Computer Science");
		technician.setSpecializedJobs("IT Technician");
		technician.setSelectedTestType(TestType.DEFAULT);
		technician.setRegistrationDate(new Date());
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.isEmailAlreadyExists(technician.getEmail())).thenReturn(false);
		when(mockedUserService.addUser(technician)).thenReturn(true);
		boolean result = userService.addUser(technician);
		assertTrue(result, "Technician should be added successfully");
	}

	@Test
	void testAddUserForDuplicateEmail() throws SQLException, ClassNotFoundException {
		User technician = new User();
		technician.setName("Alice Technician");
		technician.setEmail("alice442@example.com");
		technician.setPassword("password");
		technician.setBirthdate("1985-03-15");
		technician.setGender("Female");
		technician.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		technician.setRegistrationStatus(RegistrationStatus.PENDING);
		technician.setEducationalQualifications("Bachelor's degree in Computer Science");
		technician.setSpecializedJobs("IT Technician");
		technician.setSelectedTestType(TestType.DEFAULT);
		technician.setRegistrationDate(new Date());
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.isEmailAlreadyExists(technician.getEmail())).thenReturn(false);
		when(mockedUserService.addUser(technician)).thenReturn(true);
		boolean result = userService.addUser(technician);
		assertTrue(result, "Technician should be added successfully");
	}

	@Test
	void testAddUser_DuplicateEmail() throws SQLException, ClassNotFoundException {
		User technician = new User();
		technician.setName("Alice Technician");
		technician.setEmail("alice442@example.com"); // Duplicate email
		technician.setPassword("password");
		technician.setBirthdate("1985-03-15");
		technician.setGender("Female");
		technician.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		technician.setRegistrationStatus(RegistrationStatus.PENDING);
		technician.setEducationalQualifications("Bachelor's degree in Computer Science");
		technician.setSpecializedJobs("IT Technician");
		technician.setSelectedTestType(TestType.DEFAULT);
		technician.setRegistrationDate(new Date());
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.isEmailAlreadyExists(technician.getEmail())).thenReturn(true);
		when(mockedUserService.addUser(technician)).thenReturn(false);
		boolean result = userService.addUser(technician);
		assertFalse(result, "User with duplicated email should not be added");
	}

	@Test
	void testEditUser() throws SQLException, ClassNotFoundException {
		User user3 = new User();
		user3 = userMangerImpl.fetchUserByEmail("alice442@example.com");
		updateId = user3.getUserId();
		user3.setUserId(updateId);
		user3.setEmail("alice442@example.com");
		user3.setName("Alice Technician");
		user3.setPhoneNumber("747474");
		user3.setBirthdate("1985-03-15");
		user3.setGender("Female");
		user3.setAccessRight(AccessRight.ROLE_TECHNITIAN);
		user3.setRegistrationStatus(RegistrationStatus.PENDING);
		user3.setEducationalQualifications("Bachelor's degree in Computer Science");
		user3.setSpecializedJobs("IT Technician");
		user3.setSelectedTestType(TestType.DEFAULT);
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.editUser(user3)).thenReturn(true);
		boolean result = userService.editUser(user3);
		assertTrue(result, "User should be edited successfully");
	}

	@Test
	void testFetchAllUsers() throws SQLException, ClassNotFoundException {
		List<User> expectedUsers = new ArrayList<>();
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.fetchAllUsers()).thenReturn(expectedUsers);
		List<User> actualUsers = mockedUserService.fetchAllUsers();
		assertNotNull(actualUsers, "Fetched users should not be null");
		assertEquals(expectedUsers.size(), actualUsers.size(), "Number of fetched users should match");
	}

	@Test
	void testDeleteUser() throws SQLException, ClassNotFoundException {
		User user2 = new User();
		user2 = userMangerImpl.fetchUserByEmail("alic@example.com");
		addedTechnicianId = user2.getUserId();
		int userId = addedTechnicianId;
		UserService mockedUserService = mock(UserService.class);
		when(mockedUserService.deleteUser(userId)).thenReturn(true);
		boolean result = userService.deleteUser(userId);
		assertTrue(result, "User should be deleted successfully");
	}

	@AfterEach
	void tearDown() {
		try {
			if (addedUserId != 0) {
				boolean result = userService.deleteUser(addedUserId);
				assertTrue(result, "User should be deleted successfully");
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
