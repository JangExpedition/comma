package member.model.manager;

import java.util.ArrayList;
import java.util.List;

import member.model.dto.Member;
import member.model.service.MemberService;

public class MemberManager {

	private static MemberManager INSTANCE;
	private List<Member> memberList = new ArrayList<>();
	private MemberService memberService = new MemberService();
	
	private MemberManager() {
		memberList = memberService.selectAllNickname();
	}
	
	public static MemberManager getInstance() {
		if(INSTANCE == null) {
			INSTANCE = new MemberManager();
		}
		return INSTANCE;
	}

	public List<Member> getNicks() {
		return this.memberList;
	}
}
