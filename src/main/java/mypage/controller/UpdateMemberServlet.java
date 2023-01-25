package mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.CommaFileRenamePolicy;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/member/memberUpdate")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private FriendsService friendsService = new FriendsService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			
			int result = 0;
			
			String saveDirectory = getServletContext().getRealPath("/upload/profile");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			FileRenamePolicy policy = new CommaFileRenamePolicy(); 
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			Member loginMember = (Member) session.getAttribute("loginMember");
			Member member = memberService.selectOneMember(loginMember.getEmail());
			
			String newNickname = multiReq.getParameter("nickname");
			
			
			Map<String, String> param = new HashMap<>();
			
			if(multiReq.getFile("updateFile") != null) {
				String originalFN = multiReq.getOriginalFileName("updateFile");
				
				member.setOriginalFilename(originalFN);
				param.put("updateType", "original_filename");
				param.put("updateData", originalFN);
				param.put("who", member.getEmail());
				
				result = memberService.updateMember(param);
				
				String renamedFN = multiReq.getFilesystemName("updateFile");
				
				member.setRenamedFilename(renamedFN);
				param.put("updateType", "renamed_filename");
				param.put("updateData", renamedFN);
				param.put("who", member.getEmail());
				
				result = memberService.updateMember(param);
				
			}
			
			if(!member.getNickname().equals(newNickname)){
				
				param.put("updateType", "nickname");
				param.put("updateData", newNickname);
				param.put("who", member.getEmail());
				
				result = memberService.updateMember(param);
				
			}
			
			request.setAttribute("msg", "회원정보 수정성공!");
			List<Friends> friendsList = friendsService.selectAllFriends(loginMember.getNickname());
			session.setAttribute("loginMember", member);
			session.setAttribute("friendsList", friendsList);
			
		} catch(Exception e) {
			request.setAttribute("msg", "회원정보 수정실패!");
		}
		
		response.sendRedirect(request.getContextPath() + "/mypage/mypage");
	}

}
