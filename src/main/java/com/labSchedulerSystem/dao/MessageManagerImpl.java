package com.labSchedulerSystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.labSchedulerSystem.dao.dbUtils.DbDriverManager;
import com.labSchedulerSystem.dao.dbUtils.DbDriverManagerFactory;
import com.labSchedulerSystem.model.Appointment;
import com.labSchedulerSystem.model.Message;
import com.labSchedulerSystem.model.Appointment.Status;
import com.labSchedulerSystem.model.Message.MessageStatus;

public class MessageManagerImpl implements MessageManager {

	public MessageManagerImpl() {
		// TODO Auto-generated constructor stub
	}

	private Connection getConnection() throws ClassNotFoundException, SQLException {
		DbDriverManagerFactory driverFactory = new DbDriverManagerFactory();
		DbDriverManager driverManager = driverFactory.getDbDriver("MySQL");
		return driverManager.getConnection();
	}

	@Override
	public boolean addMessage(Message contact) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "INSERT INTO messages(`messageDate`, `messangerName`, `messangerEmail`, `messageBody`, `messageStatus`) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setDate(1, new java.sql.Date(contact.getMessageDate().getTime()));
		ps.setString(2, contact.getMessangerName());
		ps.setString(3, contact.getMessangerEmail());
		ps.setString(4, contact.getMessageBody());
		ps.setString(5, contact.getMessageStatus().name());
		boolean result = false;
		if (ps.executeUpdate() > 0) {
			result = true;
		}
		ps.close();
		connection.close();
		return result;
	}

	@Override
	public boolean deleteMessage(int messageId) throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "DELETE FROM messages WHERE messageId=?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, messageId);
		boolean result = false;
		if (ps.executeUpdate() > 0) {
			result = true;
		}
		ps.close();
		connection.close();
		return result;
	}

	public List<Message> fetchAllMessages() throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "SELECT * FROM messages";
		Statement st = connection.createStatement();
		List<Message> messageList = new ArrayList<Message>();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			Message contact = new Message();
			contact.setMessageId(rs.getInt("messageId"));
			contact.setMessageDate(rs.getDate("messageDate"));
			contact.setMessangerName(rs.getString("messangerName"));
			contact.setMessangerEmail(rs.getString("messangerEmail"));
			contact.setMessageBody(rs.getString("messageBody"));
			contact.setMessageStatus(MessageStatus.valueOf(rs.getString("messageStatus")));
			messageList.add(contact);
		}
		st.close();
		connection.close();
		return messageList;
	}

	public boolean updateMessageStatus(int messageId, Message.MessageStatus messageStatus)
			throws SQLException, ClassNotFoundException {
		Connection connection = getConnection();
		String query = "UPDATE messages SET messageStatus = ? WHERE messageId = ?";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, messageStatus.name());
		ps.setInt(2, messageId);
		boolean result = false;
		if (ps.executeUpdate() > 0)
			result = true;
		ps.close();
		connection.close();
		return result;
	}

	public List<Message> fetchMessagesByStatus(Message.MessageStatus status)
			throws ClassNotFoundException, SQLException {
		List<Message> messageList = new ArrayList<>();
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("SELECT * FROM messages WHERE messageStatus = ?")) {
			ps.setString(1, status.name());
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Message contact = new Message();
					contact.setMessageId(rs.getInt("messageId"));
					contact.setMessageDate(rs.getDate("messageDate"));
					contact.setMessangerName(rs.getString("messangerName"));
					contact.setMessangerEmail(rs.getString("messangerEmail"));
					contact.setMessageBody(rs.getString("messageBody"));
					contact.setMessageStatus(MessageStatus.valueOf(rs.getString("messageStatus"))); 
					messageList.add(contact);
				}
			}
		}
		return messageList;
	}
}
