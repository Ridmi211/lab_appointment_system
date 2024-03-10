package labSchedulerSystem;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import com.labSchedulerSystem.dao.AppointmentManagerImpl;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.Appointment.Status;
import com.labSchedulerSystem.model.Test.TestType;
import com.labSchedulerSystem.service.AppointmentService;
import com.labSchedulerSystem.service.UserService;

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
		appointmentService = AppointmentService.getAppointmentService();
		userService = UserService.getUserService();
		appointmentImpl = new AppointmentManagerImpl();
	}

	@Test
	void testAddAppointment() throws SQLException, ClassNotFoundException {
		Appointment appointment = new Appointment();
		appointment.setTechnitianId(81);// add proper id
		appointment.setSeekerId(80);// add proper id
		appointment.setScheduledDate("2024-03-05");
		appointment.setStartTime("09:00");
		appointment.setStatus(Status.REQUESTED);
		appointment.setRecomendedDoctor("Dr. Smith");
		appointment.setNotes("Follow-up appointment");
		appointment.setAppointmentRefId("APPT98t55");// add proper id
		appointment.setTestType(TestType.DEFAULT);
		AppointmentService mockedAppointmentService = mock(AppointmentService.class);
		when(mockedAppointmentService.addAppointment(appointment)).thenReturn(true);
		boolean result = appointmentService.addAppointment(appointment);
		assertTrue(result, "Appointment should be added successfully");
	}

	@Test
	void testFetchAllAppointments() throws SQLException, ClassNotFoundException {
		AppointmentService mockedAppointmentService = mock(AppointmentService.class);
		List<Appointment> appointments = List.of();
		when(mockedAppointmentService.fetchAllAppointments()).thenReturn(appointments);
		List<Appointment> result = appointmentService.fetchAllAppointments();
		assertNotNull(result, "Fetched appointment list should not be null");
	}

	@Test
	void testEditAppointment() throws SQLException, ClassNotFoundException {
		Appointment appointment = new Appointment();
		appointment.setAppointmentId(60);// add proper id
		appointment.setTechnitianId(81);// add proper id
		appointment.setSeekerId(80);// add proper id
		appointment.setScheduledDate("2024-03-05");
		appointment.setStartTime("09:00");
		appointment.setStatus(Status.COMPLETED);
		appointment.setRecomendedDoctor("Dr. Smith");
		appointment.setCountry("USA");
		appointment.setNotes("Follow-up appointment");
		appointment.setAppointmentRefId("APPT98955");// add proper id
		appointment.setTestType(TestType.DEFAULT);
		appointment.setTestResults("Normal");
		appointment.setTestResultsDescription("All parameters within normal range");
		appointment.setTestUpdatedOn(new Date());
		appointment.setTestUpdatedBy("Dr. John");
		AppointmentService mockedAppointmentService = mock(AppointmentService.class);
		when(mockedAppointmentService.editAppointment(appointment)).thenReturn(true);
		boolean result = appointmentService.editAppointment(appointment);
		assertTrue(result, "Appointment should be edited successfully");
	}

	@Test
	void testDeleteAppointment() throws SQLException, ClassNotFoundException {
		int appointmentId = 50;// add proper id
		AppointmentService mockedAppointmentService = mock(AppointmentService.class);
		when(mockedAppointmentService.deleteAppointment(appointmentId)).thenReturn(true);
		boolean result = appointmentService.deleteAppointment(appointmentId);
		assertTrue(result, "Appointment should be deleted successfully");
	}

	@Test
	void testFetchSingleAppointment() throws SQLException, ClassNotFoundException {
		int appointmentId = 60;// add proper id
		AppointmentService mockedAppointmentService = mock(AppointmentService.class);
		Appointment appointment = new Appointment();
		appointment.setAppointmentId(appointmentId);
		when(mockedAppointmentService.fetchSingleAppointment(appointmentId)).thenReturn(appointment);
		Appointment result = appointmentService.fetchSingleAppointment(appointmentId);
		assertNotNull(result, "Fetched appointment should not be null");
	}

}
