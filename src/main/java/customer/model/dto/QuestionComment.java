package customer.model.dto;

import java.sql.Date;

public class QuestionComment {
	private int no;
	private String content;
	private Date regDate;
	
	public QuestionComment(int no, String content, Date regDate) {
		super();
		this.no = no;
		this.content = content;
		this.regDate = regDate;
	}

	public QuestionComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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
		return "QuestionComment [no=" + no + ", content=" + content + ", reg_date=" + regDate + "]";
	}
	
}