package diary.controller;

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
import style.model.dto.Part;
import style.model.service.StyleService;

/**
 * Servlet implementation class WriteDiary
 */
@WebServlet("/diary/writeDiary")
public class WriteDiary extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Font> fontList = styleService.selectAllFont();
		List<Design> _designList = styleService.selectAllDesign();
		List<Design> designList = new ArrayList<>();
		
		for(Design design : _designList) {
			if(design.getPart() == Part.D) {
				designList.add(design);
			}
		}
		
		request.getSession().setAttribute("fontList", fontList);
		request.getSession().setAttribute("designList", designList);
		request.getRequestDispatcher("/WEB-INF/views/diary/writeDiary.jsp")
			.forward(request, response);
	}

}
