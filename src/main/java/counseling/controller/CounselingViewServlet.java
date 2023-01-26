package counseling.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class CounselingViewServlet
 */
@WebServlet("/counseling/CSView")
public class CounselingViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.valueOf(request.getParameter("no"));
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println(no);
		
		Counseling counseling = counselingService.selectOneCS(no);
		
		counseling.setContent(
			CommaUtils.convertLineFeedToBr(
			CommaUtils.escapeHTML(counseling.getContent()))
		);
		
		request.setAttribute("counseling", counseling);
		request.getRequestDispatcher("/WEB-INF/views/counseling/counselingViewer.jsp")
			.forward(request, response);
	}

}
