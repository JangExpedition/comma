package counseling.dto;

import common.Category;
import common.Form;

public class Counseling extends Form{
	private String title;
	private int views;
	private int like;
	private Category category;
	
	public Counseling() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Counseling(String title, int views, int like, Category category) {
		super();
		this.title = title;
		this.views = views;
		this.like = like;
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Counseling [title=" + title + ", views=" + views + ", like=" + like + ", category=" + category
				+ ", toString()=" + super.toString() + "]";
	}
	
}
