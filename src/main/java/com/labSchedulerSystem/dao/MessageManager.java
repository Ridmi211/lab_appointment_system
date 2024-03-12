package com.labSchedulerSystem.dao;

import java.sql.SQLException;
import java.util.List;
import com.labSchedulerSystem.model.Message;
import com.labSchedulerSystem.model.Message.MessageStatus;

public interface MessageManager {
	
	public boolean addMessage(Message contact) throws SQLException, ClassNotFoundException;
	
	public boolean deleteMessage(int messageId) throws SQLException, ClassNotFoundException;
	
	public List<Message> fetchAllMessages() throws SQLException, ClassNotFoundException;

	public boolean updateMessageStatus(int messageId, MessageStatus messageStatus) throws SQLException, ClassNotFoundException;

    List<Message> fetchMessagesByStatus(MessageStatus messageStatus) throws ClassNotFoundException, SQLException;

}
