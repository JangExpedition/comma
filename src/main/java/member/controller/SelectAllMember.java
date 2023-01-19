package member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.dto.Member;
import member.model.manager.MemberManager;

/**
 * Servlet implementation class CheckOverlapNickname
 */
@WebServlet("/member/selectAllMember")
public class SelectAllMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> memberList = MemberManager.getInstance().getNicks();
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(memberList);
		System.out.println(jsonStr);
		
		response.getWriter().append(jsonStr);
	}

}
