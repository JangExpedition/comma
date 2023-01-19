package friends.model.dto;

import common.OX;

public class Friends {

	private int no;
	private String nickname;
	private OX isFriend;
	private String originalFileName;
	private String renamedFileName;
	
	public Friends() {
		super();
	}

	public Friends(int no, String nickname, OX isFriend, String originalFileName, String renamedFileName) {
		super();
		this.no = no;
		this.nickname = nickname;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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
		return "Friends [no=" + no + ", nickname=" + nickname + ", isFriend=" + isFriend + ", originalFileName="
				+ originalFileName + ", renamedFileName=" + renamedFileName + "]";
	}

}
