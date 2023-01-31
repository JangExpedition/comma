package friends.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.OX;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;

/**
 * Servlet implementation class DeleteFriendsServlet
 */
@WebServlet("/friends/friendsDelete")
public class DeleteFriendsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String myNick = request.getParameter("myNick");
			String fNick = request.getParameter("fNick");
			
			Friends friend1 = new Friends(0, myNick, fNick, null, null, null);
			Friends friend2 = new Friends(0, fNick, myNick, null, null, null);
			
			int result = friendsService.deleteFriend(friend1);
			result = friendsService.deleteFriend(friend2);
			
			// request.getSession().setAttribute("msg", "친구가 정상적으로 삭제되었습니다.");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "친구 삭제에 실패하셨습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/friends/friendsList");
	}

}
