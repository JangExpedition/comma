package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class DeleteMemberServlet
 */
@WebServlet("/member/deleteMember")
public class DeleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			Member leaveMember = (Member) session.getAttribute("loginMember");
			String email = leaveMember.getEmail();
			
			int result = memberService.deleteMember(email);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		session.setAttribute("loginMember", null);
		session.setAttribute("friendsList", null);
		
		response.sendRedirect(request.getContextPath() + "/");
	}

}
