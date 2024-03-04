package com.labSchedulerSystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Year;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.labSchedulerSystem.dao.dbUtils.DbDriverManager;
import com.labSchedulerSystem.dao.dbUtils.DbDriverManagerFactory;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.Test;
import com.labSchedulerSystem.model.User;

public class UserManagerImpl implements UserManager {

	public UserManagerImpl() {
		// TODO Auto-generated constructor stub
	}

	private Connection getConnection() throws ClassNotFoundException, SQLException {
		DbDriverManagerFactory driverFactory = new DbDriverManagerFactory();
		DbDriverManager driverManager = driverFactory.getDbDriver("MySQL");
		return driverManager.getConnection();
	}

	@Override
	public boolean addUser(User user) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "INSERT INTO user(`name`,`phoneNumber`,`email`, `password`,`birthdate`,`gender`,`educationalQualifications`,`specializedJobs`,`accessRight`,`registrationStatus`,`registrationDate`,`selectedTestType`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, user.getName());
		ps.setString(2, user.getPhoneNumber());
		ps.setString(3, user.getEmail());
		ps.setString(4, user.getPassword());
		ps.setString(5, user.getBirthdate());
		ps.setString(6, user.getGender());
		ps.setString(7, user.getEducationalQualifications());
		ps.setString(8, user.getSpecializedJobs());
		ps.setString(9, user.getAccessRight().toString());
		ps.setString(10, user.getRegistrationStatus().toString());
		ps.setDate(11, new java.sql.Date(user.getRegistrationDate().getTime()));
		ps.setString(12, user.getSelectedTestType().toString());
		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		LOGGER.info("Registration added successfully for the email " + user.getEmail());
		ps.close();
		connection.close();
		return result;
	}

	public boolean updateRegistrationStatus(int userId, RegistrationStatus status)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "UPDATE user SET registrationStatus = ? WHERE userId = ?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, status.toString());
		ps.setInt(2, userId);
		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		LOGGER.info("Registration status updated successfully for userId: " + userId);
		ps.close();
		connection.close();
		return result;

	}

	private static final Logger LOGGER = Logger.getLogger(UserManagerImpl.class.getName());

	public Map<String, List<Integer>> getMonthlyUserRegistrationCounts() throws SQLException, ClassNotFoundException {
		Connection connection = null;
		List<Integer> userCounts = new ArrayList<>();
		List<Integer> consultantCounts = new ArrayList<>();
		int currentYear = Year.now().getValue();
		try {
			connection = getConnection();
			for (int month = 1; month <= 12; month++) {
				String userQuery = "SELECT COUNT(*) FROM user WHERE YEAR(registrationDate) = ? AND MONTH(registrationDate) = ? AND accessRight = 'ROLE_USER'";
				try (PreparedStatement userPs = connection.prepareStatement(userQuery)) {
					userPs.setInt(1, currentYear);
					userPs.setInt(2, month);
					try (ResultSet userRs = userPs.executeQuery()) {
						if (userRs.next()) {
							int userCount = userRs.getInt(1);
							userCounts.add(userCount);
							LOGGER.info("User count for month " + month + ": " + userCount);

						}
					}
				}
				String consultantQuery = "SELECT COUNT(*) FROM user WHERE YEAR(registrationDate) = ? AND MONTH(registrationDate) = ? AND accessRight = 'ROLE_TECHNITIAN'";
				try (PreparedStatement consultantPs = connection.prepareStatement(consultantQuery)) {
					consultantPs.setInt(1, currentYear);
					consultantPs.setInt(2, month);
					try (ResultSet consultantRs = consultantPs.executeQuery()) {
						if (consultantRs.next()) {
							int consultantCount = consultantRs.getInt(1);
							consultantCounts.add(consultantCount);
							LOGGER.info("Consultant count for month " + month + ": " + consultantCount);
						}
					}
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error occurred while fetching monthly user registration counts", e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					LOGGER.log(Level.SEVERE, "Error occurred while closing the database connection", e);
				}
			}
		}
		Map<String, List<Integer>> countsMap = new HashMap<>();
		countsMap.put("userCounts", userCounts);
		countsMap.put("consultantCounts", consultantCounts);
		return countsMap;
	}

