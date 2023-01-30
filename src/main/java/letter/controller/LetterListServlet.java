package letter.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import letter.model.dto.Letter;
import letter.model.service.LetterService;
import member.model.dto.Member;
import style.model.dto.Design;
import style.model.dto.Font;
import style.model.service.StyleService;

/**
 * Servlet implementation class LetterListServlet
 */
@WebServlet("/letter/letterList")
public class LetterListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();
	private FriendsService friendsService = new FriendsService();
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		Member member = (Member) request.getSession().getAttribute("loginMember");
		String nickname = member.getNickname();
		System.out.println(member);
		
		// 업무로직
		List<Letter> letterList = letterService.selectAllLetter(nickname);
		List<Friends> friendsList = friendsService.selectAllFriends(nickname);
		List<Font> fontList = styleService.selectAllFont();
		List<Design> designList = styleService.selectAllDesign();

		// 개행문자 변환처리
		for (Letter letter : letterList) {			
			letter.setContent(
					CommaUtils.convertLineFeedToBr(
							CommaUtils.escapeHTML(letter.getContent()))
					);
		}
		
		request.setAttribute("letterList", letterList);
		request.getSession().setAttribute("fontList", fontList);
		request.getSession().setAttribute("designList", designList);
		request.getSession().setAttribute("friendsList", friendsList);
		
		// view단 처리
		request.getRequestDispatcher("/WEB-INF/views/letter/letterList.jsp").forward(request, response);
	} // doGet() end

}
