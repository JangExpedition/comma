package question.dto;

import common.Form;

public class Question extends Form{
	
	private String title;

	public Question() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Question(String title) {
		super();
		this.title = title;
	}



	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "Question [title=" + title + ", toString()=" + super.toString() + "]";
	}

	
}
