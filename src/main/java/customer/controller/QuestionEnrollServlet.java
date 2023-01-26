package customer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionEnrollServlet
 */
@WebServlet("/question/questionEnroll")
public class QuestionEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.getRequestDispatcher("/WEB-INF/views/question/questionEnroll.jsp")
	.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String writer = request.getParameter("name");
		    String title = request.getParameter("title");
		    String content = request.getParameter("content");
		    int result = questionService.insertQuestion(writer,title,content);
		   }
		catch(Exception e) {
			e.printStackTrace();
		  }
		response.sendRedirect(request.getContextPath() + "/question" );
	}
	
}
		
   
    

