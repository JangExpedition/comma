package member.controller;

import java.io.IOException;
import java.util.List;

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
import style.model.dto.Design;
import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/member/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private FriendsService friendsService = new FriendsService();
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request);
		HttpSession session = request.getSession();
		String id = request.getParameter("memberId");
		String password = CommaUtils.getEncryptedPassword(request.getParameter("password"), id);
		System.out.println("id =" + id + ", password = " + password);
		
		Member member = memberService.selectOneMember(id);
		
		if(member != null && password.equals(member.getPassword())) {
			List<Friends> friendsList = friendsService.selectAllFriends(member.getNickname());
			List<Font> fontList = styleService.selectAllFont();
			List<Design> designList = styleService.selectAllDesign();
			
			session.setAttribute("loginMember", member);
			session.setAttribute("friendsList", friendsList);
			session.setAttribute("fontList", fontList);
			session.setAttribute("designList", designList);
		}else {
			session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		response.sendRedirect(request.getContextPath() + "/");
	}

}
