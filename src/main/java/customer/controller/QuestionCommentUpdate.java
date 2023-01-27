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
 * Servlet implementation class QuestionCommentUpdate
 */
@WebServlet("/customer/commentUpdate")
public class QuestionCommentUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qNo = Integer.parseInt(request.getParameter("qNo"));
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			
			QuestionComment qComment = new QuestionComment(no, writer, 0, content, null);
			
			int result = questionService.updateQuestionComment(qComment);
			request.getSession().setAttribute("msg", "댓글 수정 성공!");
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "댓글 수정 실패!");
		}
		
		response.sendRedirect(request.getContextPath() + "/customer/questionView?no=" + qNo);
	} // doPost() end

}
