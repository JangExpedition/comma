package complain.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import complain.model.dto.Complain;
import complain.model.dto.Partition;
import complain.model.service.ComplainService;

/**
 * Servlet implementation class ComplainServlet
 */
@WebServlet("/complain/complain")
public class ComplainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ComplainService complainService = new ComplainService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Complain> complainList = complainService.selectAllComplain();
		
		request.setAttribute("complainList", complainList);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminComplainList.jsp").forward(request, response);
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String writer = request.getParameter("my_nickname");
			String villain = request.getParameter("v_nickname");
			Partition partition = Partition.valueOf(request.getParameter("partition"));
			String content = request.getParameter("content");
			int partitionNo = Integer.parseInt(request.getParameter("part_no"));
			
			Complain complain = new Complain(0, writer, villain, partition, content, partitionNo, null);
			
			// 업무로직
			int result = complainService.insertComplain(complain);
			request.getSession().setAttribute("msg", "신고 성공!");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "신고 실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath());
	} // doPost() end

}
