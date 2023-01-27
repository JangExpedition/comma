package customer.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import customer.model.dto.Question;
import customer.model.dto.QuestionComment;
import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionViewServlet
 */
@WebServlet("/customer/questionView")
public class QuestionViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int questionNo = Integer.parseInt(request.getParameter("no"));
		
		Question question = questionService.selectOneQuestion(questionNo);

		question.setContent(
			CommaUtils.convertLineFeedToBr(
			CommaUtils.escapeHTML(question.getContent()))
		);
		
		List<QuestionComment> qComments = questionService.selectQComment(questionNo);
		
		request.setAttribute("question", question);
		request.setAttribute("questionComments", qComments);
		
		request.getRequestDispatcher("/WEB-INF/views/customer/questionView.jsp").forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
