package chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import chat.model.service.ChatService;
import member.model.dto.Member;

/**
 * Servlet implementation class LeaveChatServlet
 */
@WebServlet("/chat/leaveChat")
public class LeaveChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int chatNo = Integer.valueOf(request.getParameter("chatNo"));
			Member loginMember = (Member) request.getSession().getAttribute("loginMember");
			String nickname = loginMember.getNickname();
			
			response.setContentType("application/jsp; charset=utf-8");
			Gson gson = new Gson();
			String jsonStr = gson.toJson(nickname);
			
			response.getWriter().append(jsonStr);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
