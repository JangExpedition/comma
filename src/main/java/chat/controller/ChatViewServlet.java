package chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.dto.ChatLog;
import chat.model.service.ChatService;
import member.model.dto.Member;

/**
 * Servlet implementation class ChatViewServlet
 */
@WebServlet("/chat/chatView")
public class ChatViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = (Member) request.getSession().getAttribute("loginMember");
		String nickname = member.getNickname();
		String chatNo = request.getParameter("chatNo");
		if(chatNo == null || "".equals(chatNo)) {
			throw new IllegalArgumentException("채팅방 아이디가 유효하지 않습니다.");
		}
		
		int no = Integer.valueOf(chatNo);
		
		List<ChatLog> chatLogs = chatService.selectAllChatLog(no);
		
		request.getSession().setAttribute("chatNo", chatNo);
		request.getSession().setAttribute("chatLogs", no);
		
		request.getRequestDispatcher("/WEB-INF/views/chat/chatView.jsp")
		.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
	}

}
