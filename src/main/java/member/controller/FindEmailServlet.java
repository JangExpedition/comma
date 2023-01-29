package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.CommaUtils;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class FindEmailServlet
 */
@WebServlet("/member/findEmail")
public class FindEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String result = "true";
		String nickname = request.getParameter("nickname");
		Member member = memberService.selectOneMemberFromNick(nickname);
		String password = CommaUtils.getEncryptedPassword(request.getParameter("password"), member.getEmail());
		
		if(member.getPassword().equals(password)) {
			result = member.getEmail();
		}else {
			result = "false";
		}
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(result);
		
		response.getWriter().append(jsonStr);
		
	}

}
