package customer.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import customer.model.dto.FAQ;
import customer.model.dto.Question;
import customer.model.service.FAQService;
import customer.model.service.QuestionService;
import member.model.dto.Member;

/**
 * Servlet implementation class CustomerServiceServlet
 */
@WebServlet("/customer")
public class CustomerServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuestionService questionService = new QuestionService();
	private FAQService faqService = new FAQService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = (Member) request.getSession().getAttribute("loginMember");
		String nickname = member.getNickname();
		System.out.println("memberNick = " + nickname);
		
		List<Question> questionList = questionService.selectMyAllQuestion(nickname);
		List<FAQ> faqList = faqService.selectAllFAQ();
		
		for (FAQ faq : faqList) {
			faq.setContent(
					CommaUtils.convertLineFeedToBr(
							CommaUtils.escapeHTML(faq.getContent()))
					);			
		}
		
		request.setAttribute("questionList", questionList);
		request.setAttribute("faqList", faqList);
		
		request.getRequestDispatcher("/WEB-INF/views/customer/customerService.jsp")
			.forward(request, response);
	} // doGet() end

}
