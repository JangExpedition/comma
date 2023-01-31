package admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.CommaFileRenamePolicy;
import style.model.dto.Design;
import style.model.dto.Part;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminFontEnrollServlet
 */
@WebServlet("/admin/adminDesignEnroll")
public class AdminDesignEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StyleService styleService = new StyleService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// MultipartRequest객체 생성
			String saveDirectory = getServletContext().getRealPath("/upload/design");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			String part = multiReq.getParameter("part");
			
			Design design = new Design();
			design.setPart(Part.valueOf(part));
			
			if (multiReq.getFile("upFile") != null) {
				design.setOriginalFilename(multiReq.getOriginalFileName("upFile"));
				design.setRenamedFilename(multiReq.getFilesystemName("upFile"));
			}
			
			int result = styleService.insertDesign(design);
			request.getSession().setAttribute("msg", "디자인을 추가했습니다.");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "디자인을 추가하지 못했습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/adminDesignList");
	} // doPost() end

}
