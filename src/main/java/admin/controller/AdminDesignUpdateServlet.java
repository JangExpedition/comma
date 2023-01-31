package admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.CommaFileRenamePolicy;
import style.model.dto.Design;
import style.model.dto.Part;
import style.model.service.StyleService;

/**
 * Servlet implementation class AdminFontUpdateServlet
 */
@WebServlet("/admin/adminDesignUpdate")
public class AdminDesignUpdateServlet extends HttpServlet {
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
			
			int no = Integer.parseInt(multiReq.getParameter("updateNo"));
			String part = multiReq.getParameter("part");
			
			Design design = new Design();
			design.setNo(no);
			design.setPart(Part.valueOf(part));
			
			if (multiReq.getFile("upFile") != null) {
				design.setOriginalFilename(multiReq.getOriginalFileName("upFile"));
				design.setRenamedFilename(multiReq.getFilesystemName("upFile"));
			} else {
				Design design1 = styleService.selectOneDesign(no);
				design.setOriginalFilename(design1.getOriginalFilename());
				design.setRenamedFilename(design1.getRenamedFilename());
			}
			
			int result = styleService.updateDesign(design);
			request.getSession().setAttribute("msg", "디자인을 수정했습니다.");
			
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "디자인을 수정하지 못했습니다.");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/adminDesignList");
	} // doPost() end

}
