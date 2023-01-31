package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.service.MemberService;

/**
 * Servlet implementation class AdminDeleteMemberNickServlet
 */
@WebServlet("/admin/adminDeleteMemberNick")
public class AdminDeleteMemberNickServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			String memberNick = request.getParameter("memberNick");
			int result = memberService.deleteMemberNick(memberNick);
			
			request.getSession().setAttribute("msg", "해당 회원을 탈퇴시켰습니다.");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "해당 회원을 탈퇴시키는데 실패했습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/complain/complain");
	}

}
