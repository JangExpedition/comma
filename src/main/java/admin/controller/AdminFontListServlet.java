package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminFontListServlet
 */
@WebServlet("/admin/adminFontList")
public class AdminFontListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Font> fontList = styleService.selectAllFont();
		
		request.setAttribute("fontList", fontList);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminFontList.jsp")
			.forward(request, response);
	} // doGet() end

}
