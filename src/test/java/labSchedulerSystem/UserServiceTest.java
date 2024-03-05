package labSchedulerSystem;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.Test.TestType;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.service.UserService;


class UserServiceTest {

    private UserService userService;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() {
        userService = new UserService();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        requestDispatcher = mock(RequestDispatcher.class);
        userService = spy(new UserService());
    }

    @Test
    void testAddUser() throws ServletException, IOException, SQLException, ClassNotFoundException {
        // Prepare test data
        User user = new User();
        user.setName("John Doe");
        user.setEmail("john@example.com");
        user.setPassword("password");
        user.setBirthdate("1990-01-01");
        user.setGender("Male");
        user.setAccessRight(AccessRight.ROLE_USER);
        user.setRegistrationStatus(RegistrationStatus.APPROVED);
        user.setEducationalQualifications("Bachelor's degree");
        user.setSpecializedJobs("Software Engineer");
        user.setSelectedTestType(TestType.DEFAULT);
        user.setRegistrationDate(new Date());

        // Mock request parameters
        when(request.getParameter("name")).thenReturn(user.getName());
        when(request.getParameter("telephone")).thenReturn("");
        when(request.getParameter("email")).thenReturn(user.getEmail());
        when(request.getParameter("password")).thenReturn(user.getPassword());
        when(request.getParameter("birthdate")).thenReturn(user.getBirthdate());
        when(request.getParameter("gender")).thenReturn(user.getGender());
        when(request.getParameter("usertype")).thenReturn(AccessRight.ROLE_USER.toString());
        when(request.getParameter("educationalQualifications")).thenReturn(user.getEducationalQualifications());
        when(request.getParameter("specializedJobs")).thenReturn(user.getSpecializedJobs());

        // Mock UserService dependencies if needed
        UserService mockedUserService = mock(UserService.class);
        when(mockedUserService.isEmailAlreadyExists(user.getEmail())).thenReturn(false);
        when(mockedUserService.addUser(user)).thenReturn(true);

        // Execute the method under test
        boolean result = userService.addUser(user);

        // Verify behavior
        assertTrue(result, "User should be added successfully");
    }
    
    
    @Test
    void testAddTechnician() throws SQLException, ClassNotFoundException {
        // Prepare test data for technician
        User technician = new User();
        technician.setName("Alice Technician");
        technician.setEmail("alice@example.com");
        technician.setPassword("password");
        technician.setBirthdate("1985-03-15");
        technician.setGender("Female");
        technician.setAccessRight(AccessRight.ROLE_TECHNITIAN); // Set role to ROLE_TECHNICIAN
        technician.setRegistrationStatus(RegistrationStatus.PENDING); // Technicians have pending status initially
        technician.setEducationalQualifications("Bachelor's degree in Computer Science");
        technician.setSpecializedJobs("IT Technician");
        technician.setSelectedTestType(TestType.DEFAULT);
        technician.setRegistrationDate(new Date());

        // Mock UserService dependencies if needed
        UserService mockedUserService = mock(UserService.class);
        when(mockedUserService.isEmailAlreadyExists(technician.getEmail())).thenReturn(false);
        when(mockedUserService.addUser(technician)).thenReturn(true);

        // Execute the method under test
        boolean result = userService.addUser(technician);

        // Verify behavior
        assertTrue(result, "Technician should be added successfully");
    }
    

    @Test
    void testAddUser_DuplicateEmail() throws SQLException, ClassNotFoundException {
        // Prepare test data for technician
        User technician = new User();
        technician.setName("Alice Technician");
        technician.setEmail("alice@example.com"); // Duplicate email
        technician.setPassword("password");
        technician.setBirthdate("1985-03-15");
        technician.setGender("Female");
        technician.setAccessRight(AccessRight.ROLE_TECHNITIAN);
        technician.setRegistrationStatus(RegistrationStatus.PENDING);
        technician.setEducationalQualifications("Bachelor's degree in Computer Science");
        technician.setSpecializedJobs("IT Technician");
        technician.setSelectedTestType(TestType.DEFAULT);
        technician.setRegistrationDate(new Date());

        // Mock UserService dependencies
        UserService mockedUserService = mock(UserService.class);
        when(mockedUserService.isEmailAlreadyExists(technician.getEmail())).thenReturn(true); // Return true for duplicated email
        when(mockedUserService.addUser(technician)).thenReturn(false); // Return false as user shouldn't be added

        // Execute the method under test
        boolean result = userService.addUser(technician);

        // Verify behavior
        assertFalse(result, "User with duplicated email should not be added");
    }
    }

