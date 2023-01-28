package diary.model.dto;

import java.sql.Date;

import common.Form;

public class Diary {
	
	private int no;
	private String writer;
	private String content;
	private int designNo;
	private int fontNo;
	private String originalFilename;
	private String renamedFilename;
	private String regDate;
	
	public Diary() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Diary(int no, String writer, String content, int designNo, int fontNo, String originalFilename,
			String renamedFilename, String regDate) {
		super();
		this.no = no;
		this.writer = writer;
		this.content = content;
		this.designNo = designNo;
		this.fontNo = fontNo;
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

	public int getDesignNo() {
		return designNo;
	}

	public void setDesignNo(int designNo) {
		this.designNo = designNo;
	}

	public int getFontNo() {
		return fontNo;
	}

	public void setFontNo(int fontNo) {
		this.fontNo = fontNo;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Diary [no=" + no + ", writer=" + writer + ", content=" + content + ", designNo=" + designNo
				+ ", fontNo=" + fontNo + ", originalFilename=" + originalFilename + ", renamedFilename="
				+ renamedFilename + ", regDate=" + regDate + "]";
	}
	
}
