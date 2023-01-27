package friends.model.dto;

import common.OX;

public class Friends {

	private int no;
	private String myNickname;
	private String fNickname;
	private OX isFriend;
	private String originalFileName;
	private String renamedFileName;
	
	public Friends() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Friends(int no, String myNickname, String fNickname, OX isFriend, String originalFileName,
			String renamedFileName) {
		super();
		this.no = no;
		this.myNickname = myNickname;
		this.fNickname = fNickname;
		this.isFriend = isFriend;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMyNickname() {
		return myNickname;
	}

	public void setMyNickname(String myNickname) {
		this.myNickname = myNickname;
	}

	public String getfNickname() {
		return fNickname;
	}

	public void setfNickname(String fNickname) {
		this.fNickname = fNickname;
	}

	public OX getIsFriend() {
		return isFriend;
	}

	public void setIsFriend(OX isFriend) {
		this.isFriend = isFriend;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	@Override
	public String toString() {
		return "Friends [no=" + no + ", myNickname=" + myNickname + ", fNickname=" + fNickname + ", isFriend="
				+ isFriend + ", originalFileName=" + originalFileName + ", renamedFileName=" + renamedFileName + "]";
	}
	
}
