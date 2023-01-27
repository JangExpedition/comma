package counseling.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import counseling.model.service.CounselingService;

/**
 * Servlet implementation class csCommentDelteServlet
 */
@WebServlet("/counseling/csCommentDelete")
public class csCommentDelteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int csNo = Integer.valueOf(request.getParameter("csNo"));
		int csCommentNo = Integer.valueOf(request.getParameter("no"));
		try {
			int result = counselingService.deleteCsComment(csCommentNo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/counseling/CSView?no=" + csNo);
	}

}
