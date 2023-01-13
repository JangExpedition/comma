package common;

import java.sql.Date;

public class Form {
	private int no;
	private String writer;
	private String content;
	private Date regDate;
	
	public Form() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Form(int no, String writer, String content, Date regDate) {
		super();
		this.no = no;
		this.writer = writer;
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
		return "Form [no=" + no + ", writer=" + writer + ", content=" + content + ", regDate=" + regDate + "]";
	}
	
	
}