//	public Map<String, Map<String, Object>> getJobTypeDistributionData() throws SQLException, ClassNotFoundException {
//		Connection connection = null;
//		PreparedStatement statement = null;
//		ResultSet resultSet = null;
//		try {
//			connection = getConnection();
//
//			String query = "SELECT occupation, COUNT(*) as count FROM user GROUP BY occupation ORDER BY count DESC LIMIT 20";
//			statement = connection.prepareStatement(query);
//			resultSet = statement.executeQuery();
//			Map<String, Map<String, Object>> jobTypeDistributionData = new HashMap<>();
//			int colorIndex = 0;
//			while (resultSet.next()) {
//				String occupation = resultSet.getString("occupation");
//				int count = resultSet.getInt("count");
//				String color = getPredefinedColor(colorIndex);
//				Map<String, Object> jobTypeInfo = new HashMap<>();
//				jobTypeInfo.put("count", count);
//				jobTypeInfo.put("color", color);
//				jobTypeDistributionData.put(occupation, jobTypeInfo);
//				colorIndex = (colorIndex + 1) % PREDEFINED_COLORS.size();
//			}
//			return jobTypeDistributionData;
//		} finally {
//			if (resultSet != null)
//				resultSet.close();
//			if (statement != null)
//				statement.close();
//			if (connection != null)
//				connection.close();
//		}
//	}

	private static final List<String> PREDEFINED_COLORS = Arrays.asList("rgba(255, 99, 132, 0.8)",
			"rgba(54, 162, 235, 0.8)", "rgba(255, 182, 193, 0.8)", "rgba(240, 230, 140, 0.8)",
			"rgba(192, 192, 192, 0.8)", "rgba(255, 69, 0, 0.8)", "rgba(0, 128, 0, 0.8)", "rgba(255, 215, 0, 0.8)",
			"rgba(70, 130, 180, 0.8)", "rgba(128, 0, 128, 0.8)", "rgba(128, 128, 0, 0.8)", "rgba(0, 128, 128, 0.8)",
			"rgba(165, 42, 42, 0.8)", "rgba(0, 255, 255, 0.8)", "rgba(0, 0, 128, 0.8)", "rgba(255, 20, 147, 0.8)",
			"rgba(0, 250, 154, 0.8)", "rgba(255, 165, 0, 0.8)", "rgba(255, 0, 255, 0.8)", "rgba(128, 0, 0, 0.8)");

	private String getPredefinedColor(int index) {
		index = index % PREDEFINED_COLORS.size();
		return PREDEFINED_COLORS.get(index);
	}
