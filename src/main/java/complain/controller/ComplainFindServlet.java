package complain.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import complain.model.dto.Complain;
import complain.model.service.ComplainService;

/**
 * Servlet implementation class AdminFindMemberServlet
 */
@WebServlet("/complain/complainFinder")
public class ComplainFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ComplainService complainService = new ComplainService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		List<Complain> complainList = complainService.selectComplainFind(param);
		
		request.setAttribute("complainList", complainList);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminComplainList.jsp").forward(request, response);
	} // doGet() end

}
