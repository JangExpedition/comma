package chat.model.dto;

import java.sql.Date;

public class ChatLog {
	
	private int no;
	private int chatNo;
	private String memberNick;
	private String content;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
	public ChatLog() {
		super();
	}

	public ChatLog(int no, int chatNo, String memberNick, String content, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.no = no;
		this.chatNo = chatNo;
		this.memberNick = memberNick;
		this.content = content;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getRenamedFilename() {
		return renamedFilename;
	}

	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	@Override
	public String toString() {
		return "ChatLog [no=" + no + ", chatNo=" + chatNo + ", memberNick=" + memberNick + ", content=" + content
				+ ", originalFilename=" + originalFilename + ", renamedFilename=" + renamedFilename + ", regDate="
				+ regDate + "]";
	}
	
}
