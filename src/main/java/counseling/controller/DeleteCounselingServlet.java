package counseling.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Attachment;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class DeleteCounselingServlet
 */
@WebServlet("/counseling/counselingDelete")
public class DeleteCounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			int no = Integer.valueOf(request.getParameter("no"));
			
			List<Attachment> attachments = counselingService.selectAttachment(no);
			String saveDirectory = getServletContext().getRealPath("/upload/counseling");
			for(Attachment attach : attachments) {
				File delFile = new File(saveDirectory, attach.getRenamedFilename());
				boolean bool = delFile.delete();
				System.out.println(bool ? "파일 삭제 성공!" : "파일 삭제 실패!");
			}
			
			int result = counselingService.deleteCounseling(no);
			session.setAttribute("msg", "게시글 삭제성공!");
			
		} catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "게시글 삭제실패!");
		}
		
		response.sendRedirect(request.getContextPath() + "/counseling/counselingList");
	}

}
