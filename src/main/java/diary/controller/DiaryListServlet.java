package diary.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import diary.model.dto.Diary;
import diary.model.service.DiaryService;
import member.model.dto.Member;

/**
 * Servlet implementation class DailyListServlet
 */
@WebServlet("/diary/diaryList")
public class DiaryListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DiaryService diaryService = new DiaryService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginMember");
		
		List<Diary> diaryList = diaryService.selectAllDiary(member);
		System.out.println(diaryList);
		request.setAttribute("diaryList", diaryList);
		request.getRequestDispatcher("/WEB-INF/views/diary/diaryList.jsp")
			.forward(request, response);
	} // doGet() end

}
