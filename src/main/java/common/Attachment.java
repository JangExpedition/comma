package common;

import java.sql.Date;

public class Attachment {
	private int no;
	private int attachNo;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
	public Attachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Attachment(int no, int attachNo, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.no = no;
		this.attachNo = attachNo;
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

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
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
		return "CounselingAttachment [no=" + no + ", attachNo=" + attachNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
	
}
