package chat.model.dto;

import java.sql.Date;

public class ChatMember {
	
	private int no;
	private int chatNo;
	private String nickname;
	private Date startDate;
	private Date endDate;
	
	public ChatMember() {
		super();
	}

	public ChatMember(int no, int chatNo, String nickname, Date startDate, Date endDate) {
		super();
		this.no = no;
		this.chatNo = chatNo;
		this.nickname = nickname;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "ChatMember [no=" + no + ", chatNo=" + chatNo + ", nickname=" + nickname + ", startDate=" + startDate
				+ ", endDate=" + endDate + "]";
	}
	
}
