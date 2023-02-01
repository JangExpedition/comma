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

/**
 * Servlet Filter implementation class AdminLoginFilter
 */
@WebFilter({"/admin/*", "/complain/complainList", "/complain/complainFinder", "/customer/faqEnroll", "/customer/faqUpdate", "/customer/faqDelete"})
public class AdminLoginFilter extends HttpFilter implements Filter {

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
		Member member = (Member) session.getAttribute("loginMember");
		
		if (member == null || member.getMemberRole() != MemberRole.A) {
			session.setAttribute("msg", "관리자로 로그인 후 이용 가능합니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/");
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
