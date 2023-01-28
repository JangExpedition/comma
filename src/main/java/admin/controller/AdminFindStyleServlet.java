package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import style.model.dto.Design;
import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminFindStyleServlet
 */
@WebServlet("/admin/findStyle")
public class AdminFindStyleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String searchKeyword = request.getParameter("searchKeyword");
		
		if ("font".equals(type)) {
			List<Font> fontList = styleService.selectFindFont(searchKeyword);
			request.setAttribute("fontList", fontList);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminFontList.jsp")
				.forward(request, response);
		}
		else {
			List<Design> designList = styleService.selectFindDesign(searchKeyword);
			request.setAttribute("designList", designList);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminDesignList.jsp")
				.forward(request, response);
		}
	} // doGet() end

}
