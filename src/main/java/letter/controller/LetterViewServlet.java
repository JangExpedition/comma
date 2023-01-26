package letter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Attachment;
import common.CommaUtils;
import letter.model.dto.Letter;
import letter.model.service.LetterService;

/**
 * Servlet implementation class LetterViewServlet
 */
@WebServlet("/letter/letterView")
public class LetterViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		int letterNo = Integer.parseInt(request.getParameter("no"));

		
		String letterCookieVal = "";
		boolean hasRead = false;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				
				if ("letter".equals(name)) {
					letterCookieVal = value;
					if (value.contains("[" + letterNo + "]")) {
						hasRead = true;
					} // if () end
				} // if () end
			} // for each end
		} // if () end
		
		// 응답쿠키
		if (!hasRead) {
			Cookie cookie = new Cookie("letter", letterCookieVal + "[" + letterNo + "]");
			cookie.setMaxAge(365 * 24 * 60 * 60); // 365일
			cookie.setPath(request.getContextPath() + "/letter/letterView");
			response.addCookie(cookie);
		} // if() end
		
		// 업무로직
		Letter letter = letterService.selectOneLetter(letterNo);
		
		letter.setContent(
				CommaUtils.convertLineFeedToBr(
						CommaUtils.escapeHTML(letter.getContent()))
				);
		
		request.setAttribute("letter", letter);
		
		request.getRequestDispatcher("/WEB-INF/views/letter/letterView.jsp").forward(request, response);
	} // doGet() end

}
