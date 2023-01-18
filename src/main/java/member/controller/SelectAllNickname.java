package member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.manager.MemberManager;
import member.model.service.MemberService;

/**
 * Servlet implementation class CheckOverlapNickname
 */
@WebServlet("/member/selectAllNickname")
public class SelectAllNickname extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> nicks = MemberManager.getInstance().getNicks();
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(nicks);
		System.out.println(jsonStr);
		
		response.getWriter().append(jsonStr);
	}

}
