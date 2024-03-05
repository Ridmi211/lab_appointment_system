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

	public String generateReferenceId() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmm");
		String uniqueId = UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 4);
		String referenceId = "REF-" + now.format(formatter) + uniqueId;
		return referenceId;
	}

	public static void sendAppointmentConfirmationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Appointment Confirmation - Test at MediCheck Laboratory Services";
		StringBuilder messageBody = new StringBuilder("Dear " + seeker.getName() + ",\n\n"
				+ "Thank you for scheduling your test appointment with MediCheck Laboratory Services. We appreciate your trust in our services.\n\n"
				+ "Appointment Details:\n" + "Technician: " + consultant.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Test Type: " + appointment.getTestType().getDisplayName()
				+ "\n" + "Recommended Doctor: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n\n"
				+ "Your appointment request has been received, and our team is preparing for your visit. We will notify you as soon as your appointment is scheduled.\n\n"
				+ "If you have any questions or need further assistance, please feel free to contact our support team at [Support Email Address].\n\n"
				+ "Thank you for choosing MediCheck Laboratory Services. We look forward to serving you.\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team");
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody.toString());
	}

	public static void sendNewAppointmentNotificationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "New Appointment Request";
		String messageBody = "Dear " + consultant.getName() + ",\n\n" + "You have a new appointment request from "
				+ seeker.getName() + ".\n\n" + "Appointment Details:\n" + "Date: " + appointment.getScheduledDate()
				+ "\n" + "Time: " + appointment.getStartTime() + "\n" + "Test Type: "
				+ appointment.getTestType().getDisplayName() + "\n" + "Recommended Doctor: "
				+ appointment.getRecomendedDoctor() + "\n" + "Notes: " + appointment.getNotes() + "\n\n"
				+ "Please review the details and confirm or reschedule the appointment accordingly. \n\n"
				+ "If you have any questions or need further assistance, please feel free to contact our support team at [Support Email Address].\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(consultant.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentAcceptedEmail(Appointment appointment, User consultant, User seeker, Test test) {
		String subject = "Appointment and Test Details Confirmation";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We are excited to inform you that your appointment request has been successfully accepted at "
				+ "MediCheck Laboratory Services.Your appointment ID is " + appointment.getAppointmentRefId()
				+ " We understand the importance of your health journey and are committed to providing you with the utmost care and assistance.\n\n"
				+ "Your appointment is scheduled to take place on " + appointment.getScheduledDate() + " at "
				+ appointment.getStartTime() + " with our experienced technician, " + consultant.getName() + ".\n\n"
				+ "The test you are scheduled for is " + test.getType() + ". This test is designed to "
				+ test.getDescription() + ". The cost of this test is " + test.getCost() + ", and your "
				+ "report will be ready in approximately " + test.getReportReadyIn() + "."
				+ " Prior to your appointment, please follow the preparation instructions provided to ensure accurate results.\n\n"
				+ "Appointment Details:\n" + "- Technician: " + consultant.getName() + "\n" + "- Date: "
				+ appointment.getScheduledDate() + "\n" + "- Time: " + appointment.getStartTime() +

				"\n\n" + "Recommended Doctor: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n\n" + "Test Details:\n" + "- Test Type: "
				+ test.getType().getDisplayName() + "\n" + "- Description: " + test.getDescription() + "\n" + "- Cost: "
				+ test.getCost() + "\n" + "- Report Ready In: " + test.getReportReadyIn() + "\n"
				+ "- Preparation Instructions: " + test.getPreparationInstructions() + "\n" + "- Measurement Unit: "
				+ test.getMeasurementUnit() + "\n" + "- Reference Ranges:\n" + "  - Low: " + test.getLowReferenceRange()
				+ "\n" + "  - High: " + test.getHighReferenceRange() + "\n\n"
				+ "Your well-being is our top priority, and our team is here to assist you every step of the way. "
				+ "If you have any questions or require further assistance, please do not hesitate to contact our support team at mediCheckSupport@gmail.com.\n\n"
				+ "We look forward to seeing you on " + appointment.getScheduledDate() + " at "
				+ appointment.getStartTime()
				+ ". Thank you for choosing MediCheck Laboratory Services for your health needs.\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCompletedEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Your Test Results are Ready - Thank You for Choosing MediCheck Laboratory Services";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We hope this email finds you well. We are pleased to inform you that your recent test results are now available. Your health and well-being are our top priorities, and we are committed to providing you with the best possible care and support.\n\n"
				+ "**Appointment Details:**\n" + "- Test Type: " + appointment.getTestType().getDisplayName() + "\n"
				+ "- Technician: " + consultant.getName() + "\n" + "- Date: " + appointment.getScheduledDate() + "\n"
				+ "- Time: " + appointment.getStartTime() + "\n" + "Recommended Doctor: "
				+ appointment.getRecomendedDoctor() + "\n\\n"

				+ "**Test Results:**\n" + "- Results: " + appointment.getTestResults() + "\n" + "- Description: "
				+ appointment.getTestResultsDescription() + "\n" + "- Conducted By: " + appointment.getTestUpdatedOn()
				+ "\n" + "- Documented By: " + appointment.getTestUpdatedBy() + "\n" + "- Documented on: "
				+ appointment.getTestUpdatedOn() + "\n\\n"
				+ "We understand that receiving test results can be a crucial moment, and we want to ensure that you have all the information you need. Please remember to follow up with your healthcare provider to discuss these results and any necessary next steps. If you have any questions or concerns about your test results, please do not hesitate to contact our support team at [Support Email Address]. We are here to provide you with assistance and guidance every step of the way.\n\n"
				+ "Your health journey is important to us, and we are committed to supporting you in maintaining your well-being. Thank you for choosing MediCheck Laboratory Services for your health needs. We appreciate your trust in us and look forward to serving you in the future.\n\n"
				+ "Best regards,\n\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationEmail(Appointment appointment, User consultant, User seeker) {
		String subject = "Test Appointment Cancellation";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We regret to inform you that your test appointment with " + consultant.getName()
				+ " has been canceled due to unavoidable reasons.\n\n" + "Appointment Details:\n" + "Technician: "
				+ consultant.getName() + "\n" + "Date: " + appointment.getScheduledDate() + "\n" + "Time: "
				+ appointment.getStartTime() + "\n" + "Country: " + appointment.getCountry() + "\n" + "Test: "
				+ appointment.getRecomendedDoctor() + "\n" + "Notes: " + appointment.getNotes() + "\n" + "\n"
				+ "We sincerely apologize for any inconvenience this may cause. We understand the importance of your appointment and are committed to providing the best service possible. Please feel free to reschedule your test appointment at your convenience, and we will prioritize your preferences.\n\n"
				+ "If you have any questions or need further assistance, please contact our support team at [Support Email Address].\n\n"
				+ "Thank you for your understanding, and we look forward to assisting you on your health journey.\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationBySeekerEmailToSeeker(Appointment appointment, User consultant,
			User seeker) {
		String subject = "Test Appointment Cancellation";
		String messageBody = "Dear " + seeker.getName() + ",\n\n"
				+ "We would like to inform you that your test appointment with " + consultant.getName()
				+ " scheduled for " + appointment.getScheduledDate() + " at " + appointment.getStartTime()
				+ " has been canceled. We understand that circumstances may change, and we appreciate your prompt communication regarding this matter.\n\n"
				+ "Appointment Details:\n" + "Technician: " + consultant.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: "
				+ appointment.getCountry() + "\n" + "Test: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "If possible, could you please provide the reasons for the cancellation? Your feedback is valuable to us and will help us improve our services. You can reply to this email or contact our support team at [Support Email Address].\n\n"
				+ "If you still wish to undergo the test or reschedule your appointment, please visit our website or contact our support team. We will do our best to accommodate your preferences.\n\n"
				+ "We apologize for any inconvenience this may have caused and appreciate your understanding. If you have any questions or need further assistance, feel free to reach out to our support team.\n\n"
				+ "Thank you for considering our services, and we look forward to assisting you in the future.\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(seeker.getEmail(), subject, messageBody);
	}

	public static void sendAppointmentCancellationBySeekerEmailToConsultant(Appointment appointment, User consultant,
			User seeker) {
		String subject = "Test Appointment on " + appointment.getScheduledDate() + " Cancellation";
		String messageBody = "Dear " + consultant.getName() + ",\n\n"
				+ "We regret to inform you that the test appointment scheduled with you by " + seeker.getName() + "on"
				+ appointment.getScheduledDate() + " has been canceled due to unforeseen circumstances.\n\n"
				+ "Appointment Details:\n" + "Patient: " + seeker.getName() + "\n" + "Date: "
				+ appointment.getScheduledDate() + "\n" + "Time: " + appointment.getStartTime() + "\n" + "Country: "
				+ appointment.getCountry() + "\n" + "Test: " + appointment.getRecomendedDoctor() + "\n" + "Notes: "
				+ appointment.getNotes() + "\n" + "\n"
				+ "We understand the importance of your consultations and apologize for any inconvenience this may cause. If you have availability for additional consultations or if the patient decides to reschedule, we will notify you promptly. Your understanding and flexibility are appreciated.\n\n"
				+ "Thank you for your commitment to providing valuable laboratory services. If you have any further questions or need assistance, please do not hesitate to reach out to our support team at [Support Email Address].\n\n"
				+ "Best regards,\n" + "The MediCheck Laboratory Services Team";
		EmailService.sendEmail(consultant.getEmail(), subject, messageBody);
	}

}
