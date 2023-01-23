package letter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import letter.model.service.LetterService;

/**
 * Servlet implementation class WriteLetterServlet
 */
@WebServlet("/letter/writeLetter")
public class WriteLetterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/letter/letter.jsp")
			.forward(request, response);  
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String anonymous = request.getParameter("senderChoice");
		System.out.println("anonymous = " + anonymous);
		String gender = request.getParameter("genderChoice");
		System.out.println("gender = " + gender);
		System.out.println("age = " + request.getParameter("ageChoice"));
		int age = Integer.parseInt(request.getParameter("ageChoice"));
		int font = Integer.parseInt(request.getParameter("fontChoice"));
		int design = Integer.parseInt(request.getParameter("designChoice"));
		System.out.println(request.getParameter("imgChoice"));
	} // doPost() end

}
