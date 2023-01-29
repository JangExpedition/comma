package member.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.CommaUtils;
import friends.model.dto.Friends;
import friends.model.service.FriendsService;
import mail.Mail;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class FindPwdServlet
 */
@WebServlet("/member/findPwd")
public class FindPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private Mail mail = new Mail();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String result = "true";
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		Member member = memberService.selectOneMemberFromNick(nickname);
		
		if(member.getEmail().equals(email)) {
			String password =  getRamdomPassword(8);
			String setPwd = CommaUtils.getEncryptedPassword(password, member.getEmail());
			String content = "임시비밀번호는 " + password + "입니다.";
			mail.naverMailSend(email, content);
			
			Map<String, String> param = new HashMap<>();
			param.put("updateType", "password");
			param.put("updateData", setPwd);
			param.put("who", email);
			
			int updatePwdResult = memberService.updateMember(param);
			
			result = member.getEmail();
			
		}else {
			result = "false";
		}
		
		response.setContentType("application/jsp; charset=utf-8");
		Gson gson = new Gson();
		String jsonStr = gson.toJson(result);
		
		response.getWriter().append(jsonStr);
	}
	
	public String getRamdomPassword(int size) {
        char[] charSet = new char[] {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                '!', '@', '#', '$', '%', '^', '&' };

        StringBuffer sb = new StringBuffer();
        SecureRandom sr = new SecureRandom();
        sr.setSeed(new Date().getTime());

        int idx = 0;
        int len = charSet.length;
        for (int i=0; i<size; i++) {
            // idx = (int) (len * Math.random());
            idx = sr.nextInt(len);    // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
            sb.append(charSet[idx]);
        }

        return sb.toString();
    }

}
