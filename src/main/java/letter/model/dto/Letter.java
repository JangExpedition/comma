package letter.model.dto;

import java.sql.Date;

import common.Form;
import common.OX;

public class Letter extends Form{
	private String addressee;
	private int designNo;
	private int fontNo;
	private OX read_check;
	
	public Letter() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Letter(int no, String writer, String content, Date regDate) {
		super(no, writer, content, regDate);
		// TODO Auto-generated constructor stub
	}

	public Letter(String addressee, int designNo, int fontNo, OX read_check) {
		super();
		this.addressee = addressee;
		this.designNo = designNo;
		this.fontNo = fontNo;
		this.read_check = read_check;
	}

	public String getAddressee() {
		return addressee;
	}

	public void setAddressee(String addressee) {
		this.addressee = addressee;
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

	public OX getRead_check() {
		return read_check;
	}

	public void setRead_check(OX read_check) {
		this.read_check = read_check;
	}

	@Override
	public String toString() {
		return "Letter [addressee=" + addressee + ", designNo=" + designNo + ", fontNo=" + fontNo + ", read_check="
				+ read_check + ", toString()=" + super.toString() + "]";
	}
	
}
