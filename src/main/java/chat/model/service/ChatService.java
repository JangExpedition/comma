package chat.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import chat.model.dao.ChatDao;
import chat.model.dto.Chat;
import chat.model.dto.ChatLog;
import chat.model.dto.ChatMember;

public class ChatService {
	private ChatDao chatDao = new ChatDao();

	public List<Chat> selectAllChat() {
		Connection conn = getConnection();
		List<Chat> chatList = chatDao.selectAllChat(conn);
		close(conn);
		return chatList;
	}

	public int insertChat(Chat chat) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.insertChat(conn, chat);
			
			int chatNo = chatDao.selectLastChatNo(conn);
			
			chat.setNo(chatNo);
			
			List<ChatMember> chatMembers = chat.getChatMembers();
			if (!chatMembers.isEmpty()) {
				for (ChatMember chatmem : chatMembers) {
					chatmem.setChatNo(chatNo);
					result = chatDao.insertChatMember(conn, chatmem);
				}
			}
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int insertChatLog(ChatLog chatLog) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.insertChatLog(conn, chatLog);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int leaveChatMember(int chatNo, String memberNick) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.downNowCntChat(conn, chatNo);
			
			result = chatDao.updateChatMemEndDate(conn, chatNo, memberNick);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int enterChatMemmber(int chatNo, String memberNick) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.upNowCntChat(conn, chatNo);
			
			result = chatDao.insertChatMember(conn, chatNo, memberNick);
			
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int getNowCount(int chatNo) {
		int nowCount = 0;
		Connection conn = getConnection();
		try {
			nowCount = chatDao.getNowCount(conn, chatNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return nowCount;
	}

	public int deleteChat(int chatNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.deleteChat(conn, chatNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
