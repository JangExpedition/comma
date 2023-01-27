package customer.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionCommentDeleteServlet
 */
@WebServlet("/customer/commentDelete")
public class QuestionCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qNo = Integer.parseInt(request.getParameter("qNo"));
		int no = Integer.parseInt(request.getParameter("no"));
		
		//Map<String, Object> map = new HashMap<>();
		
		try {
			int result = questionService.deleteQuestionComment(no);
			request.getSession().setAttribute("msg", "댓글 삭제 성공!");
			//map.put("result", "삭제 성공!");
		} catch(Exception e) {
			//map.put("result", "삭제 실패!");
			request.getSession().setAttribute("msg", "댓글 삭제 실패!");
			e.printStackTrace();
		}

		//new Gson().toJson(map, response.getWriter());
		//response.setContentType("application/json; charset=utf-8");
		response.sendRedirect(request.getContextPath() + "/customer/questionView?no=" + qNo);
	} // doPost() end

}
