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

    public static int messageId;

    @Test
    @DisplayName("Add Message")
    void testA() throws ClassNotFoundException, SQLException {
        Message message = new Message();
        message.setMessangerName("Test Name");
        message.setMessangerEmail("test@example.com");
        message.setMessageBody("This is a test message");

        // Set the messageDate to the current date and time
        message.setMessageDate(new Date(2024-01-13));
        
        // Set MessageStatus to NEW
        message.setMessageStatus(MessageStatus.NEW);
        
        // Print MessageStatus for debugging
        System.out.println("MessageStatus: " + message.getMessageStatus());

        MessageService messageService = MessageService.getMessageService();

        boolean result = messageService.addMessage(message);

        assertTrue(result, "This should add the message to the database");

        // Set messageId for future tests
        messageId = message.getMessageId();
        
        // Print messageId for debugging
        System.out.println("MessageId: " + messageId);
    }


	/*
	 * @Test
	 * 
	 * @DisplayName("Try To Add Duplicate Message") void testB() throws
	 * ClassNotFoundException { Message message = new Message();
	 * message.setMessangerName("Test Name");
	 * message.setMessangerEmail("test@example.com");
	 * message.setMessageBody("This is a test message");
	 * 
	 * MessageService messageService = MessageService.getMessageService();
	 * 
	 * try { messageService.addMessage(message);
	 * 
	 * } catch (MysqlDataTruncation e) { assertEquals(MysqlDataTruncation.class,
	 * e.getClass(), "Expected exception was not thrown."); } catch (SQLException e)
	 * { fail("Unexpected exception: " + e.getMessage()); } }
	 */

    @Test
    @DisplayName("Fetch All Messages")
    void testC() throws ClassNotFoundException, SQLException {
        MessageService messageService = MessageService.getMessageService();

        List<Message> messages = messageService.fetchAllMessages();

        assertNotNull(messages, "This should fetch all messages from the database");
        assertFalse(messages.isEmpty(), "The list of messages should not be empty");
    }

    @Test
    @DisplayName("Reply To Message")
    void testD() throws ClassNotFoundException, SQLException {
        MessageService messageService = MessageService.getMessageService();
        boolean result = messageService.replyToMessage(messageId);

        assertTrue(result, "This should reply to the message");

        // Clean up: Delete the test message from the database if necessary
        boolean deleteResult = messageService.deleteMessage(messageId);
        assertTrue(deleteResult);
    }

    @Test
    @DisplayName("Get New Messages Count")
    void testE() throws ClassNotFoundException, SQLException {
        MessageService messageService = MessageService.getMessageService();

        int newMessagesCount = messageService.getNewMessagesCount();

        assertTrue(newMessagesCount >= 0, "This should get the count of new messages");
    }

    // Add more test methods for other methods in MessageService

    @Test
    @DisplayName("Delete Message")
    void testF() throws ClassNotFoundException, SQLException {
        MessageService messageService = MessageService.getMessageService();

        boolean result = messageService.deleteMessage(messageId);

        assertTrue(result, "This should delete the message");
    }
}
