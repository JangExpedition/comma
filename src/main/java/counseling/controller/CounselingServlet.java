package counseling.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Attachment;
import common.Category;
import common.CommaUtils;
import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;
import member.model.dto.Gender;
import member.model.dto.Member;

/**
 * Servlet implementation class CounselingServlet
 */
@WebServlet("/counseling/counselingList")
public class CounselingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CounselingService counselingService = new CounselingService();
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String _category = request.getParameter("counselingCate");
		Category category = null;
		
		if(_category != null) {
			category = Category.valueOf(_category);
		}
		
		final int limit = 10;
		int page = 1;
		try {
			page = Integer.parseInt(request.getParameter("page"));
			System.out.println("page = " + page);
		} catch(NumberFormatException e) {
		}
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("page", page);
		
		List<Counseling> counselingList = counselingService.selectAllCounseling(param);
		List<Attachment> attachList = counselingService.selectAllCSAttachments();
		
		int totalCount = counselingService.getTotalCount();
		String url = request.getRequestURI();
		String pagebar = CommaUtils.getPageBar(page, limit, totalCount, url);
		
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberNick = loginMember.getNickname();
		int memberAge = loginMember.getAge()/10;
		Gender memberGender = loginMember.getGender();
		
		System.out.println("CounselingServlet loginMemberAge " + loginMember.getAge());
		System.out.println("CounselingServlet = " + memberNick + memberAge + memberGender);
		
		List<Counseling> afterCounselingList = new ArrayList<>();
		
		if(category == null || category == Category.ALL) {
			// 작성자 본인글, 나이, 성별 필터링
			for(Counseling counseling : counselingList) {
				
				if(counseling.getWriter().equals(memberNick)) {
					afterCounselingList.add(counseling);
				}else if((counseling.getLimitAge() <= memberAge) &&
						((counseling.getLimitGender() == memberGender) || (counseling.getLimitGender() == Gender.X))) {
					afterCounselingList.add(counseling);
				}
			}
		} else {
			for(Counseling counseling : counselingList) {
				
				if(counseling.getWriter().equals(memberNick)) {
					afterCounselingList.add(counseling);
				} else if((counseling.getLimitAge() <= memberAge) &&
							((counseling.getLimitGender() == memberGender) || (counseling.getLimitGender() == Gender.X)) && 
										((category.equals(counseling.getCategory())) || category.equals("all"))
										) {
					afterCounselingList.add(counseling);
				}
				
				
			}
		}
		
		
		System.out.println("CounselingServlet = " + afterCounselingList);
		
		request.setAttribute("pagebar", pagebar);
		request.setAttribute("counselingList", afterCounselingList);
		request.setAttribute("attachList", attachList);
		
		request.getRequestDispatcher("/WEB-INF/views/counseling/counseling.jsp")
			.forward(request, response);
	}

}
