package chat.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import chat.model.dto.Chat;
import chat.model.exception.ChatException;
import member.model.dao.MemberDao;
import member.model.dto.Gender;

public class ChatDao {

	Properties prop = new Properties();
	
	public ChatDao() {
		String path = MemberDao.class.getResource("/sql/chat/chat-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Chat> selectAllChat(Connection conn) {
		List<Chat> chatList = new ArrayList<>();
		String sql = prop.getProperty("selectAllChat");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Chat chat = new Chat();
					chat.setNo(rset.getInt("no"));
					chat.setChatName(rset.getString("name"));
					chat.setCaptin(rset.getString("captin"));
					chat.setAbleGender(Gender.valueOf(rset.getString("able_gender")));
					chat.setAbleAge(rset.getInt("able_age"));
					chat.setAbleCount(rset.getInt("able_count"));
					chat.setRegDate(rset.getDate("reg_date"));
					
					chatList.add(chat);
				}
			}
		} catch (SQLException e) {
			throw new ChatException("채팅목록 불러오기 오류!", e);
		}
		return chatList;
	}

	public int insertChat(Connection conn, Chat chat) {
		int result = 0;
		String sql = prop.getProperty("insertChat");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, chat.getChatName());
			pstmt.setString(2, chat.getCaptin());
			pstmt.setString(3, chat.getAbleGender().toString());
			pstmt.setInt(4, chat.getAbleAge());
			pstmt.setInt(5, chat.getAbleCount());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ChatException("채팅방 개설오류!", e);
		}
		return result;
	}

	public int selectLastChatNo(Connection conn) {
		int chatNo = 0;
		String sql = prop.getProperty("selectLastChatNo");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return chatNo;
	}

}
