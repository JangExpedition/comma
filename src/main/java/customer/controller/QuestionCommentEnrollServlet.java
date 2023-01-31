package customer.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customer.model.dto.QuestionComment;
import customer.model.service.QuestionService;

/**
 * Servlet implementation class csCommentEnrollServlet
 */
@WebServlet("/customer/questionCommentEnroll")
public class QuestionCommentEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qNo = Integer.valueOf(request.getParameter("questionNo"));
		String writer = request.getParameter("writer");
		String content = request.getParameter("commentContent");
		
		try {
			QuestionComment qComment = new QuestionComment(0, writer, qNo, content, null);
			
			int result = questionService.insertQuestionComment(qComment);
			
			request.getSession().setAttribute("msg", "댓글이 정상적으로 등록되었습니다.");
		} catch(Exception e) {
			request.getSession().setAttribute("msg", "댓글 등록에 실패하셨습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/customer/questionView?no=" + qNo);
	} // doPost() end

}
