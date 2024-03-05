package labSchedulerSystem;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.labSchedulerSystem.dao.AppointmentManagerImpl;
import com.labSchedulerSystem.dao.UserManagerImpl;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.Appointment.Status;
import com.labSchedulerSystem.model.Message;
import com.labSchedulerSystem.model.Message.MessageStatus;
import com.labSchedulerSystem.model.Test.TestType;
import com.labSchedulerSystem.service.AppointmentService;
import com.labSchedulerSystem.service.MessageService;
import com.labSchedulerSystem.service.UserService;
import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;

public class AppointmentTests {

	public AppointmentTests() {
		// TODO Auto-generated constructor stub
	}
	

    private AppointmentService appointmentService;
    private UserService userService;
    private AppointmentManagerImpl appointmentImpl;
    private int appointmentId;

    @BeforeEach
    void setUp() {
        appointmentService = new AppointmentService();
        userService = new UserService();
        appointmentImpl= new AppointmentManagerImpl();
    }

    @Test
    void testAddAppointment() throws SQLException, ClassNotFoundException {
        // Prepare test data
        Appointment appointment = new Appointment();
        appointment.setTechnitianId(81);//add proper id
        appointment.setSeekerId(30);//add proper id
        appointment.setScheduledDate("2024-03-05");
        appointment.setStartTime("09:00");
        appointment.setStatus(Status.REQUESTED);
        appointment.setRecomendedDoctor("Dr. Smith");
       
        appointment.setNotes("Follow-up appointment");
        appointment.setAppointmentRefId("APPT12345");//add proper id
        appointment.setTestType(TestType.DEFAULT);

        // Mock AppointmentService dependencies if needed
        AppointmentService mockedAppointmentService = mock(AppointmentService.class);
        when(mockedAppointmentService.addAppointment(appointment)).thenReturn(true); // Return true for successful addition

        // Execute the method under test
        boolean result = appointmentService.addAppointment(appointment);

        // Verify behavior
        assertTrue(result, "Appointment should be added successfully");
    }

    // Add similar test methods for other methods of AppointmentService

    @Test
    void testFetchAllAppointments() throws SQLException, ClassNotFoundException {
        // Mock AppointmentService dependencies if needed
        AppointmentService mockedAppointmentService = mock(AppointmentService.class);
        // Prepare test data for fetchAllAppointments method
        List<Appointment> appointments = List.of(/* List of appointment objects */);
        when(mockedAppointmentService.fetchAllAppointments()).thenReturn(appointments);

        // Execute the method under test
        List<Appointment> result = appointmentService.fetchAllAppointments();

        // Verify behavior
        assertNotNull(result, "Fetched appointment list should not be null");
        // Add additional assertions as per your requirements
    }
    
    @Test
    void testEditAppointment() throws SQLException, ClassNotFoundException {
        // Prepare test data
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(43);
        appointment.setTechnitianId(81);
        appointment.setSeekerId(30);
        appointment.setScheduledDate("2024-03-05");
        appointment.setStartTime("09:00");
        appointment.setStatus(Status.COMPLETED);
        appointment.setRecomendedDoctor("Dr. Smith");
        appointment.setCountry("USA");
        appointment.setNotes("Follow-up appointment");
        appointment.setAppointmentRefId("APPT1234");
        appointment.setTestType(TestType.DEFAULT);
        appointment.setTestResults("Normal");
        appointment.setTestResultsDescription("All parameters within normal range");
        appointment.setTestUpdatedOn(new Date());
        appointment.setTestUpdatedBy("Dr. John");

        // Mock AppointmentService dependencies if needed
        AppointmentService mockedAppointmentService = mock(AppointmentService.class);
        when(mockedAppointmentService.editAppointment(appointment)).thenReturn(true); // Return true for successful edit

        // Execute the method under test
        boolean result = appointmentService.editAppointment(appointment);

        // Verify behavior
        assertTrue(result, "Appointment should be edited successfully");
    }

    @Test
    void testDeleteAppointment() throws SQLException, ClassNotFoundException {
        // Prepare test data
        int appointmentId = 41; // ID of the appointment to be deleted

        // Mock AppointmentService dependencies if needed
        AppointmentService mockedAppointmentService = mock(AppointmentService.class);
        when(mockedAppointmentService.deleteAppointment(appointmentId)).thenReturn(true); // Return true for successful deletion

        // Execute the method under test
        boolean result = appointmentService.deleteAppointment(appointmentId);

        // Verify behavior
        assertTrue(result, "Appointment should be deleted successfully");
    }

    @Test
    void testFetchSingleAppointment() throws SQLException, ClassNotFoundException {
        // Prepare test data
        int appointmentId = 43; // ID of the appointment to be fetched

        // Mock AppointmentService dependencies if needed
        AppointmentService mockedAppointmentService = mock(AppointmentService.class);
        // Prepare test data for fetchSingleAppointment method
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(appointmentId);
        // Set other properties for appointment as needed
        when(mockedAppointmentService.fetchSingleAppointment(appointmentId)).thenReturn(appointment);

        // Execute the method under test
        Appointment result = appointmentService.fetchSingleAppointment(appointmentId);

        // Verify behavior
        assertNotNull(result, "Fetched appointment should not be null");
        // Add additional assertions as per your requirements
    }

  

}
