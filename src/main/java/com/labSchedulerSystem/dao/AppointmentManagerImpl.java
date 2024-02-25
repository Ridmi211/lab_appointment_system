package com.labSchedulerSystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.awt.Color;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.labSchedulerSystem.dao.dbUtils.DbDriverManager;
import com.labSchedulerSystem.dao.dbUtils.DbDriverManagerFactory;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.Test;
import com.labSchedulerSystem.model.Test.TestType;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.model.Appointment.Status;

public class AppointmentManagerImpl implements AppointmentManager {

	public AppointmentManagerImpl() {
		// TODO Auto-generated constructor stub
	}

	private Connection getConnection() throws ClassNotFoundException, SQLException {
		DbDriverManagerFactory driverFactory = new DbDriverManagerFactory();
		DbDriverManager driverManager = driverFactory.getDbDriver("MySQL");
		return driverManager.getConnection();
	}

	@Override
	public boolean addAppointment(Appointment appointment) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "INSERT INTO appointments(`technitianId`, `seekerId`, `scheduledDate`, `startTime`, `status`,`job`,`country`, `notes`) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, appointment.getTechnitianId());
		ps.setInt(2, appointment.getSeekerId());
		ps.setString(3, appointment.getScheduledDate());
		ps.setString(4, appointment.getStartTime());
		ps.setString(5, appointment.getStatus().name());
		ps.setString(6, appointment.getJob());
		ps.setString(7, appointment.getCountry());
		ps.setString(8, appointment.getNotes());
		boolean result = false;
		if (ps.executeUpdate() > 0) {
			result = true;
		}
		ps.close();
		connection.close();
		return result;
	}

	@Override
	public boolean editAppointment(Appointment appointment) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "UPDATE appointments SET technitianId=?,seekerId=?,scheduledDate=?,startTime=?,status=?,job=?,country=?,notes=? WHERE appointmentId=?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, appointment.getTechnitianId());
		ps.setInt(2, appointment.getSeekerId());
		ps.setString(3, appointment.getScheduledDate());
		ps.setString(4, appointment.getStartTime());
		ps.setString(5, appointment.getStatus().name());
		ps.setString(6, appointment.getJob());
		ps.setString(7, appointment.getCountry());
		ps.setString(8, appointment.getNotes());
		ps.setInt(9, appointment.getAppointmentId());
		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		ps.close();
		connection.close();
		return result;
	}

	@Override
	public boolean deleteAppointment(int appointmentId) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "DELETE FROM appointments WHERE appointmentId=?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, appointmentId);
		boolean result = false;
		if (ps.executeUpdate() > 0) {
			result = true;
		}
		ps.close();
		connection.close();
		return result;
	}

	@Override
	public Appointment fetchSingleAppointment(int appointmentId) throws SQLException, ClassNotFoundException {
	    Connection connection = getConnection();
	    String query = "SELECT a.*, c.name AS consultantName, s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerPhoneNumber " +
	                   "FROM appointments a " +
	                   "INNER JOIN user c ON a.technitianId = c.userId " +
	                   "INNER JOIN user s ON a.seekerId = s.userId " +
	                   "WHERE a.appointmentId = ?";
	    PreparedStatement ps = connection.prepareStatement(query);
	    ps.setInt(1, appointmentId);
	    ResultSet rs = ps.executeQuery();
	    Appointment appointment = null; // Initialize to null
	    while (rs.next()) {
	        appointment = new Appointment(); // Update only if data is found
	        appointment.setAppointmentId(rs.getInt("appointmentId"));
	        appointment.setTechnitianId(rs.getInt("technitianId"));
	        appointment.setSeekerId(rs.getInt("seekerId"));
	        appointment.setScheduledDate(rs.getString("scheduledDate"));
	        appointment.setStartTime(rs.getString("startTime"));
	        appointment.setStatus(Status.valueOf(rs.getString("status")));
	        appointment.setNotes(rs.getString("notes"));
	        appointment.setConsultantName(rs.getString("consultantName"));
	        appointment.setSeekerName(rs.getString("seekerName"));
	        appointment.setSeekerEmail(rs.getString("seekerEmail"));
	        appointment.setSeekerPhoneNumber(rs.getString("seekerPhoneNumber"));
	    }
	    rs.close();
	    ps.close();
	    connection.close();
	    return appointment;
	}

	
	public List<Test> fetchAllTests() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM test ";
		Statement st = connection.createStatement();
		List<Test> testList = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Test test = new Test(null, query);
			 test.setTestId(rs.getInt("testId"));
		        test.setType(TestType.valueOf(rs.getString("type")));
		        test.setDescription(rs.getString("description"));
		        test.setCost(rs.getString("cost"));
		        testList.add(test);
		}
		st.close();
		connection.close();
		return testList;
	}
	
	@Override
	public Test fetchSingleTest(int testId) throws SQLException, ClassNotFoundException {
	    Connection connection = getConnection();
	    String query = "SELECT * FROM test WHERE testId = ?";
	    PreparedStatement ps = connection.prepareStatement(query);
	    ps.setInt(1, testId);
	    ResultSet rs = ps.executeQuery();
	    
	    Test test = null; // Initialize the Test object outside the loop
	    
	    while (rs.next()) {
	        // Create a new Test object inside the loop
	        test = new Test(null, query);
	        test.setTestId(rs.getInt("testId"));
	        test.setType(TestType.valueOf(rs.getString("type")));
	        test.setDescription(rs.getString("description"));
	        test.setCost(rs.getString("cost"));
	    }
	    
	    ps.close();
	    connection.close();
	    return test;
	}

	
	@Override
	public Test fetchSingleTestByType(String testType) throws SQLException, ClassNotFoundException {
	    Connection connection = getConnection();
	    String query = "SELECT * FROM test WHERE type = ?";
	    PreparedStatement ps = connection.prepareStatement(query);
	    ps.setString(1, testType);
	    ResultSet rs = ps.executeQuery();
	    
	    Test test = null;
	    if (rs.next()) {
	        test = new Test(null, query);
	        test.setTestId(rs.getInt("testId"));
	        test.setType(TestType.valueOf(rs.getString("type")));
	        test.setDescription(rs.getString("description"));
	        test.setCost(rs.getString("cost"));
	        // Add other properties if needed
	    }
	    
	    rs.close();
	    ps.close();
	    connection.close();
	    
	    return test;
	}


	@Override
	public List<Appointment> fetchAllAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId";
		Statement st = connection.createStatement();
		List<Appointment> appointmentList = new ArrayList<Appointment>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			appointmentList.add(appointment);
		}
		st.close();
		connection.close();
		return appointmentList;
	}

