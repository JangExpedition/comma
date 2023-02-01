package friends.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import friends.model.dto.Friends;
import friends.model.service.FriendsService;

/**
 * Servlet implementation class FriendsFinderServlet
 */
@WebServlet("/friends/friendsFinder")
public class FriendsFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 처리
		String nickname = request.getParameter("memberNick");
		String searchNick = request.getParameter("searchNick");
		
		Map<String, Object> param = new HashMap<>();
		param.put("nickname", nickname);
		param.put("searchNick", searchNick);
		
		// 업무로직
		List<Friends> friendsList = friendsService.searchFriends(param);
		System.out.println("friends = " + friendsList);
		
		// view단 처리
		request.setAttribute("searchNick", searchNick);
		request.getSession().setAttribute("friendsList", friendsList);
		request.getRequestDispatcher("/WEB-INF/views/friends/friendsList.jsp").forward(request, response);
		
	} // doGet() end

}
