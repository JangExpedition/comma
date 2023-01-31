package admin.controller;

import java.io.IOException;
import java.util.ArrayList;
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
		String type = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		List<Font> fontList = new ArrayList<>();
		List<Design> designList = new ArrayList<>();
		
		if ("font".equals(type)) {
			fontList = styleService.selectFindFont(searchKeyword);
			
			request.getSession().setAttribute("fontList", fontList);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminFontList.jsp").forward(request, response);
		}
		else {
			designList = styleService.selectFindDesign(searchKeyword);
			
			request.getSession().setAttribute("designList", designList);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminDesignList.jsp").forward(request, response);
		}
		
	} // doGet() end

}
