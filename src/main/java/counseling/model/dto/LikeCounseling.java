package counseling.model.dto;

import java.sql.Date;

public class LikeCounseling {
	private int no;
	private int csNo;
	private String memNick;
	private Date regDate;
	
	public LikeCounseling() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LikeCounseling(int no, int csNo, String memNick, Date regDate) {
		super();
		this.no = no;
		this.csNo = csNo;
		this.memNick = memNick;
		this.regDate = regDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCsNo() {
		return csNo;
	}

	public void setCsNo(int csNo) {
		this.csNo = csNo;
	}

	public String getMemNick() {
		return memNick;
	}

	public void setMemNick(String memNick) {
		this.memNick = memNick;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "LikeCounseling [no=" + no + ", csNo=" + csNo + ", memNick=" + memNick + ", regDate=" + regDate + "]";
	}
	
}
