package daily.model.dto;

import common.Form;

public class Diary extends Form{
	
	private int designNo;
	private int fontNo;
	private String originalFilename;
	private String renamedFilename;
	
	public Diary() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Diary(int designNo, int fontNo, String originalFilename, String renamedFilename) {
		super();
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
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

	@Override
	public String toString() {
		return "Daily [designNo=" + designNo + ", fontNo=" + fontNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", toString()=" + super.toString() + "]";
	}
	
}
