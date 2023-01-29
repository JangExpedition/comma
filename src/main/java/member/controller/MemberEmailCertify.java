package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mail.Gmail;

/**
 * Servlet implementation class MemberEmailCertify
 */
@WebServlet("/member/emailCertify")
public class MemberEmailCertify extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gmail mail = new Gmail();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			request.setCharacterEncoding("UTF-8");
			String fromName = "쉼표";
			String fromEmail = request.getParameter("email");
			String fromSubject = "안녕하세요. 쉼표입니다.";
			String fromPhone = "ㅇ";
			String fromMessage = "테스트메일";
			
			String[] fromInfo = {fromName,fromEmail,fromSubject,fromPhone,fromMessage};
			
			fromInfo[4] = "성함: "+fromInfo[0]+"\n"+"전화번호: "+fromInfo[3]+"\n"+"이메일: "+fromInfo[1]+"\n\n"+fromInfo[4];
			
			mail.send(fromInfo);

	}

}
