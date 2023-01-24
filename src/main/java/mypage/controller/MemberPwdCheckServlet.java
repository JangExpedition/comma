package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.CommaUtils;

/**
 * Servlet implementation class MemberPwdCheckServlet
 */
@WebServlet("/member/passwordCheck")
public class MemberPwdCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginId = request.getParameter("loginId");
		String checkInput = request.getParameter("checkInput");
		String checkData = CommaUtils.getEncryptedPassword(checkInput, loginId);
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(checkData);
		
		response.getWriter().append(jsonStr);
	}

}
