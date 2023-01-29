package chat.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import member.model.dto.Gender;

public class Chat {
	
	private int no;
	private String chatName;
	private String captin;
	private Gender ableGender;
	private int ableAge;
	private int nowCount;
	private int ableCount;
	private Date regDate;
	private List<ChatMember> chatMembers = new ArrayList<>();
	private List<ChatLog> chatLogs = new ArrayList<>();
	
	public Chat() {
		super();
	}

	public Chat(int no, String chatName, String captin, Gender ableGender, int ableAge, int nowCount, int ableCount, Date regDate) {
		super();
		this.no = no;
		this.chatName = chatName;
		this.captin = captin;
		this.ableGender = ableGender;
		this.ableAge = ableAge;
		this.nowCount = nowCount;
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

	public List<ChatMember> getChatMembers() {
		return chatMembers;
	}

	public void setChatMembers(List<ChatMember> chatMembers) {
		this.chatMembers = chatMembers;
	}

	public List<ChatLog> getChatLogs() {
		return chatLogs;
	}

	public void setChatLogs(List<ChatLog> chatLogs) {
		this.chatLogs = chatLogs;
	}
	

	public int getNowCount() {
		return nowCount;
	}

	public void setNowCount(int nowCount) {
		this.nowCount = nowCount;
	}

	@Override
	public String toString() {
		return "Chat [no=" + no + ", chatName=" + chatName + ", captin=" + captin + ", ableGender=" + ableGender
				+ ", ableAge=" + ableAge + ", nowCount=" + nowCount + ", ableCount=" + ableCount + ", regDate="
				+ regDate + ", chatMembers=" + chatMembers + ", chatLogs=" + chatLogs + ", toString()="
				+ super.toString() + "]";
	}

}
