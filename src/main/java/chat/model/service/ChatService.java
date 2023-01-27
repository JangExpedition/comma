package chat.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import chat.model.dao.ChatDao;
import chat.model.dto.Chat;
import chat.model.exception.ChatException;

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
