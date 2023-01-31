package common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;
import member.model.dto.MemberRole;

@WebFilter({"/", "/friends/*", "/diary/*", "/letter/*", "/chat/chatList", "/counseling/*", "/mypage/*", "/customer/*"})
public class ChatNoFilter extends HttpFilter implements Filter {

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// downcasting
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;
		
		// login 여부 확인
		HttpSession session = httpReq.getSession();
		String _chatNo = (String) session.getAttribute("chatNo");
		int chatNo = 0;
		if(_chatNo != null) {
			chatNo = Integer.valueOf(_chatNo);
		}
		
		if (chatNo > 0) {
			session.removeAttribute("chatNo");
			System.out.println("채팅넘버 제거 필터!!!");
			httpRes.sendRedirect(httpReq.getContextPath() + "/chat/chatList");
			return;
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
	
}
