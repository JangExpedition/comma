package counseling.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.Category;
import common.CommaFileRenamePolicy;
import common.OX;
import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;
import member.model.dto.Gender;

/**
 * Servlet implementation class InsertCounselingServlet
 */
@WebServlet("/counseling/insertCounseling")
public class InsertCounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			// MultipartRequest객체 생성
			String saveDirectory = getServletContext().getRealPath("/upload/counseling");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			String writer = multiReq.getParameter("loginMember");
			String content = multiReq.getParameter("content");
			String title = multiReq.getParameter("counselingTitle");
			Category category = Category.valueOf(multiReq.getParameter("counselingCategory"));
			Gender limitGender = Gender.valueOf(multiReq.getParameter("gender"));
			int limitAge = Integer.valueOf(multiReq.getParameter("age"));
			OX anonymous = OX.valueOf(multiReq.getParameter("anonymous"));
			
			System.out.println("writer = " + writer);
			System.out.println("content = " + content);
			System.out.println("title = " + title);
			System.out.println("category = " + category);
			System.out.println("limitGender = " + limitGender);
			System.out.println("limitAge = " + limitAge);
			System.out.println("anonymous = " + anonymous);
			
			Counseling counseling = new Counseling(0, writer, content, null, title, 0, 0, category, limitGender, limitAge, anonymous);
			
			// 업로드한 파일 처리
			if (multiReq.getFile("file1") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file1"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file1"));
				counseling.addAttachment(attach);
			}
			
			if (multiReq.getFile("file2") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file2"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file2"));
				counseling.addAttachment(attach);
			}
			
			if (multiReq.getFile("file3") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("file3"));
				attach.setRenamedFilename(multiReq.getFilesystemName("file3"));
				counseling.addAttachment(attach);
			}
			
			int result = counselingService.insertCounseling(counseling);
			
			if(result > 0) {
				session.setAttribute("msg", "게시글이 정상적으로 등록되었습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "게시글 등록실패!");
		}
		response.sendRedirect(request.getContextPath() + "/counseling/counselingList");
	}

}
