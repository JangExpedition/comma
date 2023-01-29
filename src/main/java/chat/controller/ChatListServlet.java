package chat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chat.model.dto.Chat;
import chat.model.service.ChatService;
import counseling.model.dto.Counseling;
import member.model.dto.Gender;
import member.model.dto.Member;

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
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		int memberAge = loginMember.getAge()/10;
		Gender memberGender = loginMember.getGender();
		
		List<Chat> beforchatList = chatService.selectAllChat();
		List<Chat> afterchatList = new ArrayList<>();
		
		for(Chat chat : beforchatList) {
			if((chat.getAbleAge() <= memberAge) &&
					((chat.getAbleGender() == memberGender) || (chat.getAbleGender() == Gender.X))) {
				afterchatList.add(chat);
			}
		}
		
		request.setAttribute("chatList", afterchatList);
		
		request.getRequestDispatcher("/WEB-INF/views/chat/chatList.jsp")
			.forward(request, response);;
	}

}
