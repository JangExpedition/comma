package admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Attachment;
import counseling.model.dto.CounselingComment;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class AdminCounselingDeleteServlet
 */
@WebServlet("/admin/adminCounselingDelete")
public class AdminCounselingDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int result = 0;
			int no = Integer.parseInt(request.getParameter("no"));
			
			List<Attachment> attachments = counselingService.selectAttachment(no);
			String saveDirectory = getServletContext().getRealPath("/upload/counseling");
			for(Attachment attach : attachments) {
				File delFile = new File(saveDirectory, attach.getRenamedFilename());
				boolean bool = delFile.delete();
				System.out.println(bool ? "파일 삭제 성공!" : "파일 삭제 실패!");
			}
			
			List<CounselingComment> csCommentList = counselingService.selectCsComment(no);
			for (CounselingComment csComment : csCommentList) {
				result = counselingService.deleteCsComment(no);				
			}
			
			result = counselingService.deleteCounseling(no);
			
			request.getSession().setAttribute("msg", "해당 글이 정상적으로 삭제되었습니다.");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "해당 글 삭제에 실패하였습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/counselingList");
	} // doPost() end

}
