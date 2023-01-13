package member.model.dto;

import java.sql.Date;
import java.util.List;

public class LeaveMember extends Member{

	private Date leaveDate;

	public LeaveMember() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LeaveMember(String memberId, String nickname, String password, Date birthday, Gender gender, String phone,
			String email, Date enrollDate, MemberRole memberRole, List<String> friends, int warningCount) {
		super(memberId, nickname, password, birthday, gender, phone, email, enrollDate, memberRole, friends, warningCount);
		// TODO Auto-generated constructor stub
	}

	public LeaveMember(Date leaveDate) {
		super();
		this.leaveDate = leaveDate;
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
