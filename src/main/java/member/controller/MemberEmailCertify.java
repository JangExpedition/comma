package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class MemberEmailCertify
 */
@WebServlet("/member/emailCertify")
public class MemberEmailCertify extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MailSend mail = new MailSend();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String clientMail = request.getParameter("clientMail");
		String code = mail.mailSend(clientMail);
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(code);
		System.out.println(jsonStr);
		
		response.getWriter().append(jsonStr);
	}

}
