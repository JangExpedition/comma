package customer.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customer.model.dto.FAQ;
import customer.model.service.FAQService;

/**
 * Servlet implementation class faqServlet
 */
@WebServlet("/customer/faq")
public class FAQServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FAQService faqService = new FAQService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<FAQ> faqList = faqService.selectAllFAQ();
		
		request.setAttribute("faqList", faqList);
		
		request.getRequestDispatcher("/WEB-INF/views/customer/faq.jsp")
			.forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
