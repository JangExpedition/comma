package chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import chat.model.dto.Chat;
import chat.model.service.ChatService;

/**
 * Servlet implementation class SelectOneChat
 */
@WebServlet("/chat/selectOneChat")
public class SelectOneChat extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chatNo = Integer.valueOf(request.getParameter("chatNo"));
		
		Chat chat = chatService.selectOneChat(chatNo);
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(chat);
		
		response.getWriter().append(jsonStr);
	}

}
