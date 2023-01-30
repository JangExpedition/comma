package chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chat.model.dto.Chat;
import chat.model.service.ChatService;
import common.Category;
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
			Category category = Category.valueOf(request.getParameter("category"));
			Gender gender = Gender.valueOf(request.getParameter("gender"));
			int ableAge = Integer.valueOf(request.getParameter("age"));
			int ableCount = Integer.valueOf(request.getParameter("chattingPerson"));
			
			Chat chat = new Chat(0, chatName, captin, category, gender, ableAge, 0, ableCount, null, null, null);
			
			System.out.println("InsertChatServlet" + chat);
			
			int result = chatService.insertChat(chat);
			
			response.sendRedirect(request.getContextPath() + "/chat/chatView?chatNo=" + chat.getNo());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
