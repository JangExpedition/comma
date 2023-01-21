package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.CommaFileRenamePolicy;
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
		String saveDirectory = getServletContext().getRealPath("/profile");
		int maxPostSize = 10 * 1024 * 1024;
		String encoding = "utf-8";
		FileRenamePolicy policy = new CommaFileRenamePolicy();
		
		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		String originalFilename = multiReq.getOriginalFileName("default.png");
		String renamedFilename = multiReq.getFilesystemName("default.png");
		
		String nickname = multiReq.getParameter("nickname");
		String email = multiReq.getParameter("email");
		String pwd = CommaUtils.getEncryptedPassword(multiReq.getParameter("pwd"), email);
		Date birth = Date.valueOf(multiReq.getParameter("birth"));
		Gender gender = Gender.valueOf(multiReq.getParameter("gender"));
		
		Member member = new Member(nickname, pwd, birth, gender, email, null, null, 0, originalFilename, renamedFilename);
		
		
		int result = memberService.insertMember(member);
	}

}
