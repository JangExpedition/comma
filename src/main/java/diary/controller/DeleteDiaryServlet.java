package diary.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import diary.model.service.DiaryService;

/**
 * Servlet implementation class DeleteDiaryServlet
 */
@WebServlet("/diary/deleteDiary")
public class DeleteDiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DiaryService diaryService = new DiaryService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int diaryNo = Integer.valueOf(request.getParameter("deleteDiaryNo"));
			
			int result = diaryService.deleteDiary(diaryNo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/diary/diaryList");
	}

}
