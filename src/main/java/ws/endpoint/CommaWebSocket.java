package ws.endpoint;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

import chat.model.dto.ChatLog;
import chat.model.service.ChatService;
import ws.MessageType;
import ws.config.CommaWebSocketConfigurator;

@ServerEndpoint(value = "/commaWebSocket", configurator = CommaWebSocketConfigurator.class)
public class CommaWebSocket {
	
	private ChatService chatService = new ChatService();
	
	/*
	 * 사용자의 웹소켓 세션을 관리하는 맵
	 * Key - String memberId
	 * Value = Session session
	 * 
	 * 멀티쓰레드환경에서 동기화(각 쓰레드가 사용하는 순서를 지정) 필수
	 * 
	 */
	public static Map<String, Session> clientMap = Collections.synchronizedMap(new HashMap<>());
	
	/**
	 * 채팅방별 사용자 맵
	 * Key - String chatroomId
	 * Value - Set<String> chatMembers
	 */
	public static Map<String, Set<String>> chatParticipantMap = Collections.synchronizedMap(new HashMap<>());
	public void log() {
		System.out.printf("[현재 접속자수 (%d)명] : %s%n", clientMap.size(), clientMap.keySet());
		System.out.printf("[현재 채팅방수 (%d개)] : %s%n", chatParticipantMap.size(), chatParticipantMap);
	}
	
	/**
	 * 채팅방에 사용자 추가
	 * - 처음 채팅방에 입장하는 경우, chatroomId와 사용자Set을 초기화해야 한다.
	 */
	private void addToChatroom(String chatNo, String memberNick) {
		Set<String> participantSet = chatParticipantMap.get(chatNo);
		if(participantSet == null) {
			participantSet = new HashSet<>();
			chatParticipantMap.put(chatNo, participantSet);
		}
		participantSet.add(memberNick);
	}
	
	/**
	 * 채팅방에서 사용자를 제거
	 * - 채팅방에 남은 마지막 사용자를 제거하는 경우, 채팅방까지 제거
	 * @param chatroomId
	 * @param memberId
	 */
	private void removeFromChatroom(String chatNo, String memberNick) {
		Set<String> participantSet = chatParticipantMap.get(chatNo);
		participantSet.remove(memberNick);
		
		// 마지막 사용자인 경우
		if(participantSet.size() == 0) {
			chatParticipantMap.remove(chatNo);
		}
	}
	
	private void sendChatroomEnterMsg(String chatNo, String memberNick, Session session) {

		Map<String, Object> data = new HashMap<>();
		data.put("chatNo", chatNo);
		data.put("sender", memberNick);
		data.put("messageType", MessageType.CHATROOM_ENTER);
		data.put("datetime", System.currentTimeMillis());
		onMessage(new Gson().toJson(data), session);
	}
	
	private void sendChatroomLeaveMsg(String chatNo, String memberNick, Session session) {
		
		Map<String, Object> data = new HashMap<>();
		data.put("chatNo", chatNo);
		data.put("sender", memberNick);
		data.put("messageType", MessageType.CHATROOM_LEAVE);
		data.put("datetime", System.currentTimeMillis());
		onMessage(new Gson().toJson(data), session);
	}

	@OnOpen
	public void onOpen(EndpointConfig config, Session session) {
		System.out.println("CommaWebSocket = 오픈메서드!!!!!!!");
		Map<String, Object> userProp = config.getUserProperties();
		String memberNick = (String) userProp.get("memberNick");
		String chatNo = (String)userProp.get("chatNo");
		
		// 웹소켓 세션 관리 맵에 추가
		clientMap.put(memberNick, session);
		
		// session설정맵에 사용자아이디 추가 (close때 사용)
		Map<String, Object> sessionUserProp = session.getUserProperties();
		sessionUserProp.put("memberNick", memberNick);
		
		if(chatNo != null) {
			sessionUserProp.put("chatNo", chatNo);
			addToChatroom(chatNo, memberNick);
			sendChatroomEnterMsg(chatNo, memberNick, session);
		}
		
		log();
		
	}

	@OnMessage
	public void onMessage(String msg, Session session) {
		System.out.println("msg@OnMessage" + msg);
		
		// json => map
		Map<String, Object> data = new Gson().fromJson(msg, Map.class);
		// ( "messageType" : "CHAT", "message" : "ㅋㅋㅋㅋ", "datatime" : 113123124124, ...)
		String chatNo = (String) data.get("chatNo");
		MessageType messageType = MessageType.valueOf((String)data.get("messageType"));
		
		switch(messageType) {
		case HELLOWORLD :  
			Collection<Session> sessions = clientMap.values(); // 현재 접속중인 웹소켓 세션
			for(Session sess : sessions) {
				Basic basic = sess.getBasicRemote(); // 웹소켓 세션에 출력개체
				try {
					basic.sendText(msg);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			break;
		case CHAT_MSG :
			int chatNum = Integer.valueOf(chatNo);
			String memberNickname = (String) data.get("sender");
			String content = (String) data.get("message");
			ChatLog chatLog = new ChatLog(0, chatNum, memberNickname, content, null, null, null);
			try {
				int result = chatService.insertChatLog(chatLog);
			} catch(Exception e) {
				e.printStackTrace();
			}
			Set<String> participantSet = chatParticipantMap.get(chatNo);
			if(participantSet != null) {
				for(String participant : participantSet) {
					Session sess = clientMap.get(participant);
					Basic basic = sess.getBasicRemote();
					try {
						basic.sendText(msg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case CHATROOM_ENTER : 
			try {
				int result = chatService.enterChatMemmber(Integer.valueOf(chatNo), (String) data.get("sender"));
			} catch(Exception e){
				e.printStackTrace();
			}
			participantSet = chatParticipantMap.get(chatNo);
			if(participantSet != null) {
				for(String participant : participantSet) {
					Session sess = clientMap.get(participant);
					Basic basic = sess.getBasicRemote();
					try {
						basic.sendText(msg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case CHATROOM_LEAVE :
			try {
				int result = chatService.leaveChatMember(Integer.valueOf(chatNo), (String) data.get("sender"));
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			// 채팅방 현재 인원수 조회
			int nowCount = chatService.getNowCount(Integer.valueOf(chatNo));
						
			if(nowCount > 0) {
				participantSet = chatParticipantMap.get(chatNo);
				if(participantSet != null) {
					for(String participant : participantSet) {
						Session sess = clientMap.get(participant);
						Basic basic = sess.getBasicRemote();
						try {
							basic.sendText(msg);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			} else{
				// 채팅방 인원이 0이면 채팅방 제거
				int result = chatService.deleteChat(Integer.valueOf(chatNo));
			}
			break;
		}
	}
	
	@OnError
	public void onError(Throwable e) {
		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session session) {
		System.out.println("CommaWebSocket = 클로즈메서드!!!!!!!");
		Map<String, Object> sessionUserProp = session.getUserProperties();
		String memberNick = (String) sessionUserProp.get("memberNick");
		String chatNo = (String) sessionUserProp.get("chatNo");
		
		// 웹소켓 세션 관리 맵에서 제거
		clientMap.remove(memberNick);
		if(chatNo != null) {
			removeFromChatroom(chatNo, memberNick);
			sendChatroomLeaveMsg(chatNo, memberNick, session);
		}
		
		log();
	}

	

	
}
