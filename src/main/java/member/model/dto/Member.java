package member.model.dto;

import java.sql.Date;
import java.util.List;

public class Member {
	private String memberId;
	private String nickname;
	private String password;
	private Date birthday;
	private Gender gender;
	private String phone;
	private String email;
	private Date enrollDate;
	private MemberRole memberRole;
	private List<String> friends;
	private int warningCount;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String memberId, String nickname, String password, Date birthday, Gender gender, String phone,
			String email, Date enrollDate, MemberRole memberRole, List<String> friends, int warningCount) {
		super();
		this.memberId = memberId;
		this.nickname = nickname;
		this.password = password;
		this.birthday = birthday;
		this.gender = gender;
		this.phone = phone;
		this.email = email;
		this.enrollDate = enrollDate;
		this.memberRole = memberRole;
		this.friends = friends;
		this.warningCount = warningCount;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public MemberRole getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(MemberRole memberRole) {
		this.memberRole = memberRole;
	}

	public List<String> getFriends() {
		return friends;
	}

	public void setFriends(List<String> friends) {
		this.friends = friends;
	}

	public int getWarningCount() {
		return warningCount;
	}

	public void setWarningCount(int warningCount) {
		this.warningCount = warningCount;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", nickname=" + nickname + ", password=" + password + ", birthday="
				+ birthday + ", gender=" + gender + ", phone=" + phone + ", email=" + email + ", enrollDate="
				+ enrollDate + ", memberRole=" + memberRole + ", friends=" + friends + ", warningCount=" + warningCount
				+ "]";
	}
	
}
