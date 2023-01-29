package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.dto.Chat;
import chat.model.dto.ChatLog;
import chat.model.service.ChatService;

/**
 * Servlet implementation class AdminChatFinderServlet
 */
@WebServlet("/admin/adminChatLogFinder")
public class AdminChatLogFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		List<ChatLog> chatLogList = chatService.selectFindChatLog(param);
		
		request.setAttribute("chatLogList", chatLogList);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminChatLogList.jsp").forward(request, response);
	} // doGet() end

}
