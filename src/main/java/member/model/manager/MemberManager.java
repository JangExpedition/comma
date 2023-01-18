package member.model.manager;

import java.util.ArrayList;
import java.util.List;

import member.model.service.MemberService;

public class MemberManager {

	private static MemberManager INSTANCE;
	private List<String> nicks = new ArrayList<>();
	private MemberService memberService = new MemberService();
	
	private MemberManager() {
		nicks = memberService.selectAllNickname();
	}
	
	public static MemberManager getInstance() {
		if(INSTANCE == null) {
			INSTANCE = new MemberManager();
		}
		return INSTANCE;
	}

	public List<String> getNicks() {
		return this.nicks;
	}
}
