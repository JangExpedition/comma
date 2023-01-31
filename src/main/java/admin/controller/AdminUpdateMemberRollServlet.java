package admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class AdminUpdateMemberRollServlet
 */
@WebServlet("/admin/updateMemberRole")
public class AdminUpdateMemberRollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String memberNick = request.getParameter("memberNick");
			String memberRole = request.getParameter("memberRole");
			
			System.out.println("memberNick = " + memberNick);
			System.out.println("memberRole = " + memberRole);
			
			// 2. 업무로직
			int result = memberService.updateMemberRole(memberNick, memberRole);
			
			if (result > 0) {
				request.getSession().setAttribute("msg", "회원 권한을 수정했습니다.");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "회원 권한을 수정하지 못했습니다.");
			e.printStackTrace();
		}
		
		// 3. 리다이렉트 - url 변경
		response.sendRedirect(request.getContextPath() + "/admin/adminMemberList");
	} // doPost() end

}
