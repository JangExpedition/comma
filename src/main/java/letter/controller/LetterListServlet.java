package letter.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import letter.model.dto.Letter;
import letter.model.service.LetterService;

/**
 * Servlet implementation class LetterListServlet
 */
@WebServlet("/letter/letterList")
public class LetterListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		String nickname = "test";
		
		// 업무로직
		List<Letter> letterList = letterService.selectAllLetter(nickname);
		
		request.setAttribute("letterList", letterList);
		
		// view단 처리
		request.getRequestDispatcher("/WEB-INF/views/letter/letterList.jsp").forward(request, response);
	} // doGet() end

}
