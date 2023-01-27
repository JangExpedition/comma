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
 * Servlet implementation class FAQDeleteServlet
 */
@WebServlet("/customer/faqUpdate")
public class FAQUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FAQService faqService = new FAQService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		FAQ faq = faqService.selectOneFaq(no);
		
		request.setAttribute("faq", faq);

		request.getSession().setAttribute("type", "faq");
		request.getRequestDispatcher("/WEB-INF/views/customer/faqUpdate.jsp").forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("faqNo"));
		try {
			String title = request.getParameter("faqTitle");
			String content = request.getParameter("content");
			
			FAQ faq = new FAQ(no, title, content);
			
			int result = faqService.updateFaq(faq);
			
			request.getSession().setAttribute("msg", "FAQ 수정 성공!");
		} catch(Exception e) {
			request.getSession().setAttribute("msg", "FAQ 수정 실패!");
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("type", "faq");
		response.sendRedirect(request.getContextPath() + "/customer");
	} // doPost() end

}
