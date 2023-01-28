package diary.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import diary.model.dto.Diary;
import diary.model.service.DiaryService;

/**
 * Servlet implementation class DiaryViewServlet
 */
@WebServlet("/diary/diaryView")
public class DiaryViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DiaryService diaryService = new DiaryService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int diaryNo = Integer.valueOf(request.getParameter("diaryNo"));
		
		Diary diary = diaryService.selectOneDiary(diaryNo);
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(diary, response.getWriter());
	}

}
