package notification.model.dto;

import java.sql.Date;

import common.OX;
import ws.MessageType;

public class Notification {

	private int no;
	private String memNick;
	private MessageType messageType;
	private int attachNo;
	private String message;
	private Date notDatetime;
	private OX checkRead;
	
	public Notification() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Notification(int no, String memNick, MessageType messageType, int attachNo, String message, Date notDatetime,
			OX checkRead) {
		super();
		this.no = no;
		this.memNick = memNick;
		this.messageType = messageType;
		this.attachNo = attachNo;
		this.message = message;
		this.notDatetime = notDatetime;
		this.checkRead = checkRead;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMemNick() {
		return memNick;
	}

	public void setMemNick(String memNick) {
		this.memNick = memNick;
	}

	public MessageType getMessageType() {
		return messageType;
	}

	public void setMessageType(MessageType messageType) {
		this.messageType = messageType;
	}

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getNotDatetime() {
		return notDatetime;
	}

	public void setNotDatetime(Date notDatetime) {
		this.notDatetime = notDatetime;
	}

	public OX getCheckRead() {
		return checkRead;
	}

	public void setCheckRead(OX checkRead) {
		this.checkRead = checkRead;
	}

	@Override
	public String toString() {
		return "Notification [no=" + no + ", memNick=" + memNick + ", messageType=" + messageType + ", attachNo="
				+ attachNo + ", message=" + message + ", notDatetime=" + notDatetime + ", checkRead=" + checkRead + "]";
	}
	
}
