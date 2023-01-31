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
 * Servlet implementation class UpdateIsFriendServlet
 */
@WebServlet("/friends/friendsUpdate")
public class UpdateIsFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String myNick = request.getParameter("myNick");
			String fNick = request.getParameter("fNick");
			
			Friends friend = new Friends(0, myNick, fNick, OX.O, null, null);
			
			int result = friendsService.updateIsFriend(friend);
			
			//request.getSession().setAttribute("msg", "친구 여부 수정 성공!");
		} catch (Exception e) {
			//request.getSession().setAttribute("msg", "친구 여부 수정 실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/friends/friendsList");
	} // doPost() end

}
