package customer.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.CommaFileRenamePolicy;
import customer.model.dto.Question;
import customer.model.service.QuestionService;

/**
 * Servlet implementation class QuestionUpdateServlet
 */
@WebServlet("/customer/questionUpdate")
public class QuestionUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		Question question = questionService.selectOneQuestion(no);
		
		request.setAttribute("question", question);
		
		request.getRequestDispatcher("/WEB-INF/views/customer/questionUpdate.jsp").forward(request, response);
		
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
			
			int no = Integer.parseInt(multiReq.getParameter("no"));
			String writer = multiReq.getParameter("loginMember");
			String content = multiReq.getParameter("content");
			String title = multiReq.getParameter("questionTitle");
			String[] delFiles = multiReq.getParameterValues("delFile");
			
			Question question = new Question(no, writer, title, content, null);


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
			
			int result = questionService.updateQuestion(question);
			
			if(delFiles != null) {
				for(String temp : delFiles) {
					int attachNo = Integer.parseInt(temp);
					Attachment attach = questionService.selectOneAttachment(attachNo);
					
					File delFile = new File(saveDirectory, attach.getRenamedFilename());
					if(delFile.exists())
						delFile.delete();
					result = questionService.deleteAttachment(attachNo);
				}
			}
			
			request.getSession().setAttribute("msg", "게시글이 정상적으로 수정되었습니다.");
			response.sendRedirect(request.getContextPath() + "/customer/questionView?no=" + no);
			
		} catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "게시글 수정에 실패하셨습니다.");
			response.sendRedirect(request.getContextPath() + "/customer");
		}
		
		
	} // doPost() end

}
