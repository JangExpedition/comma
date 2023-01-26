package counseling.model.dto;

import common.OX;
import customer.model.dto.QuestionComment;

public class CounselingComment extends QuestionComment{
	private OX choice;
	private OX commentLevel;
	private int refCommentNo;
	
	public CounselingComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CounselingComment(int no, String title, String content) {
		super(no, title, content);
		// TODO Auto-generated constructor stub
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
		return "CounselingComment [choice=" + choice + ", commentLevel=" + commentLevel + ", refCommentNo="
				+ refCommentNo + ", toString()=" + super.toString() + "]";
	}
	
}
