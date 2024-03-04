package com.labSchedulerSystem.service;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import com.labSchedulerSystem.dao.AppointmentManager;
import com.labSchedulerSystem.dao.AppointmentManagerImpl;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.Test;
import com.labSchedulerSystem.model.User;
import com.labSchedulerSystem.model.Appointment.Status;

public class AppointmentService {

	private static AppointmentService appointmentServiceObj;

	private AppointmentService() {

	}

	public synchronized static AppointmentService getAppointmentService() {

		if (appointmentServiceObj == null) {
			appointmentServiceObj = new AppointmentService();
		}

		return appointmentServiceObj;
	}

	private AppointmentManager getAppointmentManager() {
		return new AppointmentManagerImpl();
	}

	public boolean addAppointment(Appointment appointment) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().addAppointment(appointment);
	}

	public boolean editAppointment(Appointment appointment) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().editAppointment(appointment);
	}

	public boolean deleteAppointment(int appointmentCode) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().deleteAppointment(appointmentCode);
	}

	public Appointment fetchSingleAppointment(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchSingleAppointment(appointmentId);
	}
	
	public Test fetchSingleTest(int testId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchSingleTest(testId);
	}

	public List<Appointment> fetchAllAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAllAppointments();
	}

	public List<Appointment> fetchRequestedAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchRequestedAppointments();
	}

	public List<Appointment> fetchAdminRequestedAllAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAdminRequestedAllAppointments();
	}
	
	public List<Test> fetchAllTests() throws SQLException, ClassNotFoundException {
		return getAppointmentManager().fetchAllTests();
	}

	public List<Appointment> fetchAllCompletedAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAllCompletedAppointments();
	}

	public List<Appointment> fetchConsultantRejectedAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchConsultantRejectedAppointments();
	}

	public List<Appointment> fetchSeekerCancelledAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchSeekerCancelledAppointments();
	}

	public List<Appointment> fetchConsultantConfiremedAppointments() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchConsultantConfiremedAppointments();
	}

	public List<Appointment> fetchAdminRequestedAppointments(int loggedInUserId)
			throws ClassNotFoundException, SQLException {

		return getAppointmentManager().fetchAdminRequestedAppointments(loggedInUserId);
	}

	public List<Appointment> fetchAppointmentsBySeekerId(int loggedInUserId)
			throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAppointmentsBySeekerId(loggedInUserId);
	}

	public List<Appointment> fetchAppointmentsByConsultantId(int loggedInUserId)
			throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAppointmentsByConsultantId(loggedInUserId);
	}

	public List<Appointment> fetchCompletedAppointmentsByConId(int loggedInUserId)
			throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchCompletedAppointmentsByConId(loggedInUserId);
	}

	public List<Appointment> fetchCancelledAppointmentsByConId(int loggedInUserId)
			throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchCancelledAppointmentsByConId(loggedInUserId);
	}

	public List<Appointment> fetchUpcomingAppointmentsByConId(int loggedInUserId)
			throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchUpcomingAppointmentsByConId(loggedInUserId);
	}

	public boolean updateAppointmentStatus(int appointmentId, Status status)
			throws SQLException, ClassNotFoundException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, status);
	}

	public boolean acceptAppointmentAdmin(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.ADMIN_CONFIRMED);
	}

	public boolean cancelAppointmentAdmin(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.ADMIN_CANCELLED);
	}

	public boolean acceptAppointmentCon(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.CON_CONFIRMED);
	}

	public boolean rejectAppointmentCon(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.CON_REJECTED);
	}

	public boolean completedAppointment(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.COMPLETED);
	}

	public boolean cancelAppointmentSeeker(int appointmentId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().updateAppointmentStatus(appointmentId, Status.SEEKER_CANCELLED);
	}

	public int getTotalAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAllAppointments().size();
	}

	public int getCompletedAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAllCompletedAppointments().size();
	}

	public int getAdminRequestedAllAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAdminRequestedAllAppointments().size();
	}

	public int getRequestedAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchRequestedAppointments().size();
	}

	public int getAdminRequestedAppointmentsCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAdminRequestedAppointments(loggedInUserId).size();
	}

	public int getConsultantConfirmedAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchConsultantConfiremedAppointments().size();
	}

	public int getConsultantRejectedAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchConsultantRejectedAppointments().size();
	}

	public int getSeekerCancelledAppointmentsCount() throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchSeekerCancelledAppointments().size();
	}

	public int getAppointmentsBySeekerIdCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAppointmentsBySeekerId(loggedInUserId).size();
	}

	public int getAppointmentsByConsultantIdCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchAppointmentsByConsultantId(loggedInUserId).size();
	}

	public int getCompletedAppointmentsByConIdCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchCompletedAppointmentsByConId(loggedInUserId).size();
	}

	public int getCancelledAppointmentsByConIdCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchCancelledAppointmentsByConId(loggedInUserId).size();
	}

	public int getUpcomingAppointmentsByConIdCount(int loggedInUserId) throws ClassNotFoundException, SQLException {
		return getAppointmentManager().fetchUpcomingAppointmentsByConId(loggedInUserId).size();
	}
	
	/*
	 * public String generateReferenceId() { // Get current date/time information
	 * LocalDateTime now = LocalDateTime.now(); DateTimeFormatter formatter =
	 * DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
	 * 
	 * // Generate a unique identifier for the appointment // You can use UUID or
	 * any other method to ensure uniqueness String uniqueId =
	 * UUID.randomUUID().toString().substring(0, 6); // Using first 6 characters of
	 * UUID
	 * 
	 * // Concatenate "ref", date/time information, and unique identifier to form
	 * reference ID String referenceId = "ref" + now.format(formatter) + "-" +
	 * uniqueId; return referenceId; }
	 */

	public String generateReferenceId() {
	    LocalDateTime now = LocalDateTime.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmm");
	    String uniqueId = UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 4);
	    String referenceId = "REF-" + now.format(formatter) + uniqueId;
	    return referenceId;
	}

	

	public static void sendAppointmentConfirmationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Appointment Request Received";
		StringBuilder messageBody = new StringBuilder("Dear " + seeker.getName() + ",\n\n"
				+ "We want to thank you for submitting your appointment request. Your interest in our services is greatly appreciated.\n\n"
				+ "Appointment Details:\n" + "Consultant: " + consultant.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: "
				+ appointment.getCountry() + "\n" + "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "We have received your request and our team is currently reviewing it. We will notify you as soon as your appointment is scheduled. Your convenience is our priority, and we will do our best to accommodate your preferred date and time.\n\n"
				+ "If you have any specific preferences or questions, please feel free to contact our support team at [Support Email Address].\n\n"
				+ "Thank you for considering our services. We look forward to assisting you on your journey to work abroad.\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team");
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody.toString());
	}

	public static void sendNewAppointmentNotificationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "New Appointment Request";
		String messageBody = "Dear " + consultant.getName() + ",\n\n" + "You have a new appointment request from "
				+ seeker.getName() + ".\n\n" + "Appointment Details:\n" + "Date: " + appointment.getScheduledDate()
				+ "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: " + appointment.getCountry() + "\n"
				+ "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: " + appointment.getNotes() + "\n" + "\n"
				+ "Please review the details and confirm or reschedule the appointment accordingly. If you have any questions or need further assistance, please feel free to contact our support team at [Support Email Address].\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		EmailService.sendEmail(consultant.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentAcceptedEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Appointment Scheduled";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We are pleased to inform you that your appointment request has been accepted by "
				+ consultant.getName() + ".\n\n" + "Appointment Details:\n" + "Consultant: " + consultant.getName()
				+ "\n" + "Date: " + appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n"
				+ "Country: " + appointment.getCountry() + "\n" + "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "Your appointment is scheduled and confirmed. Please make sure to attend the appointment at the specified date and time. If you have any questions or need further assistance, please feel free to contact our support team at [Support Email Address].\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCompletedEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Thank You for choosing us";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We want to express our sincere thanks for choosing our services and for completing your recent appointment with "
				+ consultant.getName() + ".\n\n" + "Appointment Details:\n" + "Consultant: " + consultant.getName()
				+ "\n" + "Date: " + appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n"
				+ "Country: " + appointment.getCountry() + "\n" + "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "We're eager to hear about your experience and how we can make it even better.Your feedback is invaluable to us as it guides our continuous improvement. Please take a moment to share your thoughts by filling out our feedback form: [Google Form Link]\n\n"
				+ "Your input helps us ensure that we provide the best support on your journey to a successful career abroad. We appreciate your time and effort in making our services better for you.\n\n"
				+ "If you have any further questions or need additional assistance, don't hesitate to contact our support team at [Support Email Address]. We're here to support you every step of the way.\n\n"
				+ "Once again, thank you for choosing us. We're excited to continue assisting you on your path to success.\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		String googleFormLink = "https://forms.gle/6ubUZQAmgTvQ4xBu7";
		messageBody = messageBody.replace("[Google Form Link]", googleFormLink);
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Appointment Cancellation";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We regret to inform you that your appointment with " + consultant.getName()
				+ " has been canceled due to unavoidable reasons.\n\n" + "Appointment Details:\n" + "Consultant: "
				+ consultant.getName() + "\n" + "Date: " + appointment.getScheduledDate() + "\n" + "Time: "
				+ appointment.getStartTime() + "\n" + "Country: " + appointment.getCountry() + "\n" + "Job: "
				+ appointment.getRecomendedDoctor() + "\n" + "Notes: " + appointment.getNotes() + "\n" + "\n"
				+ "We sincerely apologize for any inconvenience this may cause. We understand the importance of your appointment and are committed to providing the best service possible. Please feel free to reschedule your appointment at your convenience, and we will prioritize your preferences.\n\n"
				+ "If you have any questions or need further assistance, please contact our support team at [Support Email Address].\n\n"
				+ "Thank you for your understanding, and we look forward to assisting you on your journey to work abroad.\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationBySeekerEmailToSeeker(Appointment appointment, User consultant,
			User seeker) {
		String subject = "Appointment Cancellation";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We would like to inform you that your appointment with " + consultant.getName() + " scheduled for "
				+ appointment.getScheduledDate() + " at " + appointment.getStartTime()
				+ " has been canceled. We understand that circumstances may change, and we appreciate your prompt communication regarding this matter.\n\n"
				+ "Appointment Details:\n" + "Consultant: " + consultant.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: "
				+ appointment.getCountry() + "\n" + "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "If possible, could you please provide the reasons for the cancellation? Your feedback is valuable to us and will help us improve our services. You can reply to this email or contact our support team at [Support Email Address].\n\n"
				+ "If you still wish to consult with " + consultant.getName()
				+ " or reschedule your appointment, please visit our website or contact our support team. We will do our best to accommodate your preferences.\n\n"
				+ "We apologize for any inconvenience this may have caused and appreciate your understanding. If you have any questions or need further assistance, feel free to reach out to our support team.\n\n"
				+ "Thank you for considering our services, and we look forward to assisting you in the future.\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationBySeekerEmailToConsultant(Appointment appointment, User consultant,
			User seeker) {
		String subject = "Appointment on " + appointment.getScheduledDate() + " Cancellation";
		String messageBody = "Dear " + consultant.getName() + ",\n\n"
				+ "We regret to inform you that the appointment scheduled with you by " + seeker.getName() + "on"
				+ appointment.getScheduledDate() + " has been canceled due to unforeseen circumstances.\n\n"
				+ "Appointment Details:\n" + "Seeker: " + seeker.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: "
				+ appointment.getCountry() + "\n" + "Job: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "We understand the importance of your consultations and apologize for any inconvenience this may cause. If you have availability for additional consultations or if the seeker decides to reschedule, we will notify you promptly. Your understanding and flexibility are appreciated.\n\n"
				+ "Thank you for your commitment to providing valuable consultancy services. If you have any further questions or need assistance, please do not hesitate to reach out to our support team at [Support Email Address].\n\n"
				+ "Best regards,\n" + "The Job Consultancy Service Team";
		EmailService.sendEmail(consultant.getEmail(), subject, messageBody);
	}

}
