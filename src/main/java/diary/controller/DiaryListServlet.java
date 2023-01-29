package diary.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
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
		String yearFilter = request.getParameter("yearFilter");
		
		List<Diary> diaryList = diaryService.selectAllDiary(member);
		
		HashSet<String> memberHaveYearSet = new HashSet<>();
		
		for(Diary diary : diaryList){
			memberHaveYearSet.add(diary.getRegDate().substring(0, 4));
		}
		
		request.setAttribute("memberHaveYearSet", memberHaveYearSet);
		
		List<Diary> afterDiaryList = new ArrayList<>();
		
		if(yearFilter == null || "전체보기".equals(yearFilter)) {
			request.setAttribute("diaryList", diaryList);
		}else {
			for(Diary diary : diaryList) {
				if(diary.getRegDate().substring(0, 4).equals(yearFilter)) {
					afterDiaryList.add(diary);
				}
			}
			request.setAttribute("diaryList", afterDiaryList);
			request.setAttribute("yearFilter", yearFilter);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/diary/diaryList.jsp")
			.forward(request, response);
	} // doGet() end

}
