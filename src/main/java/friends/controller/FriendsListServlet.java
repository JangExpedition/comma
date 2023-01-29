package friends.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import member.model.dto.Member;

/**
 * Servlet implementation class FriendsListServlet
 */
@WebServlet("/friends/friendsList")
public class FriendsListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		Member member = (Member) request.getSession().getAttribute("loginMember");
		String nickname = member.getNickname();
		System.out.println("nickname = " + nickname);
		
		// 업무로직
		List<Friends> friendsList = friendsService.selectAllFriends(nickname);
		System.out.println(friendsList);
		
		// view단 처리
		request.getSession().setAttribute("friendsList", friendsList);
		request.getRequestDispatcher("/WEB-INF/views/friends/friendsList.jsp").forward(request, response);
	} // doGet() end

}
