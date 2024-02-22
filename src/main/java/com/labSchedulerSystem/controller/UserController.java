package com.labSchedulerSystem.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.util.Base64;
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

import com.labSchedulerSystem.dao.UserManagerImpl;
import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.service.EmailService;
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
				request.setAttribute("message", "No consultant found!");
				 LOGGER.warning("No consultant found!" + consultant.getUserId());
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
		System.out.println("Reached the 'viewUser' method.");
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

	/*
	 * private void loginUser(HttpServletRequest request, HttpServletResponse
	 * response) throws ServletException, IOException { String email =
	 * request.getParameter("email"); String password =
	 * request.getParameter("password"); try { User user =
	 * getUserService().fetchUserByEmail(email); if (user != null) { if
	 * (AccessRight.ROLE_CONSULTANT.getDisplayName().equals(user.getAccessRight().
	 * getDisplayName())) { if
	 * (RegistrationStatus.PENDING.equals(user.getRegistrationStatus())) {
	 * request.setAttribute("loginError",
	 * "Consultant registration is pending approval.");
	 * LOGGER.warning("Consultant registration is pending approval." +
	 * user.getUserId()); RequestDispatcher rd =
	 * request.getRequestDispatcher("login.jsp"); rd.forward(request, response);
	 * return; } else if
	 * (RegistrationStatus.REJECTED.equals(user.getRegistrationStatus())) {
	 * request.setAttribute("loginError",
	 * "Consultant registration has been rejected."); RequestDispatcher rd =
	 * request.getRequestDispatcher("login.jsp"); rd.forward(request, response);
	 * return; } }
	 * 
	 * String enteredHashedPassword = UserService.hashPassword(password); if
	 * (enteredHashedPassword != null &&
	 * enteredHashedPassword.equals(user.getPassword())) { HttpSession session =
	 * request.getSession(); session.setMaxInactiveInterval(30 * 60);
	 * session.setAttribute("user", user); response.sendRedirect("home.jsp"); } else
	 * { request.setAttribute("loginError", "Invalid email or password");
	 * RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
	 * rd.forward(request, response); } } else { request.setAttribute("loginError",
	 * "Invalid email or password"); RequestDispatcher rd =
	 * request.getRequestDispatcher("login.jsp"); rd.forward(request, response); } }
	 * catch (ClassNotFoundException | SQLException e) { e.printStackTrace(); } }
	 */

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
	                    request.setAttribute("loginError", "Consultant registration is pending approval.");
	                    LOGGER.warning("Consultant registration is pending approval for user: " + user.getUserId());
	                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
	                    rd.forward(request, response);
	                    return;
	                } else if (RegistrationStatus.REJECTED.equals(user.getRegistrationStatus())) {
	                    request.setAttribute("loginError", "Consultant registration has been rejected.");
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
	    user.setEducationalQualifications(request.getParameter("educationalQualifications"));
	    user.setSpecializedJobs(request.getParameter("specializedJobs"));
//	    String[] selectedAvailableDays = request.getParameterValues("availableDays");
//	    String[] selectedAvailableTimeSlots = request.getParameterValues("availableTimeSlots");
//	    if (selectedAvailableDays != null && selectedAvailableTimeSlots != null) {
//	        String availableDays = String.join(",", selectedAvailableDays);
//	        String availableTimeSlots = String.join(",", selectedAvailableTimeSlots);
//	    } else {
//	    }
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

	
	/*
	 * private void addUser(HttpServletRequest request, HttpServletResponse
	 * response) throws ServletException, IOException { clearMessage(); User user =
	 * new User(); Date currentDate = new Date();
	 * user.setRegistrationDate(currentDate);
	 * user.setName(request.getParameter("name"));
	 * user.setPhoneNumber(request.getParameter("telephone")); String email =
	 * request.getParameter("email"); if (!UserService.isValidEmail(email)) {
	 * message = "Invalid email address. Please enter a valid email.";
	 * request.setAttribute("feebackMessage", message); RequestDispatcher rd =
	 * request.getRequestDispatcher("add-user.jsp"); rd.forward(request, response);
	 * return; } user.setEmail(email); String plainPassword =
	 * request.getParameter("password"); if (plainPassword == null ||
	 * plainPassword.isEmpty()) { message = "Password cannot be null or empty.";
	 * request.setAttribute("feebackMessage", message); RequestDispatcher rd =
	 * request.getRequestDispatcher("add-user.jsp"); rd.forward(request, response);
	 * } String hashedPassword = UserService.hashPassword(plainPassword);
	 * user.setPassword(hashedPassword);
	 * user.setBirthdate(request.getParameter("birthdate"));
	 * user.setGender(request.getParameter("gender"));
	 * user.setOccupation(request.getParameter("jobtype"));
	 * user.setCountry(request.getParameter("country")); if
	 * (AccessRight.ROLE_ADMIN.equals(AccessRight.valueOf(request.getParameter(
	 * "usertype")))) { user.setAccessRight(AccessRight.ROLE_ADMIN);
	 * user.setRegistrationStatus(RegistrationStatus.APPROVED); } else if
	 * (AccessRight.ROLE_CONSULTANT.equals(AccessRight.valueOf(request.getParameter(
	 * "usertype")))) { user.setAccessRight(AccessRight.ROLE_CONSULTANT);
	 * user.setRegistrationStatus(RegistrationStatus.PENDING); } else {
	 * user.setAccessRight(AccessRight.ROLE_USER);
	 * user.setRegistrationStatus(RegistrationStatus.APPROVED); }
	 * user.setEducationalQualifications(request.getParameter(
	 * "educationalQualifications"));
	 * user.setSpecializedCountries(request.getParameter("specializedCountries"));
	 * user.setSpecializedJobs(request.getParameter("specializedJobs")); String[]
	 * selectedAvailableDays = request.getParameterValues("availableDays"); String[]
	 * selectedAvailableTimeSlots =
	 * request.getParameterValues("availableTimeSlots"); if (selectedAvailableDays
	 * != null && selectedAvailableTimeSlots != null) { String availableDays =
	 * String.join(",", selectedAvailableDays); String availableTimeSlots =
	 * String.join(",", selectedAvailableTimeSlots);
	 * user.setAvailableDays(availableDays);
	 * user.setAvailableTimeSlots(availableTimeSlots); } else {
	 * user.setAvailableDays(""); user.setAvailableTimeSlots(""); } try { if
	 * (getUserService().isEmailAlreadyExists(user.getEmail())) { message =
	 * "User with the same email already exists!";
	 * LOGGER.warning("User with the same email already exists " + user.getEmail());
	 * 
	 * } else { boolean savedUser = false; try { savedUser =
	 * getUserService().addUser(user); } catch (Exception e) { e.printStackTrace();
	 * } if (savedUser) { try { AccessRight accessRight = user.getAccessRight(); if
	 * (accessRight == AccessRight.ROLE_ADMIN || accessRight ==
	 * AccessRight.ROLE_USER) { UserService.sendRegistrationEmail(user); } else if
	 * (accessRight == AccessRight.ROLE_CONSULTANT) {
	 * UserService.sendConsultantRegistrationEmail(user); } message =
	 * "The user has been successfully added"; } catch (Exception e) {
	 * e.printStackTrace(); message =
	 * "The user has been successfully added, but there was an error sending " +
	 * "the email. Please check your email configuration."; } } else { message =
	 * "Failed to add the user."; } } } catch (ClassNotFoundException | SQLException
	 * e) { message = "Operation failed! " + e.getMessage(); }
	 * request.setAttribute("feebackMessage", message); RequestDispatcher rd =
	 * request.getRequestDispatcher("add-user.jsp"); rd.forward(request, response);
	 * }
	 */

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
		String[] selectedAvailableDays = request.getParameterValues("availableDays");
		String[] selectedAvailableTimeSlots = request.getParameterValues("availableTimeSlots");
		if (selectedAvailableDays != null && selectedAvailableTimeSlots != null) {
			String availableDays = String.join(",", selectedAvailableDays);
			String availableTimeSlots = String.join(",", selectedAvailableTimeSlots);
		} else {
		}
		try {
			if (getUserService().editUser(user)) {
				UserService.sendUserUpdateEmail(user);
				message = "The user has been successfully updated! User ID: " + user.getUserId();
			} else {
				message = "Failed to update the user! User ID: " + user.getUserId();
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
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
				message = "The user has been successfully deleted. user Code: " + userId;
			} else {
				message = "Failed to delete the user! user Code: " + userId;
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}

		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		response.sendRedirect("getuser?useractiontype=all");
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
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("feebackMessage", message);
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
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
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
				message = "No consultant users found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
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
				message = "No consultant users found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
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
			} else {
				message = "Failed to approve the user!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
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
			} else {
				message = "Failed to reject the user!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		response.sendRedirect("getuser?useractiontype=pending");
	}

	private void clearMessage() {
		message = "";
	}
}
