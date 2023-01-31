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
import notification.model.service.NotificationService;

/**
 * Servlet implementation class FriendsRequestServlet
 */
@WebServlet("/friends/friendRequest")
public class FriendsRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();
	private NotificationService notificationService = new NotificationService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		try {
			String fNick = request.getParameter("fNick");
			String myNick = request.getParameter("myNick");
			
			System.out.println("fNick = " + fNick);
			System.out.println("myNick = " + fNick);
			
			Friends friends = new Friends(0, myNick, fNick, OX.X, null, null);
			
			int result = friendsService.insertFriend(friends);
			
			try {
				notificationService.notifyNewFriend(friends);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			request.getSession().setAttribute("msg", "친구 신청이 되었습니다.");
		} catch(Exception e) {
			request.getSession().setAttribute("msg", "친구 신청에 실패하셨습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/letter/letterView?no=" + no);
	} // doPost() end

}
