package counseling.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.OX;
import counseling.model.dto.Counseling;
import counseling.model.dto.CounselingComment;
import counseling.model.service.CounselingService;
import notification.model.service.NotificationService;

/**
 * Servlet implementation class csCommentEnrollServlet
 */
@WebServlet("/counseling/csCommentEnroll")
public class CsCommentEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();
	private NotificationService notificationService = new NotificationService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int csNo = Integer.valueOf(request.getParameter("csNo"));
		String writer = request.getParameter("writer");
		OX commentLevel = OX.valueOf(request.getParameter("commentLevel"));
		int commentRef = Integer.valueOf(request.getParameter("commentRef"));
		String content = request.getParameter("commentContent");
		
		try {
			CounselingComment csComment = new CounselingComment(csNo, content, null, 0, writer, null, commentLevel, commentRef);
			int result = counselingService.insertCsComment(csComment);
			
			Counseling counseling = counselingService.selectOneCS(csNo);
			notificationService.notifyNewComment(counseling);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/counseling/CSView?no=" + csNo);
	}

}
