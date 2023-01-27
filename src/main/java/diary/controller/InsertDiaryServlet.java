package diary.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.CommaFileRenamePolicy;
import diary.model.dto.Diary;
import diary.model.service.DiaryService;

/**
 * Servlet implementation class InsertDiaryServlet
 */
@WebServlet("/diary/insertDiary")
public class InsertDiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DiaryService diaryService = new DiaryService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String saveDirectory = getServletContext().getRealPath("/upload/counseling");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			String writer = multiReq.getParameter("writer");
			String content = multiReq.getParameter("nowContent");
			
			
			Diary diary = new Diary(0, writer, content, null, 0, 0, null, null);
			
			if (multiReq.getFile("enrollImage") != null) {
				diary.setOriginalFilename(multiReq.getOriginalFileName("enrollImage"));
				diary.setRenamedFilename(multiReq.getFilesystemName("enrollImage"));
			}
			
			int result = diaryService.insertDiary(diary);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/diary/diaryList");
	}

}
