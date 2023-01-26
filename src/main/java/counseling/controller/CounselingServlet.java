package counseling.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Attachment;
import common.CommaUtils;
import counseling.model.dto.Counseling;
import counseling.model.service.CounselingService;

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
		final int limit = 10;
		int page = 1;
		try {
			page = Integer.parseInt(request.getParameter("page"));
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
		
		request.setAttribute("pagebar", pagebar);
		request.setAttribute("counselingList", counselingList);
		request.setAttribute("attachList", attachList);
		
		request.getRequestDispatcher("/WEB-INF/views/counseling/counseling.jsp")
			.forward(request, response);
	}

}
