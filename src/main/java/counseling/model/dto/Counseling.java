package counseling.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import common.Attachment;
import common.Category;
import common.Form;
import common.OX;
import member.model.dto.Gender;

public class Counseling extends Form{
	private String title;
	private int views;
	private int like;
	private Category category;
	private Gender limitGender;
	private int limitAge;
	private OX anonymous;
	private List<Attachment> attachments = new ArrayList<>();
	
	public Counseling() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Counseling(int no, String writer, String content, Date regDate) {
		super(no, writer, content, regDate);
		// TODO Auto-generated constructor stub
	}

	public Counseling(int no, String writer, String content, Date regDate, String title, int views, int like, Category category, Gender limitGender, int limitAge,
			OX anonymous) {
		super(no, writer, content, regDate);
		this.title = title;
		this.views = views;
		this.like = like;
		this.category = category;
		this.limitGender = limitGender;
		this.limitAge = limitAge;
		this.anonymous = anonymous;
	}
	
	public Counseling(String title, int views, int like, Category category, Gender limitGender, int limitAge,
			OX anonymous) {
		super();
		this.title = title;
		this.views = views;
		this.like = like;
		this.category = category;
		this.limitGender = limitGender;
		this.limitAge = limitAge;
		this.anonymous = anonymous;
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

	public Gender getLimitGender() {
		return limitGender;
	}

	public void setLimitGender(Gender limitGender) {
		this.limitGender = limitGender;
	}

	public int getLimitAge() {
		return limitAge;
	}

	public void setLimitAge(int limitAge) {
		this.limitAge = limitAge;
	}

	public OX getAnonymous() {
		return anonymous;
	}

	public void setAnonymous(OX anonymous) {
		this.anonymous = anonymous;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	}

	@Override
	public String toString() {
		return "Counseling [title=" + title + ", views=" + views + ", like=" + like + ", category=" + category
				+ ", limitGender=" + limitGender + ", limitAge=" + limitAge + ", anonymous=" + anonymous
				+ ", attachments=" + attachments + ", toString()=" + super.toString() + "]";
	}

}
