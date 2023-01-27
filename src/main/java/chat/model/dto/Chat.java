package chat.model.dto;

import java.sql.Date;

import member.model.dto.Gender;

public class Chat {
	
	private int no;
	private String chatName;
	private String captin;
	private Gender ableGender;
	private int ableAge;
	private int ableCount;
	private Date regDate;
	
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Chat(int no, String chatName, String captin, Gender ableGender, int ableAge, int ableCount, Date regDate) {
		super();
		this.no = no;
		this.chatName = chatName;
		this.captin = captin;
		this.ableGender = ableGender;
		this.ableAge = ableAge;
		this.ableCount = ableCount;
		this.regDate = regDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getChatName() {
		return chatName;
	}

	public void setChatName(String chatName) {
		this.chatName = chatName;
	}

	public String getCaptin() {
		return captin;
	}

	public void setCaptin(String captin) {
		this.captin = captin;
	}

	public Gender getAbleGender() {
		return ableGender;
	}

	public void setAbleGender(Gender ableGender) {
		this.ableGender = ableGender;
	}

	public int getAbleAge() {
		return ableAge;
	}

	public void setAbleAge(int ableAge) {
		this.ableAge = ableAge;
	}

	public int getAbleCount() {
		return ableCount;
	}

	public void setAbleCount(int ableCount) {
		this.ableCount = ableCount;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Chat [no=" + no + ", chatName=" + chatName + ", captin=" + captin + ", ableGender=" + ableGender
				+ ", ableAge=" + ableAge + ", ableCount=" + ableCount + ", regDate=" + regDate + "]";
	}
	
}
