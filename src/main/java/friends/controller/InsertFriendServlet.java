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

import com.google.gson.Gson;

import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import notification.model.service.NotificationService;

/**
 * Servlet implementation class InsertFriendServlet
 */
@WebServlet("/friends/friendship")
public class InsertFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FriendsService friendsService = new FriendsService();
	private NotificationService notificationService = new NotificationService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String fNick = request.getParameter("fNick");
			String myNick = request.getParameter("myNick");
			
			System.out.println("fNick = " + fNick);
			System.out.println("myNick = " + fNick);
			
			Friends friends = new Friends(0, myNick, fNick, null, null, null);
			
			int result = friendsService.insertFriend(friends);
			
			Map<String, Object>map = new HashMap<>();
			map.put("result", "친구요청 성공!");
			
			try {
				notificationService.notifyNewFriend(friends);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(map, response.getWriter());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
