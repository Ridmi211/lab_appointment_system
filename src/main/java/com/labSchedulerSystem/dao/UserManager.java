package com.labSchedulerSystem.dao;

import java.sql.SQLException;
import java.util.List;

import com.labSchedulerSystem.model.RegistrationStatus;
import com.labSchedulerSystem.model.User;

public interface UserManager {

	public boolean addUser(User user) throws SQLException, ClassNotFoundException;

	public boolean editUser(User user) throws SQLException, ClassNotFoundException;

	public boolean deleteUser(int userId) throws SQLException, ClassNotFoundException;

	public User fetchSingleUser(int userId) throws SQLException, ClassNotFoundException;

	public List<User> fetchAllUsers() throws SQLException, ClassNotFoundException;

	public User fetchUserByEmail(String email) throws SQLException, ClassNotFoundException;

	public boolean isEmailAlreadyExists(String email) throws SQLException, ClassNotFoundException;

	public List<User> fetchAllConsultantUsers() throws SQLException, ClassNotFoundException;

	boolean updateRegistrationStatus(int userId, RegistrationStatus status) throws SQLException, ClassNotFoundException;

	public List<User> fetchPendingUsers() throws SQLException, ClassNotFoundException;

}
