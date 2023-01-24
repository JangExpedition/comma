package letter.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.Attachment;
import common.CommaFileRenamePolicy;
import common.OX;
import letter.model.dto.AF;
import letter.model.dto.Letter;
import letter.model.service.LetterService;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class WriteLetterServlet
 */
@WebServlet("/letter/writeLetter")
public class WriteLetterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LetterService letterService = new LetterService();
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/letter/letter.jsp")
			.forward(request, response);  
	} // doGet() end

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// MultipartRequest객체 생성
			String saveDirectory = getServletContext().getRealPath("/upload/letter");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 사용자 입력값 처리
			String writer = multiReq.getParameter("writer");
			OX anonymous = OX.valueOf(multiReq.getParameter("senderChoice"));
			int design = Integer.parseInt(multiReq.getParameter("designChoice"));
			int font = Integer.parseInt(multiReq.getParameter("fontChoice"));
			String content = multiReq.getParameter("content");
			
			AF sendWho = AF.valueOf(multiReq.getParameter("sendChoice"));
			String addressee = "";
			String gender = multiReq.getParameter("genderChoice");
			int age = Integer.parseInt(multiReq.getParameter("ageChoice"));
			
			Map<String, Object> param = new HashMap<>();
			param.put("writer", writer);
			param.put("gender", gender);
			param.put("age", age);
			
			// 익명의 누군가
			if (sendWho == AF.A) {
				List<Member> memberList = memberService.selectAllMemberWithOutMe(param);
				System.out.println(memberList);
				int limit = memberList.size();
				System.out.println("limit = " + limit);
				int ranNum = (int) (Math.random() * limit);
				System.out.println("ranNum = " + ranNum);
				addressee = memberList.get(ranNum).getNickname();
			} else {
				addressee = multiReq.getParameter("friendsList");
			}
			
			Letter letter = new Letter(0, writer, addressee, design, font, content, null, null, gender, age, anonymous, sendWho);
			
			// 업로드한 파일 처리
			if (multiReq.getFile("imgChoice1") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("imgChoice1"));
				attach.setRenamedFilename(multiReq.getFilesystemName("imgChoice1"));
				letter.addAttachment(attach);
			}
			
			if (multiReq.getFile("imgChoice2") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("imgChoice2"));
				attach.setRenamedFilename(multiReq.getFilesystemName("imgChoice2"));
				letter.addAttachment(attach);
			}
			
			if (multiReq.getFile("imgChoice3") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("imgChoice3"));
				attach.setRenamedFilename(multiReq.getFilesystemName("imgChoice3"));
				letter.addAttachment(attach);
			}
			
			System.out.println("writer = " + writer);
			System.out.println("sendWho = " + sendWho);
			System.out.println("addressee = " + addressee);
			System.out.println("designChoice = " + design);
			System.out.println("fontChoice = " + font);
			System.out.println("content = " + content);
			System.out.println("genderChoice = " + gender);
			System.out.println("ageChoice = " + age);
			System.out.println("senderChoice = " + anonymous);
			
			
			// 업무로직
			int result = letterService.insertLetter(letter);
			
			request.getSession().setAttribute("msg", "편지 보내기 성공!");
		} catch (Exception e) {
			request.getSession().setAttribute("msg", "편지 보내기 실패!");
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath() + "/letter/writeLetter");
	} // doPost() end

}
