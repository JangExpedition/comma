package ws.config;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import member.model.dto.Member;


public class CommaWebSocketConfigurator extends Configurator {

	/**
	 * 웹소켓 연결 요청/수락 시 (handshake) 기본설정 메소드
	 * 
	 *  - 사용자 아이디(http세션)를 웹소켓 설정 맵에 미리 저장
	 */
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		HttpSession session = (HttpSession) request.getHttpSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberNickname = loginMember.getNickname();
		
		// 채팅페이지에 접속하는 경우
		String chatroomId = (String) session.getAttribute("chatroomId");
		
		// 설정 맵에 저장
		Map<String, Object> userProp = sec.getUserProperties();
		userProp.put("memberId", memberNickname);
		if (chatroomId != null) {
			userProp.put("chatroomId", chatroomId);
		}
	} // modifyHandshake() end
} // class end
