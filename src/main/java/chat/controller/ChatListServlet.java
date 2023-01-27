package chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.dto.Chat;
import chat.model.service.ChatService;

/**
 * Servlet implementation class ChatListServlet
 */
@WebServlet("/chat/chatList")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Chat> chatList = chatService.selectAllChat();
		
		request.setAttribute("chatList", chatList);
		
		request.getRequestDispatcher("/WEB-INF/views/chat/chatList.jsp")
			.forward(request, response);;
	}

}
