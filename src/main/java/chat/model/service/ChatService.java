package chat.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

import chat.model.dao.ChatDao;
import chat.model.dto.Chat;
import chat.model.dto.ChatMember;
import common.Attachment;

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

	public int insertChatLog(Map<String, Object> data) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = chatDao.insertChatLog(conn, data);
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
