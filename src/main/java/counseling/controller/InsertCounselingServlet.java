package counseling.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Category;
import common.OX;
import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;

/**
 * Servlet implementation class InsertCounselingServlet
 */
@WebServlet("/counseling/insertCounseling")
public class InsertCounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			String writer = request.getParameter("loginMember");
			String content = request.getParameter("content");
			String title = request.getParameter("title");
			Category category = Category.valueOf(request.getParameter("category"));
			String limitGender = request.getParameter("gender");
			int limitAge = Integer.valueOf(request.getParameter("age"));
			OX anonymous = OX.valueOf(request.getParameter("anonymous"));
			
			System.out.println("limitAge = " + limitAge);
			
			Counseling counseling = new Counseling(0, writer, content, null, title, 0, 0, category, limitGender, limitAge, anonymous);
			
			int result = counselingService.insertCounseling(counseling);
			
			if(result > 0) {
				session.setAttribute("msg", "게시글이 정상적으로 등록되었습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "게시글 등록실패!");
		}
		response.sendRedirect(request.getContextPath() + "/counseling/counselingList");
	}

}
