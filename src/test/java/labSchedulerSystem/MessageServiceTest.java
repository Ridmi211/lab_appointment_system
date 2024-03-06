package labSchedulerSystem;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import com.labSchedulerSystem.model.Message;
import com.labSchedulerSystem.model.Message.MessageStatus;
import com.labSchedulerSystem.service.MessageService;
import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;

@TestMethodOrder(MethodOrderer.MethodName.class)
class MessageServiceTest {

	private int messageId;

	@Test
	@DisplayName("Add Message")
	void testA() throws ClassNotFoundException, SQLException {
		Message message = new Message();
		message.setMessangerName("Test Name");
		message.setMessangerEmail("test@example.com");
		message.setMessageBody("This is a test message");
		message.setMessageDate(new Date(2024 - 01 - 13));
		message.setMessageStatus(MessageStatus.NEW);
		System.out.println("MessageStatus: " + message.getMessageStatus());
		MessageService messageService = MessageService.getMessageService();
		boolean result = messageService.addMessage(message);
		assertTrue(result, "This should add the message to the database");
		messageId = message.getMessageId();
		System.out.println("MessageId: " + messageId);
	}

	@Test
	@DisplayName("Fetch All Messages")
	void testC() throws ClassNotFoundException, SQLException {
		MessageService messageService = MessageService.getMessageService();
		List<Message> messages = messageService.fetchAllMessages();
		assertNotNull(messages, "This should fetch all messages from the database");
		assertFalse(messages.isEmpty(), "The list of messages should not be empty");
	}

	@Test
	@DisplayName("Get New Messages Count")
	void testE() throws ClassNotFoundException, SQLException {
		MessageService messageService = MessageService.getMessageService();
		int newMessagesCount = messageService.getNewMessagesCount();
		assertTrue(newMessagesCount >= 0, "This should get the count of new messages");
	}

}
