package admin.controller;

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
 * Servlet implementation class AdminCounselingFinder
 */
@WebServlet("/admin/counselingFinder")
public class AdminCounselingFinder extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchKeyword = request.getParameter("searchKeyword");
		
		List<Counseling> counselingList = counselingService.selectAdminFinderCounseling(searchKeyword);
	} // doGet() end

}
