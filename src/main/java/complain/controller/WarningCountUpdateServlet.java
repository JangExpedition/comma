package complain.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class WarningCountUpdateServlet
 */
@WebServlet("/complain/warningCountUpdate")
public class WarningCountUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberNick = request.getParameter("memberNick");
			int warningCnt = Integer.parseInt(request.getParameter("warningCnt"));
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberNick", memberNick);
			param.put("warningCnt", warningCnt);
			
			int result = memberService.updateWarningCount(param);
			request.getSession().setAttribute("msg", "누적 신고 횟수 수정 성공!");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "누적 신고 횟수 수정 실패!");
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/complain/complain");
	} // doPost() end

}
