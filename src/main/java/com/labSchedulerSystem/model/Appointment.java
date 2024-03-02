package com.labSchedulerSystem.model;



public class Appointment {

	private int appointmentId;
	private String appointmentRefId;
	private int technitianId;
	private String consultantName;
	private String seekerName;
	private int seekerId;
	private String country;
	private String recomendedDoctor;
	private String scheduledDate;
	private String startTime;
	private Status status;
	private String notes;
	private String seekerEmail;
	private String seekerPhoneNumber;
	private String seekerJob;
	private String seekerCountry;
	private String testType;
	private String testResults;
	private String testResultsDescription;
	/* private String recomendedDoctor; */
	    
	    //testtype table
	
	

	public String getSeekerEmail() {
		return seekerEmail;
	}

	public void setSeekerEmail(String seekerEmail) {
		this.seekerEmail = seekerEmail;
	}

	public String getSeekerPhoneNumber() {
		return seekerPhoneNumber;
	}

	public void setSeekerPhoneNumber(String seekerPhoneNumber) {
		this.seekerPhoneNumber = seekerPhoneNumber;
	}

	public String getSeekerJob() {
		return seekerJob;
	}

	public void setSeekerJob(String seekerJob) {
		this.seekerJob = seekerJob;
	}

	public String getSeekerCountry() {
		return seekerCountry;
	}

	public void setSeekerCountry(String seekerCountry) {
		this.seekerCountry = seekerCountry;
	}

	public Appointment() {
	}

	public Appointment(int appointmentId, String startTime, Status status, String location, String notes,
			String updatedCvFilePath) {
		this.appointmentId = appointmentId;
		this.startTime = startTime;
		this.status = status;
		this.notes = notes;
	}

	public int getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public int getTechnitianId() {
		return technitianId;
	}

	public void setTechnitianId(int technitianId) {
		this.technitianId = technitianId;
	}

	public int getSeekerId() {
		return seekerId;
	}

	public void setSeekerId(int seekerId) {
		this.seekerId = seekerId;
	}

	public String getScheduledDate() {
		return scheduledDate;
	}

	public void setScheduledDate(String scheduledDate) {
		this.scheduledDate = scheduledDate;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	/*
	 * public String getJob() { return job; }
	 * 
	 * public void setJob(String job) { this.job = job; }
	 */

	public String getConsultantName() {
		return consultantName;
	}

	public void setConsultantName(String consultantName) {
		this.consultantName = consultantName;
	}

	public String getSeekerName() {
		return seekerName;
	}

	public void setSeekerName(String seekerName) {
		this.seekerName = seekerName;
	}

	public String getTestResults() {
		return testResults;
	}

	public void setTestResults(String testResults) {
		this.testResults = testResults;
	}

	public String getTestResultsDescription() {
		return testResultsDescription;
	}

	public void setTestResultsDescription(String testResultsDescription) {
		this.testResultsDescription = testResultsDescription;
	}

	public String getRecomendedDoctor() {
		return recomendedDoctor;
	}

	public void setRecomendedDoctor(String recomendedDoctor) {
		this.recomendedDoctor = recomendedDoctor;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

	public String getAppointmentRefId() {
		return appointmentRefId;
	}

	public void setAppointmentRefId(String appointmentRefId) {
		this.appointmentRefId = appointmentRefId;
	}

	public enum Status {
		REQUESTED("Requested"), ADMIN_CONFIRMED("Admin-Confirmed"), CON_CONFIRMED("Consultant-Confirmed"),
		CON_REJECTED("Rejected"), COMPLETED("Completed"), SEEKER_CANCELLED("Seeker-Cancelled"),
		ADMIN_CANCELLED(" Admin-Cancelled");

		private final String displayName;

		Status(String displayName) {
			this.displayName = displayName;
		}

		public String getDisplayName() {
			return displayName;
		}
	}

}