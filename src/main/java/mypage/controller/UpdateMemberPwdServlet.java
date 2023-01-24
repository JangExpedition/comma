package mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommaUtils;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class UpdateMemberPwdServlet
 */
@WebServlet("/member/updateMemberPwd")
public class UpdateMemberPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			Member loginMember = (Member) session.getAttribute("loginMember");
			String email = loginMember.getEmail();
			String newPwd = CommaUtils.getEncryptedPassword(request.getParameter("newPassword"), email);
			String updateType = "password";
			
			Map<String, String> param = new HashMap<>();
			param.put("updateType", updateType);
			param.put("updateData", newPwd);
			param.put("who", email);
			
			int result = memberService.updateMember(param);
			
			if(result > 0) {
				session.setAttribute("msg", "비밀번호가 성공적으로 변경됐습니다.");
				Member member = memberService.selectOneMember(email);
				List<Friends> friendsList = friendsService.selectAllFriends(member.getNickname());
				session.setAttribute("loginMember", member);
				session.setAttribute("friendsList", friendsList);
			}
		} catch(Exception e) {
			session.setAttribute("msg", "비밀번호 수정실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/mypage/mypage");
	}

}
