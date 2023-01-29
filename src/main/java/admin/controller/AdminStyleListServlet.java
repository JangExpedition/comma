package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import style.model.dto.Design;
import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminStyleListServlet
 */
@WebServlet("/admin/adminStyleList")
public class AdminStyleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Font> fontList = styleService.selectAllFont();
		List<Design> designList = styleService.selectAllDesign();
		
		request.getSession().setAttribute("fontList", fontList);
		request.getSession().setAttribute("designList", designList);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminStyleList.jsp")
			.forward(request, response);
	} // doGet() end

}
