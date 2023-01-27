package customer.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Attachment;
import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionDeleteServlet
 */
@WebServlet("/customer/questionDelete")
public class QuestionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.valueOf(request.getParameter("no"));
			
			List<Attachment> attachments = questionService.selectAttachment(no);
			String saveDirectory = getServletContext().getRealPath("/upload/question");
			for(Attachment attach : attachments) {
				File delFile = new File(saveDirectory, attach.getRenamedFilename());
				boolean bool = delFile.delete();
				System.out.println(bool ? "파일 삭제 성공!" : "파일 삭제 실패!");
			}
			
			
			
			int result = questionService.deleteQuestion(no);
			request.getSession().setAttribute("msg", "게시글 삭제 성공!");
			
		} catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "게시글 삭제 실패!");
		}
		
		response.sendRedirect(request.getContextPath() + "/customer");
	} // doPost() end

}
