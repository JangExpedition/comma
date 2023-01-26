package customer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.CommaFileRenamePolicy;
import customer.model.dto.Question;
import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionEnrollServlet
 */
@WebServlet("/customer/questionEnroll")
public class QuestionEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/customer/questionEnroll.jsp")
			.forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// MultipartRequest객체 생성
			String saveDirectory = getServletContext().getRealPath("/upload/question");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 사용자 입력값
			String writer = multiReq.getParameter("writer");
		    String title = multiReq.getParameter("questionTitle");
		    String content = multiReq.getParameter("content");
		    
		    Question question = new Question(0, writer, title, content, null);

		    
		    // 업로드한 파일 처리
			if (multiReq.getFile("file1") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file1"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file1"));
				question.addAttachment(attach);
			}
			
			if (multiReq.getFile("file2") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file2"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file2"));
				question.addAttachment(attach);
			}
			
			if (multiReq.getFile("file3") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file3"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file3"));
				question.addAttachment(attach);
			}
		    
		    int result = questionService.insertQuestion(question);
		    request.getSession().setAttribute("msg", "질문 작성 성공!");
		}
		catch(Exception e) {
			request.getSession().setAttribute("msg", "질문 작성 실패!");
			e.printStackTrace();
		}
		
		request.setAttribute("type", "question");
		response.sendRedirect(request.getContextPath() + "/customer" );
	} // doPost() end
	
}
		
   
    

