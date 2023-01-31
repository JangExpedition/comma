package admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.service.ChatService;

/**
 * Servlet implementation class AdminChatLogDeleteServlet
 */
@WebServlet("/admin/adminChatLogDelete")
public class AdminChatLogDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chatLogNo = Integer.parseInt(request.getParameter("chatLogNo"));
		try {
			int result = chatService.deleteChatLog(chatLogNo);
			request.getSession().setAttribute("msg", "해당 채팅 로그를 삭제했습니다.");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "해당 채팅 로그를 삭제하는데 실패했습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/adminChatLog?no=" + chatLogNo);
	} // doPost() end

}
