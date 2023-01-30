package diary.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;


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
			
			String saveDirectory = getServletContext().getRealPath("/upload/diary");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			String writer = multiReq.getParameter("writer");
			String content = multiReq.getParameter("nowContent");
			String nowDate = multiReq.getParameter("nowDate");
			String _designNo = multiReq.getParameter("designNo");
			String _fontNo = multiReq.getParameter("fontNo");
			int designNo = 0;
			int fontNo = 0;
		
			System.out.println("================" +_designNo + "===================" + _fontNo);
			if(!_designNo.isEmpty()) {
				designNo = Integer.valueOf(_designNo);
			}
			if(!_fontNo.isEmpty()) {
				fontNo = Integer.valueOf(_fontNo);
			}
			
			Diary diary = new Diary(0, writer, content, designNo, fontNo, null, null, nowDate);
			
			if (multiReq.getFile("file") != null) {
				diary.setOriginalFilename(multiReq.getOriginalFileName("file"));
				diary.setRenamedFilename(multiReq.getFilesystemName("file"));
			}
			
			int result = diaryService.insertDiary(diary);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/diary/diaryList");
	}

}
