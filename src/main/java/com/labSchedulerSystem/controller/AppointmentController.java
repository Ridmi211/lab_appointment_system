package com.labSchedulerSystem.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.util.Base64;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.labSchedulerSystem.model.AccessRight;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.model.Appointment.Status;
import com.labSchedulerSystem.service.AppointmentService;
import com.labSchedulerSystem.service.UserService;

public class AppointmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String message = "";

	private AppointmentService getAppointmentService() {
		return AppointmentService.getAppointmentService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Action :" + request.getParameter("appactiontype"));
		String appactiontype = request.getParameter("appactiontype");
		if (appactiontype.equals("singleAppointment")) {
			fetchSingleAppointment(request, response);
		} else if (appactiontype.equals("view")) {
			viewAppointment(request, response);
		} else if (appactiontype.equals("requested")) {
			fetchRequestedAppointments(request, response);
		} else if (appactiontype.equals("appointmentBySeekerId")) {
			fetchAppointmentsBySeekerId(request, response);
		} else if (appactiontype.equals("appointmentByConsultantId")) {
			fetchAppointmentsByConsultantId(request, response);
		} else if (appactiontype.equals("adminRequested")) {
			fetchAdminRequestedAppointments(request, response);
		} else if (appactiontype.equals("adminRequestedAll")) {
			fetchAdminRequestedAllAppointments(request, response);
		} else if (appactiontype.equals("adminCompleted")) {
			fetchAllCompletedAppointments(request, response);
		} else if (appactiontype.equals("adminRejected")) {
			fetchConsultantRejectedAppointments(request, response);
		} else if (appactiontype.equals("seekerCancelled")) {
			fetchSeekerCancelledAppointments(request, response);
		} else if (appactiontype.equals("conComplete")) {
			fetchCompletedAppointmentsByConId(request, response);
		} else if (appactiontype.equals("conCancelled")) {
			fetchCancelledAppointmentsByConId(request, response);
		} else if (appactiontype.equals("conUpcoming")) {
			fetchUpcomingAppointmentsByConId(request, response);
		} else if (appactiontype.equals("conConfirmed")) {
			fetchConsultantConfiremedAppointments(request, response);
		} else {
			fetchAllAppointments(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String appactiontype = request.getParameter("appactiontype");
		if (appactiontype.equals("addAppointment")) {
			addAppointment(request, response);
		} else if (appactiontype.equals("editAppointment")) {
			editAppointment(request, response);
		} else if (appactiontype.equals("deleteAppointment")) {
			deleteAppointment(request, response);
		} else if (appactiontype.equals("approve")) {
			acceptAppointmentAdmin(request, response);
		} else if (appactiontype.equals("acceptCon")) {
			acceptAppointmentCon(request, response);
		} else if (appactiontype.equals("rejectCon")) {
			rejectAppointmentCon(request, response);
		} else if (appactiontype.equals("view")) {
			viewAppointment(request, response);
		} else if (appactiontype.equals("completed")) {
			completedAppointment(request, response);
		} else if (appactiontype.equals("cancel")) {
			cancelAppointmentAdmin(request, response);
		} else if (appactiontype.equals("cancel-by-seeker")) {
			cancelAppointmentSeeker(request, response);
		}
	}

	private void addAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		Appointment appointment = new Appointment();
		int seekerId = Integer.parseInt(request.getParameter("seekerId"));
		appointment.setSeekerId(seekerId);
		int consultantId = Integer.parseInt(request.getParameter("consultantId"));
		appointment.setConsultantId(consultantId);
		appointment.setScheduledDate(request.getParameter("date"));
		appointment.setStartTime(request.getParameter("time"));
		appointment.setStatus(Appointment.Status.REQUESTED);
		appointment.setCountry(request.getParameter("country"));
		appointment.setJob(request.getParameter("job"));
		appointment.setNotes(request.getParameter("notes"));
		try {
			boolean savedAppointment = getAppointmentService().addAppointment(appointment);
			if (savedAppointment) {
				User consultant = getUserService().fetchSingleUser(consultantId);
				User seeker = getUserService().fetchSingleUser(seekerId);
				AppointmentService.sendAppointmentConfirmationEmail(appointment, consultant, seeker);
				message = "The appointment request has been successfully submitted!";
			} else {
				message = "Failed to submit the appointment request!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message.jsp");
		rd.forward(request, response);
	}

	private UserService getUserService() {
		return UserService.getUserService();
	}

	private void fetchAllAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> appointmentList = new ArrayList<Appointment>();
		try {
			appointmentList = getAppointmentService().fetchAllAppointments();
			request.setAttribute("pageTopic", "All Appointments - Admin ");

			if (!(appointmentList.size() > 0)) {
				message = "No record found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("appointmentList", appointmentList);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-appointment-list.jsp");
		rd.forward(request, response);
	}

	private void fetchRequestedAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchRequestedAppointments();
			request.setAttribute("pageTopic", "New Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No record found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchAdminRequestedAllAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchAdminRequestedAllAppointments();
			request.setAttribute("pageTopic", "Pending Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No records found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchAllCompletedAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchAllCompletedAppointments();
			request.setAttribute("pageTopic", "Completed Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No records found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchConsultantRejectedAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchConsultantRejectedAppointments();
			request.setAttribute("pageTopic", "Rejected Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No records found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchSeekerCancelledAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchSeekerCancelledAppointments();
			request.setAttribute("pageTopic", "Cancelled Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No records found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchConsultantConfiremedAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchConsultantConfiremedAppointments();
			request.setAttribute("pageTopic", "Ongoing Appointments - Admin ");
			if (!(requestedAppointments.size() > 0)) {
				message = "No records found!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("view-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void acceptAppointmentAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().acceptAppointmentAdmin(appointmentId)) {
				Appointment approvedAppointment = getAppointmentService().fetchSingleAppointment(appointmentId);
				User consultant = getUserService().fetchSingleUser(approvedAppointment.getConsultantId());
				User seeker = getUserService().fetchSingleUser(approvedAppointment.getSeekerId());
				AppointmentService.sendNewAppointmentNotificationEmail(approvedAppointment, consultant, seeker);
				message = "Appointment has been approved!";
			} else {
				message = "Failed to approve the appointment!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		response.sendRedirect("getAppointment?appactiontype=requested");
	}

	private void cancelAppointmentAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().cancelAppointmentAdmin(appointmentId)) {
				Appointment canceledAppointment = getAppointmentService().fetchSingleAppointment(appointmentId);
				User consultant = getUserService().fetchSingleUser(canceledAppointment.getConsultantId());
				User seeker = getUserService().fetchSingleUser(canceledAppointment.getSeekerId());
				AppointmentService.sendAppointmentCancellationEmail(canceledAppointment, consultant, seeker);
				message = "Appointment has been canceled due to unavoidable reasons.";
			} else {
				message = "Failed to cancel the appointment!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message1.jsp");
		rd.forward(request, response);
	}

	private void cancelAppointmentSeeker(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().cancelAppointmentSeeker(appointmentId)) {
				Appointment canceledAppointment = getAppointmentService().fetchSingleAppointment(appointmentId);
				User consultant = getUserService().fetchSingleUser(canceledAppointment.getConsultantId());
				User seeker = getUserService().fetchSingleUser(canceledAppointment.getSeekerId());
				AppointmentService.sendAppointmentCancellationBySeekerEmailToSeeker(canceledAppointment, consultant,
						seeker);
				AppointmentService.sendAppointmentCancellationBySeekerEmailToConsultant(canceledAppointment, consultant,
						seeker);
				message = "Appointment cancelled.";
			} else {
				message = "Failed to cancel the appointment!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message1.jsp");
		rd.forward(request, response);
	}

	private void acceptAppointmentCon(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().acceptAppointmentCon(appointmentId)) {
				Appointment acceptedAppointment = getAppointmentService().fetchSingleAppointment(appointmentId);
				User consultant = getUserService().fetchSingleUser(acceptedAppointment.getConsultantId());
				User seeker = getUserService().fetchSingleUser(acceptedAppointment.getSeekerId());
				AppointmentService.sendAppointmentAcceptedEmail(acceptedAppointment, consultant, seeker);
				message = "Appointment has been accepted!";
			} else {
				message = "Failed to accept to appointment!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message1.jsp");
		rd.forward(request, response);
	}

	private void rejectAppointmentCon(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().rejectAppointmentCon(appointmentId)) {
				message = "Appointment has been rejected!";
			} else {
				message = "Failed to reject the appointment!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message1.jsp");
		rd.forward(request, response);
	}

	private void completedAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			if (getAppointmentService().completedAppointment(appointmentId)) {
				Appointment completedAppointment = getAppointmentService().fetchSingleAppointment(appointmentId);
				User consultant = getUserService().fetchSingleUser(completedAppointment.getConsultantId());
				User seeker = getUserService().fetchSingleUser(completedAppointment.getSeekerId());
				AppointmentService.sendAppointmentCompletedEmail(completedAppointment, consultant, seeker);
				message = "Appointment has been marked as completed!";
			} else {
				message = "Failed to mark the appointment as completed!";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed! " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message1.jsp");
		rd.forward(request, response);
	}

	private void fetchAdminRequestedAppointments(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchAdminRequestedAppointments(loggedInUserId);
			request.setAttribute("pageTopic", "New Appointments ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action :" + request.getParameter("message"));
		RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchAppointmentsBySeekerId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchAppointmentsBySeekerId(loggedInUserId);
			request.setAttribute("pageTopic", "My Appointments (user)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action : hfg hgfg");
		RequestDispatcher rd = request.getRequestDispatcher("view-seekers-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchAppointmentsByConsultantId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchAppointmentsByConsultantId(loggedInUserId);
			request.setAttribute("pageTopic", "My Appointments (consultant)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action : hfg hgfg");
		RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchCompletedAppointmentsByConId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchCompletedAppointmentsByConId(loggedInUserId);
			request.setAttribute("pageTopic", "Completed Appointments - Consultant ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action :" + request.getParameter("message"));
		RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchCancelledAppointmentsByConId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchCancelledAppointmentsByConId(loggedInUserId);
			request.setAttribute("pageTopic", "Cancelled Appointments - Consultant ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action :" + request.getParameter("message"));
		RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void fetchUpcomingAppointmentsByConId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println("User from session: " + user);
		if (user == null) {
			message = "You are not logged in!";
			request.setAttribute("feebackMessage", message);
			RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
			rd.forward(request, response);
			return;
		}
		int loggedInUserId = user.getUserId();
		List<Appointment> requestedAppointments = new ArrayList<Appointment>();
		try {
			requestedAppointments = getAppointmentService().fetchUpcomingAppointmentsByConId(loggedInUserId);
			request.setAttribute("pageTopic", "Upcoming Appointments - Consultant ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!(requestedAppointments.size() > 0)) {
			message = "No requested appointments found for the logged-in user!";
		}
		request.setAttribute("requestedAppointments", requestedAppointments);
		request.setAttribute("feebackMessage", message);
		System.out.println("Action :" + request.getParameter("message"));
		RequestDispatcher rd = request.getRequestDispatcher("view-admin-requested-appointments.jsp");
		rd.forward(request, response);
	}

	private void viewAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		System.out.println("Reached the 'appointmentId' method.");
		try {
			Appointment appointment = getAppointmentService().fetchSingleAppointment(appointmentId);
			if (appointment.getAppointmentId() > 0) {
				request.setAttribute("appointment", appointment);
				RequestDispatcher rd = request.getRequestDispatcher("view-and-update-appointment.jsp");
				rd.forward(request, response);
			} else {
				request.setAttribute("message", "No user found!");
				RequestDispatcher rd = request.getRequestDispatcher("user-list.jsp");
				rd.forward(request, response);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void fetchSingleAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			Appointment appointment = getAppointmentService().fetchSingleAppointment(appointmentId);
			if (appointment.getAppointmentId() > 0) {
				request.setAttribute("appointment", appointment);
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

	private void editAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		Appointment appointment = new Appointment();
		appointment.setAppointmentId(Integer.parseInt(request.getParameter("appointmentId")));
		appointment.setSeekerId(Integer.parseInt(request.getParameter("seekerId")));
		appointment.setConsultantId(Integer.parseInt(request.getParameter("consultantId")));
		appointment.setScheduledDate(request.getParameter("scheduledDate"));
		appointment.setStartTime(request.getParameter("startTime"));
		appointment.setStatus(Status.valueOf(request.getParameter("enum-status")));
		appointment.setCountry(request.getParameter("country"));
		appointment.setJob(request.getParameter("job"));
		appointment.setNotes(request.getParameter("notes"));
		try {
			if (getAppointmentService().editAppointment(appointment)) {
				message = "The user has been successfully updated! User ID: " + appointment.getAppointmentId();
			} else {
				message = "Failed to update the user! User ID: " + appointment.getAppointmentId();
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = e.getMessage();
		}
		request.setAttribute("feebackMessage", message);
		RequestDispatcher rd = request.getRequestDispatcher("feedback-message.jsp");
		rd.forward(request, response);
	}

	private void deleteAppointment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearMessage();
		int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
		try {
			boolean deleted = getAppointmentService().deleteAppointment(appointmentId);
			if (deleted) {
				message = "Appointment deleted successfully!";
			} else {
				message = "Failed to delete the appointment.";
			}
		} catch (ClassNotFoundException | SQLException e) {
			message = "Operation failed: " + e.getMessage();
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);

		response.sendRedirect("getAppointment?appactiontype=all");
	}

	private void clearMessage() {
		message = "";
	}
}
