package member.model.dto;

import java.sql.Date;
import java.util.List;

public class LeaveMember extends Member{

	private Date leaveDate;

	public LeaveMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public LeaveMember(Date leaveDate) {
		super();
		this.leaveDate = leaveDate;
	}

	public LeaveMember(String nickname, String password, Date birthday, Gender gender, String email, Date enrollDate,
			MemberRole memberRole, int warningCount, String originalFilename, String renamedFilename, int age) {
		super(nickname, password, birthday, gender, email, enrollDate, memberRole, warningCount, originalFilename,
				renamedFilename, age);
		// TODO Auto-generated constructor stub
	}

	public Date getLeaveDate() {
		return leaveDate;
	}

	public void setLeaveDate(Date leaveDate) {
		this.leaveDate = leaveDate;
	}

	@Override
	public String toString() {
		return "LeaveMember [leaveDate=" + leaveDate + ", toString()=" + super.toString() + "]";
	}

}
