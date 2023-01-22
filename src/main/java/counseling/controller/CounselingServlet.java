package counseling.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class CounselingServlet
 */
@WebServlet("/counseling/counselingList")
public class CounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Counseling> counselingList = counselingService.selectAllCounseling();
		
		request.setAttribute("counselingList", counselingList);
		
		request.getRequestDispatcher("/WEB-INF/views/counseling/counseling.jsp")
			.forward(request, response);
	}

}
