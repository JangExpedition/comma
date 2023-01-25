package common;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Map;

import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;

import com.google.gson.Gson;
import ws.endpoint.CommaWebSocket;

public class CommaUtils {

	/**
	 * 단방향 암호화 - 복호화 불가능
	 * 
	 *  1. 암호화 처리
	 *  2. 인코딩 - Base64Encoder 사용 (이진데이터 -> 문자열)
	 *  
	 * salt 비밀번호 암호화에 추가적으로 적용해서 사용자별로 다른 결과값을 얻도록 함.
	 * 
	 * @param parameter
	 * @return
	 */
	public static String getEncryptedPassword(String rawPassword, String salt) {
		String encryptedPassword = null;
		
		try {
			// 1. 암호화 - MessageDigest 클래스 사용
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] _salt = salt.getBytes("utf-8");
			byte[] _rawPassword = rawPassword.getBytes("utf-8");
			md.update(_salt);
			byte[] _encryptedPassword = md.digest(_rawPassword); // 실제 인코딩
			
			System.out.println(new String(_encryptedPassword));
			
			// 2. 인코딩 - Base64Encoder 클래스 사용 (영문자 52개, 숫자 10개, +, /) padding문자 =
			Encoder encoder = Base64.getEncoder();
			encryptedPassword = encoder.encodeToString(_encryptedPassword); // 문자열로 변환해서 반환해줌
			
			System.out.println(encryptedPassword);
			
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return encryptedPassword;
	} // getEncryptedPassword() end

	
	/**
	 * totalPage 전체 페이지 수
	 * pagebarSize 페이지 바의 링크 갯수
	 * pageNo 증감변수
	 * pageStart ~ pageEnd 증감변수 범위
	 * 
	 * @param page
	 * @param limit
	 * @param totalCount
	 * @param url
	 * @return
	 */
	public static String getPageBar(int page, int limit, int totalCount, String url) {
		StringBuilder pagebar = new StringBuilder();
		url += "?page=";
				
		// 전체 페이지 수
//		int totalPage = totalCount % limit != 0 ? totalCount / limit + 1 : totalCount / limit;
		int totalPage = (int) Math.ceil((double) totalCount / limit); // 11.4 -> 12.0 -> 12
		
		int pagebarSize = 5;
		// 페이지 바의 시작넘버
		int pageStart = ((page - 1) / pagebarSize) * pagebarSize + 1;
		
		// 페이지 바의 끝넘버
		int pageEnd = pageStart + pagebarSize - 1; // 1-5, 6-10
		
		// 증감변수
		int pageNo = pageStart;
		
		// 1. 이전 영역
		// <
		if (pageNo == 1) {
			// 1 2 3 4 5 이므로 이동할 이전 페이지 없음.
		}
		else {
			pagebar.append("<a href='" + url + (pageNo - 1) + "'>이전</a> \n"); // 현재페이지가 6인 경우 /mvc/admin/memberList?page=5
		}
		
		// 2. pageNo 영역
		// 1 2 3 4 5
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == page) {
				// 현재 페이지 링크인 경우
				pagebar.append("<span class='cPage'>" + pageNo + "</span> \n");
			}
			else {
				// 현재 페이지 링크가 아닌 경우
				pagebar.append("<a href='" + url + pageNo + "'>" + pageNo + "</a> \n");
			}
			
			pageNo++;
		} // while() end
		
		// 3. 다음 영역
		// >
		if (pageNo > totalPage) {
			// 마지막 페이지 이후는 다음 버튼 필요 없음.
		}
		else {
			pagebar.append("<a href='" + url + pageNo + "'>다음</a> \n");
		}
		
		return pagebar.toString();
	} // getPageBar() end


	public static String convertLineFeedToBr(String str) {
		return str.replaceAll("\\n", "<br/>");
	} // convertLineFeedToBr() end

	/**
	 * XSS 공격대비 방어
	 *  - cross-site scripting 공격
	 *  - 악성스크립트를 작성하고, 열람하는 사용자로 하여금, 자신들이 만든 가짜페이지로 이동시키거나, 브라우저내의 쿠키 등 개인정보를 탈취하는 공격
	 *  
	 * @param str
	 * @return
	 */
	public static String escapeHTML(String str) {
		return str.replaceAll("<", "&lt;");
	} // escapeHTML() end


	public static boolean isConnected(String memberNick) {
		return CommaWebSocket.clientMap.containsKey(memberNick);
	} // isConnected() end


	public static void sendNotification(String to, Map<String, Object> data) {
		Session sess = CommaWebSocket.clientMap.get(to);
		if (sess != null) {
			Basic basic = sess.getBasicRemote();
			
			try {
				basic.sendText(new Gson().toJson(data));
			} catch (IOException e) {
				e.printStackTrace();
			}
		} // if() end
	} // sendNotification() end

} // class end
