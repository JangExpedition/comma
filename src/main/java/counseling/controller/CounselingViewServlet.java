package counseling.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommaUtils;
import counseling.model.dto.Counseling;
import counseling.model.dto.CounselingComment;
import counseling.model.dto.LikeCounseling;
import counseling.model.service.CounselingService;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import member.model.dto.Member;

/**
 * Servlet implementation class CounselingViewServlet
 */
@WebServlet("/counseling/CSView")
public class CounselingViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.valueOf(request.getParameter("no"));
		Member member = (Member) request.getSession().getAttribute("loginMember");
		List<Friends> friendsList = friendsService.selectAllFriends(member.getNickname());
		
		// board 쿠키처리 board="[84][22]"
		String csCookieVal = "";
		boolean hasRead = false;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				
				if("counseling".equals(name)) {
					csCookieVal = value;
					if(value.contains("[" + no + "]")) {
						hasRead = true;
					}
				}
			}
		}
		
		// 응답쿠키
		if(!hasRead) {
			Cookie cookie = new Cookie("board", csCookieVal + "[" + no + "]");
			cookie.setMaxAge(365 * 24 * 60 * 60); // 365일
			cookie.setPath(request.getContextPath() + "/board/boardView");
			response.addCookie(cookie);
		}
		
		
		
		Counseling counseling = counselingService.selectOneCS(no, hasRead);
		
		counseling.setContent(
			CommaUtils.convertLineFeedToBr(
			CommaUtils.escapeHTML(counseling.getContent()))
		);
		
		List<CounselingComment> csComments = counselingService.selectCsComment(no);
		
		List<LikeCounseling> likeCounselingList = counselingService.selectAllLikeCs(no);
		
		request.setAttribute("friendsList", friendsList);
		request.setAttribute("counseling", counseling);
		request.setAttribute("comments", csComments);
		request.setAttribute("likeList", likeCounselingList);
		request.getRequestDispatcher("/WEB-INF/views/counseling/counselingViewer.jsp")
			.forward(request, response);
	}

}
