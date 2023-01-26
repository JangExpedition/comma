package customer.model.dto;

import java.sql.Date;

public class QuestionComment {
	private int no;
	private String writer;
	private int qNo;
	private String content;
	private Date regDate;
	
	public QuestionComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QuestionComment(int no, String content, Date regDate) {
		super();
		this.no = no;
		this.content = content;
		this.regDate = regDate;
	}

	public QuestionComment(int no, String writer, int qNo, String content, Date regDate) {
		super();
		this.no = no;
		this.writer = writer;
		this.qNo = qNo;
		this.content = content;
		this.regDate = regDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getQNo() {
		return qNo;
	}

	public void setQNo(int qNo) {
		this.qNo = qNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "QuestionComment [no=" + no + ", writer=" + writer + ", qNo=" + qNo + ", content=" + content
				+ ", regDate=" + regDate + "]";
	}
	
}