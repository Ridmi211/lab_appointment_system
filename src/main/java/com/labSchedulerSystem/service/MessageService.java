package com.labSchedulerSystem.service;
import java.sql.SQLException;
import java.util.List;

import com.labSchedulerSystem.dao.MessageManager;
import com.labSchedulerSystem.dao.MessageManagerImpl;
import com.labSchedulerSystem.model.Message;

public class MessageService {

	private static MessageService MessageServiceObj;

	private MessageService() {
	}

	public synchronized static MessageService getMessageService() {

		if (MessageServiceObj == null) {
			MessageServiceObj = new MessageService();
		}
		return MessageServiceObj;
	}

	private MessageManager getMessageManager() {
		return new MessageManagerImpl();
	}

	public boolean addMessage(Message contact) throws ClassNotFoundException, SQLException {
		return getMessageManager().addMessage(contact);
	}

	public boolean deleteMessage(int messageId) throws ClassNotFoundException, SQLException {
		return getMessageManager().deleteMessage(messageId);
	}

	public List<Message> fetchAllMessages() throws ClassNotFoundException, SQLException {
		return getMessageManager().fetchAllMessages();
	}

	public boolean replyToMessage(int messageId) throws ClassNotFoundException, SQLException {
		MessageManager messageManager = new MessageManagerImpl();
		Message.MessageStatus repliedStatus = Message.MessageStatus.READ; 
		return messageManager.updateMessageStatus(messageId, repliedStatus);
	}

	public int getNewMessagesCount() throws ClassNotFoundException, SQLException {
		MessageManager messageManager = getMessageManager();
		List<Message> newMessages = messageManager.fetchMessagesByStatus(Message.MessageStatus.NEW);
		return newMessages.size();
	}

	public List<Message> fetchAllNewMessages() throws ClassNotFoundException, SQLException {
		MessageManager messageManager = getMessageManager();
		return messageManager.fetchMessagesByStatus(Message.MessageStatus.NEW);
	}

	public static void sendMessageReceivedEmail(Message message) {
		String subject = "Message Received";
		String messageBody = "Dear " + message.getMessangerName() + ",\n\n"
				+ "We have received your message and would like to confirm that it has been successfully received.\n\n"
				+ "Message Details:\n" + "Date: " + message.getMessageDate() + "\n" + "Name: "
				+ message.getMessangerName() + "\n" + "Email: " + message.getMessangerEmail() + "\n" + "Message: "
				+ message.getMessageBody() + "\n" + "\n"
				+ "We appreciate your communication with us. Our team will review your message and respond to your inquiries or concerns as soon as possible. If you have any further questions or need immediate assistance, please contact our support team at [Support Email Address].\n\n"
				+ "Thank you for reaching out to us.\n\n" + "Best regards,\n" + "The Job Consultancy Service Team\n\n"
				+ "Note: This message is auto-generated.";

		EmailService.sendEmail(message.getMessangerEmail(), subject, messageBody);
	}

}