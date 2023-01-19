package friends.model.dto;

import common.OX;

public class Friends {

	private int no;
	private String myNickname;
	private String friendNickname;
	private OX isFriend;
	
	public Friends() {
		super();
	}
	
	public Friends(int no, String myNickname, String friendNickname, OX isFriend) {
		super();
		this.no = no;
		this.myNickname = myNickname;
		this.friendNickname = friendNickname;
		this.isFriend = isFriend;
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

	public String getFriendNickname() {
		return friendNickname;
	}

	public void setFriendNickname(String friendNickname) {
		this.friendNickname = friendNickname;
	}

	public OX getIsFriend() {
		return isFriend;
	}

	public void setIsFriend(OX isFriend) {
		this.isFriend = isFriend;
	}

	@Override
	public String toString() {
		return "Friends [no=" + no + ", myNickname=" + myNickname + ", friendNickname=" + friendNickname + ", isFriend="
				+ isFriend + "]";
	}
	
}
