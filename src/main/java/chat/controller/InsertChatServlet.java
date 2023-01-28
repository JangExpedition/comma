package chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chat.model.dto.Chat;
import chat.model.dto.ChatMember;
import chat.model.service.ChatService;
import member.model.dto.Gender;
import member.model.dto.Member;

/**
 * Servlet implementation class InsertChatServlet
 */
@WebServlet("/chat/insertChat")
public class InsertChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			Member loginMember = (Member) session.getAttribute("loginMember");
			String captin = loginMember.getNickname();
			String chatName = request.getParameter("chatTitle");
			String category = request.getParameter("category");
			Gender gender = Gender.valueOf(request.getParameter("gender"));
			int ableAge = Integer.valueOf(request.getParameter("age"));
			int ableCount = Integer.valueOf(request.getParameter("chattingPerson"));
			
			Chat chat = new Chat(0, chatName, captin, gender, ableAge, 0, ableCount, null);
			
			int result = chatService.insertChat(chat);
			
			response.sendRedirect(request.getContextPath() + "/chat/chatView?chatNo=" + chat.getNo());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
