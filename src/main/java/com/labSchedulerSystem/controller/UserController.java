package com.labSchedulerSystem.controller;

import java.io.IOException;
import java.util.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.model.Test;
import com.labSchedulerSystem.service.UserService;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String message = "";

	private UserService getUserService() {
		return UserService.getUserService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String useractiontype = request.getParameter("useractiontype");
		if (useractiontype.equals("single")) {
			fetchSingleUser(request, response);
		} else if (useractiontype.equals("view")) {
			viewUser(request, response);
		} else if (useractiontype.equals("viewConsultant")) {
			viewConsultant(request, response);
		} else if (useractiontype.equals("consultants")) {
			fetchConsultantUsers(request, response);
		} else if (useractiontype.equals("pending")) {
			fetchPendingUsers(request, response);
		} else {
			fetchAllUsers(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Useraction" + request.getParameter("useractiontype"));
		String useractiontype = request.getParameter("useractiontype");
		if (useractiontype.equals("login")) {
			loginUser(request, response);
		} else if (useractiontype.equals("viewConsultant")) {
			viewConsultant(request, response);
		} else if (useractiontype.equals("add")) {
			addUser(request, response);
		} else if (useractiontype.equals("edit")) {
			editUser(request, response);
		} else if (useractiontype.equals("view")) {
			viewUser(request, response);
		} else if (useractiontype.equals("delete")) {
			deleteUser(request, response);
		} else if (useractiontype.equals("approve")) {
			approveUser(request, response);
		} else if (useractiontype.equals("reject")) {
			rejectUser(request, response);
		}
	}

	private static final Logger LOGGER = Logger.getLogger(UserController.class.getName());

	private void viewConsultant(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		try {
			User consultant = getUserService().fetchSingleUser(userId);
			if (consultant.getUserId() > 0) {
				request.setAttribute("consultant", consultant);
				RequestDispatcher rd = request.getRequestDispatcher("book-consultant-new.jsp");
				rd.forward(request, response);
			} else {
				request.setAttribute("message", "No technician found!");
				LOGGER.warning("No technician found!" + consultant.getUserId());
				RequestDispatcher rd = request.getRequestDispatcher("consultants-list.jsp");
				rd.forward(request, response);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void viewUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		LOGGER.info(" Reached the 'viewUser' method.");
		try {
			User user = getUserService().fetchSingleUser(userId);
			if (user.getUserId() > 0) {
				request.setAttribute("user", user);
				RequestDispatcher rd = request.getRequestDispatcher("update-profile.jsp");
				rd.forward(request, response);
			} else {
				request.setAttribute("message", "No user found!");
				LOGGER.warning("No user found!" + user.getUserId());
				RequestDispatcher rd = request.getRequestDispatcher("user-list.jsp");
				rd.forward(request, response);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void loginUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			LOGGER.info("Attempting login for email: " + email);
			User user = getUserService().fetchUserByEmail(email);
			if (user != null) {
				LOGGER.info("User found for email: " + email);
				if (AccessRight.ROLE_TECHNITIAN.getDisplayName().equals(user.getAccessRight().getDisplayName())) {
					if (RegistrationStatus.PENDING.equals(user.getRegistrationStatus())) {
						request.setAttribute("loginError", "Technician registration is pending approval.");
						LOGGER.warning("Technician registration is pending approval for user: " + user.getUserId());
						RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
						rd.forward(request, response);
						return;
					} else if (RegistrationStatus.REJECTED.equals(user.getRegistrationStatus())) {
						request.setAttribute("loginError", "Technician registration has been rejected.");
						RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
						rd.forward(request, response);
						return;
					}
				}
				String enteredHashedPassword = UserService.hashPassword(password);
				if (enteredHashedPassword != null && enteredHashedPassword.equals(user.getPassword())) {
					LOGGER.info("Login successful for user: " + user.getUserId());
					HttpSession session = request.getSession();
					session.setMaxInactiveInterval(30 * 60);
					session.setAttribute("user", user);
					response.sendRedirect("home.jsp");
				} else {
					LOGGER.warning("Invalid password for user: " + user.getUserId());
					request.setAttribute("loginError", "Invalid email or password");
					RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
					rd.forward(request, response);
				}
			} else {
				LOGGER.warning("User not found for email: " + email);
				request.setAttribute("loginError", "Invalid email or password");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			}
		} catch (ClassNotFoundException | SQLException e) {
			LOGGER.log(Level.SEVERE, "An error occurred during login", e);
			e.printStackTrace();
		}
	}

	private void addUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		User user = new User();
		Date currentDate = new Date();
		user.setRegistrationDate(currentDate);
		user.setName(request.getParameter("name"));
		user.setPhoneNumber(request.getParameter("telephone"));
		String email = request.getParameter("email");
		if (!UserService.isValidEmail(email)) {
			message = "Invalid email address. Please enter a valid email.";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("add-user.jsp");
			rd.forward(request, response);
			return;
		}
		user.setEmail(email);
		String plainPassword = request.getParameter("password");
		if (plainPassword == null || plainPassword.isEmpty()) {
			message = "Password cannot be null or empty.";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("add-user.jsp");
			rd.forward(request, response);
		}
		String hashedPassword = UserService.hashPassword(plainPassword);
		user.setPassword(hashedPassword);
		user.setBirthdate(request.getParameter("birthdate"));
		user.setGender(request.getParameter("gender"));
		if (AccessRight.ROLE_ADMIN.equals(AccessRight.valueOf(request.getParameter("usertype")))) {
			user.setAccessRight(AccessRight.ROLE_ADMIN);
			user.setRegistrationStatus(RegistrationStatus.APPROVED);
		} else if (AccessRight.ROLE_TECHNITIAN.equals(AccessRight.valueOf(request.getParameter("usertype")))) {
			user.setAccessRight(AccessRight.ROLE_TECHNITIAN);
			user.setRegistrationStatus(RegistrationStatus.PENDING);
		} else {
			user.setAccessRight(AccessRight.ROLE_USER);
			user.setRegistrationStatus(RegistrationStatus.APPROVED);
		}
		user.setSelectedTestType(Test.TestType.DEFAULT);
		user.setEducationalQualifications(request.getParameter("educationalQualifications"));
		user.setSpecializedJobs(request.getParameter("specializedJobs"));
		try {
			if (getUserService().isEmailAlreadyExists(user.getEmail())) {
				message = "User with the same email already exists!";
				LOGGER.warning("User with the same email already exists: " + user.getEmail());
			} else {
				boolean savedUser = false;
				try {
					savedUser = getUserService().addUser(user);
				} catch (Exception e) {
					LOGGER.log(Level.SEVERE, "Error adding user to the database", e);
					e.printStackTrace();
				}
				if (savedUser) {
					try {
						AccessRight accessRight = user.getAccessRight();
						if (accessRight == AccessRight.ROLE_ADMIN || accessRight == AccessRight.ROLE_USER) {
							UserService.sendRegistrationEmail(user);
						} else if (accessRight == AccessRight.ROLE_TECHNITIAN) {
							UserService.sendConsultantRegistrationEmail(user);
						}
						message = "The user has been successfully added";
					} catch (Exception e) {
						LOGGER.log(Level.SEVERE, "Error sending registration email", e);
						e.printStackTrace();
						message = "The user has been successfully added, but there was an error sending "
								+ "the email. Please check your email configuration.";
					}
				} else {
					message = "Failed to add the user.";
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			LOGGER.log(Level.SEVERE, "Operation failed! " + e.getMessage(), e);
			message = "Operation failed! " + e.getMessage();
		}
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("add-user.jsp");
		rd.forward(request, response);
	}

	private void editUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		User user = new User();
		user.setUserId(Integer.parseInt(request.getParameter("userId")));
		user.setName(request.getParameter("name"));
		user.setPhoneNumber(request.getParameter("phoneNumber"));
		user.setEmail(request.getParameter("email"));
		user.setBirthdate(request.getParameter("birthdate"));
		user.setGender(request.getParameter("gender"));
		user.setEducationalQualifications(request.getParameter("educationalQualifications"));
		user.setSpecializedJobs(request.getParameter("specializedJobs"));
		user.setAccessRight(AccessRight.valueOf(request.getParameter("accessRight")));
		if (user.getAccessRight() == AccessRight.ROLE_TECHNITIAN) {
			user.setSelectedTestType(Test.TestType.valueOf(request.getParameter("selectedTestType")));
		} else {
			user.setSelectedTestType(Test.TestType.DEFAULT);
		}
		try {
			if (getUserService().editUser(user)) {
				message = "The user has been successfully updated! User ID: " + user.getUserId();
				LOGGER.info("User successfully updated. User ID: " + user.getUserId());
			} else {
				message = "Failed to update the user! User ID: " + user.getUserId();
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.log(Level.SEVERE, "Failed to update the user. User ID:" + user.getUserId(), e);
		}
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message.jsp");
		rd.forward(request, response);
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int userId = Integer.parseInt(request.getParameter("userId"));
		try {
			if (getUserService().deleteUser(userId)) {
				message = "The user has been successfully deleted. User Code: " + userId;
				LOGGER.info("User with ID " + userId + " has been successfully deleted.");
			} else {
				message = "Failed to delete the user! There are existing appointments for this user. User Code: "
						+ userId;
				LOGGER.warning("Failed to delete user with ID " + userId + ". Existing appointments found.");
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.severe("Error occurred while deleting user with ID " + userId + ": " + e.getMessage());
		}
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message.jsp");
		rd.forward(request, response);
	}

	private void fetchSingleUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int userId = Integer.parseInt(request.getParameter("userId"));
		try {
			User user = getUserService().fetchSingleUser(userId);
			if (user.getUserId() > 0) {
				request.setAttribute("user", user);
			} else {
				message = "No record found!";
				LOGGER.log(Level.INFO, "No record found for user with ID: " + userId);
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.log(Level.SEVERE, "Error fetching single user", e);
		}
		request.setAttribute("feedbackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("search-and-update-user.jsp");
		rd.forward(request, response);
	}

	private void fetchAllUsers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<User> userList = new ArrayList<User>();
		try {
			userList = getUserService().fetchAllUsers();
			if (!(userList.size() > 0)) {
				message = "No record found!";
				LOGGER.log(Level.INFO, "No users found in the database");
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.log(Level.SEVERE, "Error fetching all users", e);
		}
		request.setAttribute("userList", userList);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-job-seekers.jsp");
		rd.forward(request, response);
	}

	private void fetchConsultantUsers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<User> consultantUsers = new ArrayList<User>();
		try {
			consultantUsers = getUserService().fetchAllConsultantUsers();
			if (!(consultantUsers.size() > 0)) {
				message = "No Technicians found!";
				LOGGER.log(Level.INFO, "No Technicians found in the database");
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.log(Level.SEVERE, "Error fetching Technician users", e);
		}
		request.setAttribute("consultantUsers", consultantUsers);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-consultants.jsp");
		rd.forward(request, response);
	}

	private void fetchPendingUsers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<User> pendingUsers = new ArrayList<User>();
		try {
			pendingUsers = getUserService().fetchPendingUsers();
			if (!(pendingUsers.size() > 0)) {
				message = "No pending users found!";
				LOGGER.log(Level.INFO, "No pending users found in the database");
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
			LOGGER.log(Level.SEVERE, "Error fetching pending users", e);
		}
		request.setAttribute("pendingUsers", pendingUsers);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-pending-users.jsp");
		rd.forward(request, response);
	}

	private void approveUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int userId = Integer.parseInt(request.getParameter("userId"));
		try {
			if (getUserService().approveUser(userId)) {
				User approvedUser = getUserService().fetchSingleUser(userId);
				UserService.sendApprovalEmail(approvedUser);
				message = "User has been approved!";
				LOGGER.log(Level.INFO, "User with ID " + userId + " has been approved");
			} else {
				message = "Failed to approve the user!";
				LOGGER.log(Level.WARNING, "Failed to approve user with ID: " + userId);
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
			LOGGER.log(Level.SEVERE, "Error approving user", e);
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		response.sendRedirect("getuser?useractiontype=pending");
	}

	private void rejectUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int userId = Integer.parseInt(request.getParameter("userId"));
		try {
			if (getUserService().rejectUser(userId)) {
				User rejectedUser = getUserService().fetchSingleUser(userId);
				UserService.sendRejectionEmail(rejectedUser);
				message = "User has been rejected!";
				LOGGER.log(Level.INFO, "User with ID " + userId + " has been rejected");
			} else {
				message = "Failed to reject the user!";
				LOGGER.log(Level.WARNING, "Failed to reject user with ID: " + userId);
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
			LOGGER.log(Level.SEVERE, "Error rejecting user", e);
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		response.sendRedirect("getuser?useractiontype=pending");
	}

	private void clearMessage() {
		message = "";
	}
}
