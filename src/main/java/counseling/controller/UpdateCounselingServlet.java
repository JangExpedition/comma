package counseling.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

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
 * Servlet implementation class UpdateCounselingServlet
 */
@WebServlet("/counseling/counselingUpdate")
public class UpdateCounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		Counseling counseling = counselingService.selectOneCS(no);
		
		request.setAttribute("counseling", counseling);
		
		request.getRequestDispatcher("/WEB-INF/views/counseling/counselingUpdate.jsp").forward(request, response);
		
	}

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
			
			int no = Integer.parseInt(multiReq.getParameter("no"));
			String content = multiReq.getParameter("content");
			String title = multiReq.getParameter("counselingTitle");
			Category category = Category.valueOf(multiReq.getParameter("counselingCategory"));
			Gender limitGender = Gender.valueOf(multiReq.getParameter("gender"));
			int limitAge = Integer.valueOf(multiReq.getParameter("age"));
			OX anonymous = OX.valueOf(multiReq.getParameter("anonymous"));
			String[] delFiles = multiReq.getParameterValues("delFile");
			
			Counseling counseling = new Counseling(no, null, content, null, title, 0, 0, category, limitGender, limitAge, anonymous);

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
			
			int result = counselingService.updateCounseling(counseling);
			
			if(delFiles != null) {
				for(String temp : delFiles) {
					int attachNo = Integer.parseInt(temp);
					Attachment attach = counselingService.selectOneAttachment(attachNo);
					
					File delFile = new File(saveDirectory, attach.getRenamedFilename());
					if(delFile.exists())
						delFile.delete();
					result = counselingService.deleteAttachment(attachNo);
				}
			}
			
			if(result > 0) {
				session.setAttribute("msg", "게시글이 정상적으로 수정되었습니다.");
				response.sendRedirect(request.getContextPath() + "/counseling/CSView?no=" + no);
			}
		} catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "게시글 수정실패!");
			response.sendRedirect(request.getContextPath() + "/counseling/counselingList");
		}
		
	
	}

}
