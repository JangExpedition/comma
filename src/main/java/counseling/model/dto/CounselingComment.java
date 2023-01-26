package counseling.model.dto;

import java.sql.Date;

import common.OX;
import customer.model.dto.QuestionComment;

public class CounselingComment extends QuestionComment{
	private int commentNo;
	private String writer;
	private OX choice;
	private OX commentLevel;
	private int refCommentNo;
	
	public CounselingComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CounselingComment(int no, String content, Date regDate) {
		super(no, content, regDate);
		// TODO Auto-generated constructor stub
	}
	
	public CounselingComment(int no, String content, Date regDate, int commentNo, String writer, OX choice,
			OX commentLevel, int refCommentNo) {
		super(no, content, regDate);
		this.commentNo = commentNo;
		this.writer = writer;
		this.choice = choice;
		this.commentLevel = commentLevel;
		this.refCommentNo = refCommentNo;
	}
	
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public OX getChoice() {
		return choice;
	}
	public void setChoice(OX choice) {
		this.choice = choice;
	}
	public OX getCommentLevel() {
		return commentLevel;
	}
	public void setCommentLevel(OX commentLevel) {
		this.commentLevel = commentLevel;
	}
	public int getRefCommentNo() {
		return refCommentNo;
	}
	public void setRefCommentNo(int refCommentNo) {
		this.refCommentNo = refCommentNo;
	}
	
	@Override
	public String toString() {
		return "CounselingComment [commentNo=" + commentNo + ", writer=" + writer + ", choice=" + choice
				+ ", commentLevel=" + commentLevel + ", refCommentNo=" + refCommentNo + ", toString()="
				+ super.toString() + "]";
	}
	
}
