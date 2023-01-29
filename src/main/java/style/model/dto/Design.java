package style.model.dto;

import java.sql.Date;



public class Design {
	private int no;
	private int rnum;
	private Part part;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
	public Design() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Design(int no, Part part, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.no = no;
		this.part = part;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}

	public Design(int no, int rnum, Part part, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.no = no;
		this.rnum = rnum;
		this.part = part;
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

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public Part getPart() {
		return part;
	}

	public void setPart(Part part) {
		this.part = part;
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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Design [no=" + no + ", rnum=" + rnum + ", part=" + part + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
	
}
