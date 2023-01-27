package customer.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customer.model.dto.FAQ;
import customer.model.service.FAQService;

/**
 * Servlet implementation class FAQEnrollServlet
 */
@WebServlet("/customer/faqEnroll")
public class FAQEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FAQService faqService = new FAQService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/customer/faqEnroll.jsp").forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
		    String title = request.getParameter("faqTitle");
		    String content = request.getParameter("content");
		    
		    FAQ faq = new FAQ(0, title, content);
		    
		    int result = faqService.insertFaq(faq);
		    
		    request.getSession().setAttribute("msg", "FAQ 추가 성공!");
		}
		catch(Exception e) {
			request.getSession().setAttribute("msg", "FAQ 추가 실패!");
			e.printStackTrace();
		}
		
		request.setAttribute("type", "faq");
		response.sendRedirect(request.getContextPath() + "/customer" );
	}

}
