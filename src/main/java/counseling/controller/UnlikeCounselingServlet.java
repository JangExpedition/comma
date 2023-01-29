package counseling.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import counseling.model.service.CounselingService;
import member.model.dto.Member;

/**
 * Servlet implementation class UnlikeCounselingServlet
 */
@WebServlet("/counseling/counselingUnlike")
public class UnlikeCounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			int csNo = Integer.valueOf(request.getParameter("csNo"));
			Member loginMember = (Member) session.getAttribute("loginMember");
			String memNick = loginMember.getNickname();
			
			int result = counselingService.updateunlikeCounseling(csNo, memNick);
			
			response.sendRedirect(request.getContextPath() + "/counseling/CSView?no=" + csNo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
