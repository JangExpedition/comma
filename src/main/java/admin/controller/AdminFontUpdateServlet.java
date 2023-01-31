package admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminFontUpdateServlet
 */
@WebServlet("/admin/adminFontUpdate")
public class AdminFontUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String name = request.getParameter("name");
			String link = request.getParameter("link");
			
			Font font = new Font(no, name, link);
			
			int result = styleService.updateFont(font);
			request.getSession().setAttribute("msg", "폰트를 수정했습니다.");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "폰트를 수정하지 못했습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/adminFontList");
	} // doPost() end

}
