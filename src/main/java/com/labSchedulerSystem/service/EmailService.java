package com.labSchedulerSystem.service;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {

	private static EmailService emailServiceObj;

	private EmailService() {
	}

	public synchronized static EmailService getEmailService() {
		if (emailServiceObj == null) {
			emailServiceObj = new EmailService();
		}
		return emailServiceObj;
	}

	public static void sendEmail(String recipient, String subject, String messageBody) {
		final String username = "testingcodefield@gmail.com"; // email address
		final String password = "v j b y h x p q p e b x i m e d"; // email password
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
			message.setSubject(subject);
			message.setText(messageBody);
			Transport.send(message);
			System.out.println("Email sent successfully to " + recipient);
		} catch (MessagingException e) {
			e.printStackTrace();
			System.out.println("Failed to send email to " + recipient);
		}
	}
}
