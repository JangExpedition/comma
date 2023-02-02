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
			String adminNick = request.getParameter("adminNick");
			String memberNick = request.getParameter("memberNick");
			int warningCnt = Integer.parseInt(request.getParameter("warningCnt"));
			String content = request.getParameter("letterContent");
			
			Map<String, Object> param = new HashMap<>();
			param.put("adminNick", adminNick);
			param.put("memberNick", memberNick);
			param.put("warningCnt", warningCnt);
			param.put("content", content);
			
			int result = memberService.updateWarningCount(param);
			request.getSession().setAttribute("msg", "누적 신고 횟수를 정상적으로 수정했습니다.");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "누적 신고 횟수를 수정하는데 실패했습니다.");
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/complain/complain");
	} // doPost() end

}
