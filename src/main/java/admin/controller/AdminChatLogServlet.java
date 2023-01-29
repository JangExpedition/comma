package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.dto.ChatLog;
import chat.model.service.ChatService;

/**
 * Servlet implementation class AdminChatLogServlet
 */
@WebServlet("/admin/adminChatLog")
public class AdminChatLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		List<ChatLog> chatLogList = chatService.selectAllChatLog(no);
		
		request.setAttribute("chatLogList", chatLogList);
		request.getRequestDispatcher("/WEB-INF/views/admin/adminChatLogList.jsp").forward(request, response);
	} // doGet() end

}
