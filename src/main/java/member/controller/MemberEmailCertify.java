package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mail.Mail;

/**
 * Servlet implementation class MemberEmailCertify
 */
@WebServlet("/member/emailCertify")
public class MemberEmailCertify extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Mail mail = new Mail();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String email = request.getParameter("email");
			
			int _code = (int) (Math.random()*89999+100000);
	        String code = String.valueOf(_code);
	        String content = "인증번호는 " + code + "입니다.";
			
			mail.naverMailSend(email, content);
			
			response.setContentType("application/jsp; charset=utf-8");
			Gson gson = new Gson();
			String jsonStr = gson.toJson(code);
			
			response.getWriter().append(jsonStr);

	}

}
