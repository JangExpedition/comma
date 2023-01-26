package letter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import letter.model.dto.Letter;
import letter.model.service.LetterService;

/**
 * Servlet implementation class LetterViewServlet
 */
@WebServlet("/letter/letterView")
public class LetterViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		int letterNo = Integer.parseInt(request.getParameter("no"));
		
		// 업무로직
		Letter letter = letterService.selectOneLetter(letterNo);
		
		letter.setContent(
				CommaUtils.convertLineFeedToBr(
						CommaUtils.escapeHTML(letter.getContent()))
				);
		
		request.setAttribute("letter", letter);
		
		request.getRequestDispatcher("/WEB-INF/views/letter/letterView.jsp").forward(request, response);
	} // doGet() end

}