//	Newly requested  appointments
	@Override
	public List<Appointment> fetchRequestedAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'REQUESTED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

//	 consultant rejected appointments
	@Override
	public List<Appointment> fetchConsultantRejectedAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'CON_REJECTED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

//	Appointments sent to consultant
	@Override
	public List<Appointment> fetchAdminRequestedAllAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'ADMIN_CONFIRMED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchConsultantConfiremedAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'CON_CONFIRMED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchSeekerCancelledAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'SEEKER_CANCELLED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchAllCompletedAppointments() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a  " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'COMPLETED'";
		Statement st = connection.createStatement();
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		st.close();
		connection.close();
		return requestedAppointments;
	}

//	Admin sent appointments to consultant fetch by con id 	
	@Override
	public List<Appointment> fetchAdminRequestedAppointments(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId "
				+ "WHERE a.status = 'ADMIN_CONFIRMED' AND a.consultantId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchCompletedAppointmentsByConId(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.status = 'COMPLETED' AND a.consultantId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchCancelledAppointmentsByConId(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId "
				+ "WHERE (a.status = 'ADMIN_CANCELLED' OR a.status = 'SEEKER_CANCELLED') AND a.consultantId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	@Override
	public List<Appointment> fetchUpcomingAppointmentsByConId(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId "
				+ "WHERE a.status = 'CON_CONFIRMED' AND a.consultantId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	public List<Appointment> fetchAppointmentsBySeekerId(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.seekerId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	public List<Appointment> fetchAppointmentsByConsultantId(int loggedInUserId)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT a.*, c.name AS consultantName, c.email AS consultantEmail, c.phoneNumber AS consultantContact, "
				+ "s.name AS seekerName, s.email AS seekerEmail, s.phoneNumber AS seekerContact "
				+ "FROM appointments a " + "INNER JOIN user c ON a.technitianId = c.userId "
				+ "INNER JOIN user s ON a.seekerId = s.userId " + "WHERE a.consultantId = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setInt(1, loggedInUserId);
		List<Appointment> requestedAppointments = new ArrayList<>();
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(rs.getInt("appointmentId"));
			appointment.setTechnitianId(rs.getInt("technitianId"));
			appointment.setConsultantName(rs.getString("consultantName"));
			appointment.setSeekerName(rs.getString("seekerName"));
			appointment.setScheduledDate(rs.getString("scheduledDate"));
			appointment.setStartTime(rs.getString("startTime"));
			appointment.setStatus(Status.valueOf(rs.getString("status")));
			requestedAppointments.add(appointment);
		}
		preparedStatement.close();
		connection.close();
		return requestedAppointments;
	}

	public boolean updateAppointmentStatus(int appointmentId, Status status)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "UPDATE appointments SET Status = ? WHERE appointmentId = ?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, status.toString());
		ps.setInt(2, appointmentId);
		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		ps.close();
		connection.close();
		return result;
	}

	private static final Logger LOGGER = Logger.getLogger(AppointmentManagerImpl.class.getName());

	public Map<String, Integer> getAppointmentStatusCounts() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> statusCounts = new HashMap<>();
		String query = "SELECT status, COUNT(*) FROM appointments GROUP BY status";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String statusValue = rs.getString("status");
					Status status = Status.valueOf(statusValue);
					String statusDisplayName = status.getDisplayName();
					int count = rs.getInt(2);
					statusCounts.put(statusDisplayName, count);
				}
			}
		}
		connection.close();
		LOGGER.info("statusCounts: " + statusCounts);
		return statusCounts;
	}

	public Map<String, Integer> getAppointmentCountsByCountry() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> countryAppointmentCounts = new HashMap<>();
		String query = "SELECT country, COUNT(*) FROM appointments GROUP BY country";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String country = rs.getString("country");
					int count = rs.getInt(2);
					countryAppointmentCounts.put(country, count);
				}
			}
		}
		connection.close();
		LOGGER.info("countryAppointmentCounts: " + countryAppointmentCounts);
		return countryAppointmentCounts;
	}

	public List<String> generateRandomColors(int count) {
		List<String> colors = new ArrayList<>();
		for (int i = 0; i < count; i++) {
			Color color = new Color((int) (Math.random() * 256), (int) (Math.random() * 256),
					(int) (Math.random() * 256));
			String hexColor = String.format("#%02x%02x%02x", color.getRed(), color.getGreen(), color.getBlue());
			colors.add(hexColor);
		}
		return colors;
	}

	public Map<String, Integer> getAppointmentCountsByJob() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> jobAppointmentCounts = new HashMap<>();
		String query = "SELECT job, COUNT(*) FROM appointments GROUP BY job";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String job = rs.getString("job");
					int count = rs.getInt(2);
					jobAppointmentCounts.put(job, count);
				}
			}
		}
		connection.close();
		LOGGER.info("jobAppointmentCounts: " + jobAppointmentCounts);
		return jobAppointmentCounts;
	}

	public Map<String, Integer> getAppointmentCountsByDay() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> appointmentsByDayData = new HashMap<>();
		String query = "SELECT DAYNAME(scheduledDate) AS day, COUNT(*) " + "FROM appointments " + "GROUP BY day "
				+ "ORDER BY FIELD(day, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String day = rs.getString("day");
					int count = rs.getInt(2);
					appointmentsByDayData.put(day, count);
				}
			}
		}
		connection.close();
		LOGGER.info("appointmentsByDayData: " + appointmentsByDayData);
		return appointmentsByDayData;
	}

	public Map<String, Integer> getAppointmentCountsByTimeSlot() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> appointmentsByTimeSlotData = new HashMap<>();
		String query = "SELECT startTime, COUNT(*) FROM appointments GROUP BY startTime";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String startTime = rs.getString("startTime");
					int count = rs.getInt(2);
					appointmentsByTimeSlotData.put(startTime, count);
				}
			}
		}
		connection.close();
		LOGGER.info("appointmentsByTimeSlotData: " + appointmentsByTimeSlotData);
		return appointmentsByTimeSlotData;
	}

	public Map<String, Map<String, Integer>> getAppointmentCountsByDayAndTimeSlot()
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Map<String, Integer>> appointmentsByDayAndTimeSlotData = new HashMap<>();
		String query = "SELECT DAYNAME(scheduledDate) AS day, startTime, COUNT(*) " + "FROM appointments "
				+ "GROUP BY day, startTime "
				+ "ORDER BY FIELD(day, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String day = rs.getString("day");
					String startTime = rs.getString("startTime");
					int count = rs.getInt(3);
					appointmentsByDayAndTimeSlotData.computeIfAbsent(day, k -> new HashMap<>());
					appointmentsByDayAndTimeSlotData.get(day).put(startTime, count);
				}
			}
		}
		connection.close();
		LOGGER.info("appointmentsByDayAndTimeSlotData: " + appointmentsByDayAndTimeSlotData);
		return appointmentsByDayAndTimeSlotData;
	}

	public Map<String, Integer> getAppointmentCountsByConsultant() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> appointmentsByConsultantData = new HashMap<>();
		String query = "SELECT consultantId, COUNT(*) AS appointmentCount FROM appointments GROUP BY consultantId";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String consultantId = rs.getString("technitianId");
					int appointmentCount = rs.getInt("appointmentCount");
					String consultantName = getConsultantNameById(consultantId);
					appointmentsByConsultantData.put(consultantName, appointmentCount);
				}
			}
		}
		connection.close();
		LOGGER.info("appointmentsByConsultantData: " + appointmentsByConsultantData);
		return appointmentsByConsultantData;
	}

	public String getConsultantNameById(String userId) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String consultantName = null;
		String query = "SELECT name FROM user WHERE userId = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					consultantName = rs.getString("name");
				}
			}
		}
		connection.close();
		return consultantName;
	}

	public List<Integer> getMonthlyAppointmentCounts() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		List<Integer> monthlyCounts = new ArrayList<>();
		int currentYear = Year.now().getValue();
		for (int month = 1; month <= 12; month++) {
			String query = "SELECT COUNT(*) FROM appointments WHERE YEAR(STR_TO_DATE(scheduledDate, '%Y-%m-%d')) = ? AND MONTH(STR_TO_DATE(scheduledDate, '%Y-%m-%d')) = ?";
			try (PreparedStatement ps = connection.prepareStatement(query)) {
				ps.setInt(1, currentYear);
				ps.setInt(2, month);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						int count = rs.getInt(1);
						monthlyCounts.add(count);
					}
				}
			}
		}
		connection.close();
		return monthlyCounts;
	}

}
