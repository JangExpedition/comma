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

/**
 * Servlet implementation class LetterViewServlet
 */
@WebServlet("/letter/letterView")
public class LetterViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		int letterNo = Integer.parseInt(request.getParameter("no"));
		Member member = (Member) request.getSession().getAttribute("loginMember");
		String nickname = member.getNickname();
		
		// 업무로직
		Letter letter = letterService.selectOneLetter(letterNo);
		List<Friends> friendsList = friendsService.selectAllFriends(nickname);
		
		letter.setContent(
				CommaUtils.convertLineFeedToBr(
						CommaUtils.escapeHTML(letter.getContent()))
				);
		
		request.setAttribute("letter", letter);
		request.getSession().setAttribute("friendsList", friendsList);
		
		request.getRequestDispatcher("/WEB-INF/views/letter/letterView.jsp").forward(request, response);
	} // doGet() end

}
