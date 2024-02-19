package com.labSchedulerSystem.model;

import java.util.Date;
import java.util.List;

public class User {

	private int userId;
	private String name;
	private String phoneNumber;
	private String email;
	private String password;
	private String birthdate;
	private String gender;
	private AccessRight accessRight;
	private String educationalQualifications;
	private String specializedJobs;
	private RegistrationStatus registrationStatus;
	private Date registrationDate;

	public User() {
	}

	public User(int userId, String name, String phoneNumber, String email, String password, String birthdate,
			String gender,AccessRight accessRight, String educationalQualifications,String specializedJobs,RegistrationStatus registrationStatus) {

		this.userId = userId;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.password = password;
		this.birthdate = birthdate;
		this.gender = gender;
		this.accessRight = accessRight;
		this.educationalQualifications = educationalQualifications;
		this.specializedJobs = specializedJobs;
		this.registrationStatus = registrationStatus;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public AccessRight getAccessRight() {
		return accessRight;
	}

	public void setAccessRight(AccessRight accessRight) {
		this.accessRight = accessRight;
	}

	public boolean checkPassword(String enteredPassword) {
		return enteredPassword.equals(this.password);
	}

	public String getEducationalQualifications() {
		return educationalQualifications;
	}

	public void setEducationalQualifications(String educationalQualifications) {
		this.educationalQualifications = educationalQualifications;
	}

	public String getSpecializedJobs() {
		return specializedJobs;
	}

	public void setSpecializedJobs(String specializedJobs) {
		this.specializedJobs = specializedJobs;
	}

	public RegistrationStatus getRegistrationStatus() {
		return registrationStatus;
	}

	public void setRegistrationStatus(RegistrationStatus registrationStatus) {
		this.registrationStatus = registrationStatus;
	}

}
