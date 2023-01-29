package admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.model.service.ChatService;

/**
 * Servlet implementation class AdminChatDeleteServlet
 */
@WebServlet("/admin/adminChatDelete")
public class AdminChatDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatService chatService = new ChatService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("chatNo"));
			
			int result = chatService.deleteChat(no);
			request.getSession().setAttribute("msg", "채팅방 삭제 성공!");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "채팅방 삭제 실패!");
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/admin/adminChatList");
	} // doPost() end

}
