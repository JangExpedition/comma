package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommaUtils;
import member.model.dto.Gender;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			
//			String saveDirectory = getServletContext().getRealPath("/profile");
//			int maxPostSize = 10 * 1024 * 1024;
//			String encoding = "utf-8";
//			FileRenamePolicy policy = new CommaFileRenamePolicy();
//			
//			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
//			
//			String originalFilename = multiReq.getOriginalFileName(imageFile.toString());
//			String renamedFilename = multiReq.getFilesystemName(imageFile.toString());
			
			String nickname = request.getParameter("nickname");
			String email = request.getParameter("email");
			String pwd = CommaUtils.getEncryptedPassword(request.getParameter("pwd"), email);
			String _birth = request.getParameter("birth");
			String birthYear = _birth.substring(0, 4);
			String birthMonth = _birth.substring(4, 6);
			String birthDate = _birth.substring(6);
			String birthDay = birthYear + "-" + birthMonth + "-" + birthDate;
			Date birth = Date.valueOf(birthDay);
			Gender gender = Gender.valueOf(request.getParameter("gender"));
			
			Member member = new Member(nickname, pwd, birth, gender, email, null, null, 0, null, null);
			
			
			int result = memberService.insertMember(member);
			
			if(result > 0) {
				session.setAttribute("msg", "회원가입 성공!");
			}
			
		} catch(Exception e) {
			session.setAttribute("msg", "회원가입 실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/");
	}

}
