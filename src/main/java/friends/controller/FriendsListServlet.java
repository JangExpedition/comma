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
		// 업무로직
		List<Friends> friendsList = friendsService.selectAllFriends();
		
		// 속성으로 전송
		request.getSession().setAttribute("friendsList", friendsList);
		
		// view단 처리
		request.getRequestDispatcher("/WEB-INF/views/friends/friendsList.jsp").forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	} // doPost() end

}
