package member.model.dto;

import java.sql.Date;
import java.util.List;

public class Member {
	private String nickname;
	private String password;
	private Date birthday;
	private Gender gender;
	private String email;
	private Date enrollDate;
	private MemberRole memberRole;
	private int warningCount;
	private String originalFilename;
	private String renamedFilename;
	private int age;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String nickname, String password, Date birthday, Gender gender, String email, Date enrollDate,
			MemberRole memberRole, int warningCount, String originalFilename, String renamedFilename, int age) {
		super();
		this.nickname = nickname;
		this.password = password;
		this.birthday = birthday;
		this.gender = gender;
		this.email = email;
		this.enrollDate = enrollDate;
		this.memberRole = memberRole;
		this.warningCount = warningCount;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.age = age;
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

	public int getWarningCount() {
		return warningCount;
	}

	public void setWarningCount(int warningCount) {
		this.warningCount = warningCount;
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
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "Member [nickname=" + nickname + ", password=" + password + ", birthday=" + birthday + ", gender="
				+ gender + ", email=" + email + ", enrollDate=" + enrollDate + ", memberRole=" + memberRole
				+ ", warningCount=" + warningCount + ", originalFilename=" + originalFilename + ", renamedFilename="
				+ renamedFilename + ", age=" + age + ", toString()=" + super.toString() + "]";
	}

}
