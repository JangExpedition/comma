package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.dto.ChatMember;
import chat.model.service.ChatService;

/**
 * Servlet implementation class AdminChatMemberServlet
 */
@WebServlet("/admin/adminChatMember")
public class AdminChatMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		List<ChatMember> chatMemberList = chatService.selectAllChatMember(no);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminChatList.jsp").forward(request, response);
	} // doGet() end

}
