package counseling.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.OX;
import counseling.model.dto.CounselingComment;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class AdoptCounselingComment
 */
@WebServlet("/counseling/comentAdopt")
public class AdoptCounselingComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int csNo = Integer.valueOf(request.getParameter("csNo"));
		try {
			int no = Integer.valueOf(request.getParameter("no"));
			OX choice = OX.valueOf(request.getParameter("choice"));
			
			int result = counselingService.adoptComment(no, choice);
			
			List<CounselingComment> csComments = counselingService.selectCsComment(no);
			
				
			
			if(choice == OX.O) {
				session.setAttribute("msg", "댓글이 채택됐습니다!");
			} else{
				session.setAttribute("msg", "댓글채택이 취소됐습니다!");
			}
			request.setAttribute("comments", csComments);
			
		} catch(Exception e) {
			session.setAttribute("msg", "댓글채택 실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/counseling/CSView?no=" + csNo);
	}

}
