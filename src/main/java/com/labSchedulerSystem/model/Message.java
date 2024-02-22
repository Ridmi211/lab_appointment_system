package com.labSchedulerSystem.model;

import java.util.Date;

public class Message {

	private int messageId;
	private Date messageDate;
	private String messangerName;
	private String messangerEmail;
	private String messageBody;
	private MessageStatus messageStatus;

	public Message() {}

	public Message(int messageId, Date messageDate, String messangerName, String messangerEmail, String messageBody,
			MessageStatus messageStatus) {
		this.messageId = messageId;
		this.messageDate = messageDate;
		this.messangerName = messangerName;
		this.messangerEmail = messangerEmail;
		this.messageBody = messageBody;
		this.messageStatus = messageStatus;
	}

	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}

	public Date getMessageDate() {
		return messageDate;
	}

	public void setMessageDate(Date messageDate) {
		this.messageDate = messageDate;
	}

	public String getMessangerName() {
		return messangerName;
	}

	public void setMessangerName(String messangerName) {
		this.messangerName = messangerName;
	}

	public String getMessangerEmail() {
		return messangerEmail;
	}

	public void setMessangerEmail(String messangerEmail) {
		this.messangerEmail = messangerEmail;
	}

	public String getMessageBody() {
		return messageBody;
	}

	public void setMessageBody(String messageBody) {
		this.messageBody = messageBody;
	}

	public MessageStatus getMessageStatus() {
		return messageStatus;
	}

	public void setMessageStatus(MessageStatus messageStatus) {
		this.messageStatus = messageStatus;
	}

	public enum MessageStatus {
		NEW("New"), READ("Replied");

		private final String displayName;

		MessageStatus(String displayName) {
			this.displayName = displayName;
		}

		public String getDisplayName() {
			return displayName;
		}
	}

}
