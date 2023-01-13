package question.dto;

public class QuestionComment {
	private int no;
	private String title;
	private String content;
	
	public QuestionComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QuestionComment(int no, String title, String content) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "QuestionComment [no=" + no + ", title=" + title + ", content=" + content + "]";
	}
	
}