//
//	public Map<String, Map<String, Integer>> getUserDemographicsData() throws SQLException, ClassNotFoundException {
//		Connection connection = null;
//		PreparedStatement statement = null;
//		ResultSet resultSet = null;
//		try {
//			connection = getConnection();
//			String query = "SELECT country, gender, COUNT(*) as count FROM user GROUP BY country, gender";
//			statement = connection.prepareStatement(query);
//			resultSet = statement.executeQuery();
//			Map<String, Map<String, Integer>> userDemographicsData = new HashMap<>();
//			while (resultSet.next()) {
//				String country = resultSet.getString("country");
//				String gender = resultSet.getString("gender");
//				int count = resultSet.getInt("count");
//				userDemographicsData.putIfAbsent(country, new HashMap<>());
//				userDemographicsData.get(country).put(gender, count);
//			}
//			return userDemographicsData;
//		} finally {
//			if (resultSet != null)
//				resultSet.close();
//			if (statement != null)
//				statement.close();
//			if (connection != null)
//				connection.close();
//		}
//	}
	
	public Map<String, Integer> getUserGenderDistribution() throws SQLException, ClassNotFoundException {
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    try {
	        connection = getConnection();
	        String query = "SELECT gender, COUNT(*) as count FROM user GROUP BY gender";
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();
	        Map<String, Integer> genderDistribution = new HashMap<>();
	        while (resultSet.next()) {
	            String gender = resultSet.getString("gender");
	            int count = resultSet.getInt("count");
	            genderDistribution.put(gender, count);
	        }
	        return genderDistribution;
	    } finally {
	        if (resultSet != null)
	            resultSet.close();
	        if (statement != null)
	            statement.close();
	        if (connection != null)
	            connection.close();
	    }
	}


	public Map<RegistrationStatus, Integer> getRegistrationStatusData() throws SQLException, ClassNotFoundException {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = getConnection();
			String query = "SELECT registrationStatus, COUNT(*) as count FROM user GROUP BY registrationStatus";
			statement = connection.prepareStatement(query);
			resultSet = statement.executeQuery();
			Map<RegistrationStatus, Integer> registrationStatusData = new HashMap<>();
			while (resultSet.next()) {
				String statusString = resultSet.getString("registrationStatus");
				RegistrationStatus status = RegistrationStatus.valueOf(statusString.toUpperCase());
				int count = resultSet.getInt("count");
				registrationStatusData.put(status, count);
			}
			return registrationStatusData;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	public Map<String, Integer> getAgeDistributionData() throws SQLException, ClassNotFoundException {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = getConnection();
			String query = "SELECT COUNT(*) as count, FLOOR(DATEDIFF(CURRENT_DATE, birthdate) / 365.25 / 10) * 10 as ageRange FROM user GROUP BY ageRange ORDER BY ageRange";
			statement = connection.prepareStatement(query);
			resultSet = statement.executeQuery();
			Map<String, Integer> ageDistributionData = new LinkedHashMap<>();
			ageDistributionData.put("0-9", 0);
			ageDistributionData.put("10-19", 0);
			ageDistributionData.put("20-29", 0);
			ageDistributionData.put("30-39", 0);
			ageDistributionData.put("40-49", 0);
			ageDistributionData.put("50-59", 0);
			ageDistributionData.put("60+", 0);
			while (resultSet.next()) {
				int count = resultSet.getInt("count");
				int ageRange = resultSet.getInt("ageRange");
				String label = mapAgeRangeToLabel(ageRange);
				ageDistributionData.put(label, count);
			}
			return ageDistributionData;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

	private String mapAgeRangeToLabel(int ageRange) {
		switch (ageRange) {
		case 0:
			return "0-9";
		case 10:
			return "10-19";
		case 20:
			return "20-29";
		case 30:
			return "30-39";
		case 40:
			return "40-49";
		case 50:
			return "50-59";
		default:
			return "60+";
		}
	}

	public Map<String, Integer> getAccessRightsData() throws SQLException, ClassNotFoundException {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			connection = getConnection();
			String query = "SELECT accessRight, COUNT(*) as count FROM user GROUP BY accessRight";
			statement = connection.prepareStatement(query);
			resultSet = statement.executeQuery();
			Map<String, Integer> accessRightsData = new HashMap<>();
			while (resultSet.next()) {
				String accessRight = resultSet.getString("accessRight");
				int count = resultSet.getInt("count");
				accessRightsData.put(accessRight, count);
			}
			return accessRightsData;
		} finally {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		}
	}

//	public Map<String, Integer> getConsultantCountByCountry() throws SQLException, ClassNotFoundException {
//		Connection connection = getConnection();
//		Map<String, Integer> consultantCountByCountry = new HashMap<>();
//		String consultantCountriesQuery = "SELECT specializedCountries FROM user WHERE accessRight = 'ROLE_TECHNITIAN'";
//		try (PreparedStatement countriesPs = connection.prepareStatement(consultantCountriesQuery)) {
//			try (ResultSet countriesRs = countriesPs.executeQuery()) {
//				while (countriesRs.next()) {
//					String countriesString = countriesRs.getString("specializedCountries");
//					String[] countries = countriesString.split(",\\s*");
//					for (String country : countries) {
//						consultantCountByCountry.put(country, consultantCountByCountry.getOrDefault(country, 0) + 1);
//					}
//				}
//			}
//		}
//		connection.close();
//		return consultantCountByCountry;
//	}

//	public Map<String, Map<String, Integer>> getConsultantAvailabilityData()
//			throws SQLException, ClassNotFoundException {
//		Connection connection = getConnection();
//		Map<String, Map<String, Integer>> consultantAvailabilityData = new HashMap<>();
//		String consultantAvailabilityQuery = "SELECT availableDays, availableTimeSlots FROM user WHERE accessRight = 'ROLE_TECHNITIAN'";
//		try (PreparedStatement availabilityPs = connection.prepareStatement(consultantAvailabilityQuery)) {
//			try (ResultSet availabilityRs = availabilityPs.executeQuery()) {
//				while (availabilityRs.next()) {
//					String daysString = availabilityRs.getString("availableDays");
//					String timeSlotsString = availabilityRs.getString("availableTimeSlots");
//					LOGGER.info("Days String: " + daysString);
//					LOGGER.info("Time Slots String: " + timeSlotsString);
//					if (daysString != null && timeSlotsString != null) {
//						String[] days = daysString.split(",\\s*");
//						String[] timeSlots = timeSlotsString.split(",\\s*");
//						for (String day : days) {
//							consultantAvailabilityData.computeIfAbsent(day, k -> new HashMap<>());
//							for (String timeSlot : timeSlots) {
//								consultantAvailabilityData.get(day).put(timeSlot,
//										consultantAvailabilityData.get(day).getOrDefault(timeSlot, 0) + 1);
//							}
//						}
//					}
//				}
//			}
//		} finally {
//			connection.close();
//		}
//		LOGGER.info("Consultant Availability Data: " + consultantAvailabilityData);
//		return consultantAvailabilityData;
//	}

	public Map<String, Integer> getConsultantJobTypeDistribution() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		Map<String, Integer> jobTypeDistribution = new HashMap<>();
		String consultantJobTypesQuery = "SELECT selectedTestType FROM user WHERE accessRight = 'ROLE_TECHNITIAN'";
		try (PreparedStatement jobTypesPs = connection.prepareStatement(consultantJobTypesQuery)) {
			try (ResultSet jobTypesRs = jobTypesPs.executeQuery()) {
				while (jobTypesRs.next()) {
					String jobTypesString = jobTypesRs.getString("selectedTestType");
					String[] jobTypes = jobTypesString.split(",\\s*");
					for (String jobType : jobTypes) {
						jobTypeDistribution.put(jobType, jobTypeDistribution.getOrDefault(jobType, 0) + 1);
					}
				}
			}
		}
		connection.close();
		return jobTypeDistribution;
	}

	@Override
	public boolean editUser(User user) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "UPDATE user SET name =?,phoneNumber=?,email=?,birthdate=?,gender=?,educationalQualifications=?,specializedJobs=?,accessRight=?,selectedTestType=? WHERE userId=?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, user.getName());
		ps.setString(2, user.getPhoneNumber());
		ps.setString(3, user.getEmail());
		ps.setString(4, user.getBirthdate());
		ps.setString(5, user.getGender());
		ps.setString(6, user.getEducationalQualifications());
		ps.setString(7, user.getSpecializedJobs());
		ps.setString(8, user.getAccessRight().toString());
		ps.setString(9, user.getSelectedTestType().toString());
		ps.setInt(10, user.getUserId());

		LOGGER.info("Executing SQL query: " + query);
		LOGGER.info("Parameters: name=" + user.getName() + ", phoneNumber=" + user.getPhoneNumber() + ", email="
				+ user.getEmail() + ", birthdate=" + user.getBirthdate() + ", gender=" + user.getGender()
				+ ", educationalQualifications=" + user.getEducationalQualifications() + ", specializedJobs="
				+ user.getSpecializedJobs() + ", accessRight=" + user.getAccessRight().toString()
				+ ", selectedTestType=" + user.getSelectedTestType().toString() + ", userId=" + user.getUserId());

		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		ps.close();
		connection.close();
		return result;
	}

	/*
	 * @Override public boolean deleteUser(int userId) throws SQLException,
	 * ClassNotFoundException { Connection connection = getConnection(); String
	 * query = "DELETE FROM user WHERE userId=?"; PreparedStatement ps =
	 * connection.prepareStatement(query); ps.setInt(1, userId); boolean result =
	 * false; if (ps.executeUpdate() > 0) { result = true; } ps.close();
	 * connection.close(); return result; }
	 */
	@Override
	public boolean deleteUser(int userId) throws SQLException, ClassNotFoundException {
	    Connection connection = getConnection();
	    boolean result = false;
	    try {
	        // Check for existing appointments
	        if (hasAppointments(userId)) {
	            return false; // User cannot be deleted due to existing appointments
	        }

	        String query = "DELETE FROM user WHERE userId=?";
	        PreparedStatement ps = connection.prepareStatement(query);
	        ps.setInt(1, userId);

	        // Execute the deletion
	        if (ps.executeUpdate() > 0) {
	            result = true;
	        }
	        ps.close();
	    } finally {
	        connection.close();
	    }
	    return result;
	}

	private boolean hasAppointments(int userId) throws SQLException,ClassNotFoundException {
	    Connection connection = getConnection();
	    try {
	        String query = "SELECT COUNT(*) FROM appointments WHERE technitianId=?";
	        PreparedStatement ps = connection.prepareStatement(query);
	        ps.setInt(1, userId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            int count = rs.getInt(1);
	            return count > 0; // Return true if appointments exist for this user
	        }
	        return false; // No appointments found
	    } finally {
	        connection.close();
	    }
	}

	@Override
	public User fetchSingleUser(int userId) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM user WHERE userId=?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, userId);
		ResultSet rs = ps.executeQuery();
		User user = new User();
		while (rs.next()) {
			user.setUserId(rs.getInt("userId"));
			user.setName(rs.getString("name"));
			user.setPhoneNumber(rs.getString("phoneNumber"));
			user.setEmail(rs.getString("email"));
			user.setBirthdate(rs.getString("birthdate"));
			user.setGender(rs.getString("gender"));
			user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
			user.setSelectedTestType(Test.TestType.valueOf(rs.getString("selectedTestType")));
			user.setEducationalQualifications(rs.getString("educationalQualifications"));
			user.setSpecializedJobs(rs.getString("specializedJobs"));
		}
		ps.close();
		connection.close();
		return user;
	}

	@Override
	public List<User> fetchAllUsers() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM user";
		Statement st = connection.createStatement();
		List<User> userList = new ArrayList<User>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			User user = new User();
			user.setUserId(rs.getInt("userId"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
			user.setRegistrationStatus(RegistrationStatus.valueOf(rs.getString("registrationStatus")));
			userList.add(user);
		}
		st.close();
		connection.close();
		return userList;
	}

	public List<User> fetchAllConsultantUsers() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM user WHERE accessRight = 'ROLE_TECHNITIAN'AND registrationStatus = 'APPROVED'";
		Statement st = connection.createStatement();
		List<User> consultantUsers = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			User user = new User();
			user.setUserId(rs.getInt("userId"));
			user.setName(rs.getString("name"));
			user.setPhoneNumber(rs.getString("phoneNumber"));
			user.setEmail(rs.getString("email"));
			user.setBirthdate(rs.getString("birthdate"));
			user.setGender(rs.getString("gender"));
			user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
			user.setSelectedTestType(Test.TestType.valueOf(rs.getString("selectedTestType")));
			user.setEducationalQualifications(rs.getString("educationalQualifications"));
			user.setSpecializedJobs(rs.getString("specializedJobs"));
			consultantUsers.add(user);
		}
		st.close();
		connection.close();
		return consultantUsers;
	}

	/*
	 * public List<User> fetchTechniciansForTest(int testId) throws SQLException,
	 * ClassNotFoundException { Connection connection = getConnection(); String
	 * query = "SELECT DISTINCT u.* FROM user u " +
	 * "JOIN t tt ON u.userId = tt.technicianId " + "WHERE tt.testId = ? " +
	 * "AND u.accessRight = 'ROLE_TECHNICIAN' " +
	 * "AND u.registrationStatus = 'APPROVED'"; PreparedStatement pst =
	 * connection.prepareStatement(query); pst.setInt(1, testId); ResultSet rs =
	 * pst.executeQuery();
	 * 
	 * List<User> technicianUsers = new ArrayList<>(); while (rs.next()) { User user
	 * = new User(); user.setUserId(rs.getInt("userId"));
	 * user.setName(rs.getString("name"));
	 * user.setPhoneNumber(rs.getString("phoneNumber"));
	 * user.setEmail(rs.getString("email"));
	 * user.setBirthdate(rs.getString("birthdate"));
	 * user.setGender(rs.getString("gender"));
	 * user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
	 * user.setEducationalQualifications(rs.getString("educationalQualifications"));
	 * user.setSpecializedJobs(rs.getString("specializedJobs"));
	 * technicianUsers.add(user); }
	 * 
	 * pst.close(); connection.close(); return technicianUsers; }
	 */

	public List<User> fetchTechniciansForTest(int testId) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		LOGGER.log(Level.INFO, "Fetching technicians for test ID: {0}", testId);
		String query = "SELECT * FROM user WHERE accessRight = 'ROLE_TECHNITIAN' "
				+ "AND registrationStatus = 'APPROVED' "
				+ "AND selectedTestType = (SELECT type FROM test WHERE testId = ?)";
		PreparedStatement pst = connection.prepareStatement(query);
		pst.setInt(1, testId);
		ResultSet rs = pst.executeQuery();

		List<User> technicianUsers = new ArrayList<>();
		while (rs.next()) {
			User user = new User();
			user.setUserId(rs.getInt("userId"));
			user.setName(rs.getString("name"));
			user.setPhoneNumber(rs.getString("phoneNumber"));
			user.setEmail(rs.getString("email"));
			user.setBirthdate(rs.getString("birthdate"));
			user.setGender(rs.getString("gender"));
			user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
			user.setEducationalQualifications(rs.getString("educationalQualifications"));
			user.setSpecializedJobs(rs.getString("specializedJobs"));
			user.setSelectedTestType(Test.TestType.valueOf(rs.getString("selectedTestType")));
			technicianUsers.add(user);
		}

		pst.close();
		connection.close();
		LOGGER.log(Level.INFO, "Fetched {0} technicians for test ID: {1}",
				new Object[] { technicianUsers.size(), testId });

		return technicianUsers;
	}

	public int getCountOfConsultantUsers() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT COUNT(*) FROM user WHERE accessRight = 'ROLE_TECHNITIAN' AND registrationStatus = 'APPROVED'";

		try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(query)) {
			if (rs.next()) {
				int count = rs.getInt(1);
				return count;
			}
		} finally {
			connection.close();
		}

		return 0;
	}

	public int getCountOfClientUsers() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT COUNT(*) FROM user WHERE accessRight = 'ROLE_USER' AND registrationStatus = 'APPROVED'";

		try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(query)) {
			if (rs.next()) {
				int count = rs.getInt(1);
				return count;
			}
		} finally {
			connection.close();
		}

		return 0;
	}

	public List<User> fetchPendingUsers() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM user WHERE registrationStatus = 'PENDING'";
		Statement st = connection.createStatement();
		List<User> consultantUsers = new ArrayList<>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			User user = new User();
			user.setUserId(rs.getInt("userId"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			user.setAccessRight(AccessRight.valueOf(rs.getString("accessRight")));
			user.setRegistrationStatus(RegistrationStatus.valueOf(rs.getString("registrationStatus")));
			consultantUsers.add(user);
		}
		st.close();
		connection.close();
		return consultantUsers;
	}

	@Override
	public User fetchUserByEmail(String email) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM user WHERE email=?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, email);
		ResultSet resultSet = preparedStatement.executeQuery();
		User user = null;
		if (resultSet.next()) {
			user = new User();
			user.setUserId(resultSet.getInt("userId"));
			user.setName(resultSet.getString("name"));
			user.setPhoneNumber(resultSet.getString("phoneNumber"));
			user.setEmail(resultSet.getString("email"));
			user.setPassword(resultSet.getString("password"));
			user.setBirthdate(resultSet.getString("birthdate"));
			user.setGender(resultSet.getString("gender"));
			user.setEducationalQualifications(resultSet.getString("educationalQualifications"));
			user.setSpecializedJobs(resultSet.getString("specializedJobs"));
			user.setAccessRight(AccessRight.valueOf(resultSet.getString("accessRight")));
			user.setSelectedTestType(Test.TestType.valueOf(resultSet.getString("selectedTestType")));
			user.setRegistrationStatus(RegistrationStatus.valueOf(resultSet.getString("registrationStatus")));
		}
		preparedStatement.close();
		connection.close();
		return user;
	}

	@Override
	public boolean isEmailAlreadyExists(String email) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT COUNT(*) FROM user WHERE email=?";
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, email);
		ResultSet resultSet = preparedStatement.executeQuery();
		boolean emailExists = false;
		if (resultSet.next()) {
			int count = resultSet.getInt(1);
			emailExists = count > 0;
		}
		preparedStatement.close();
		connection.close();
		return emailExists;
	}

}
