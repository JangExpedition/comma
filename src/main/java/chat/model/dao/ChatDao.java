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
import chat.model.dto.ChatLog;
import chat.model.dto.ChatMember;
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
			try(ResultSet rset = pstmt.executeQuery()){
				if (rset.next())
					chatNo = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new ChatException("채팅방 번호 불러오기 오류!");
		}
		return chatNo;
	}

	public int insertChatMember(Connection conn, ChatMember chatmem) {
		int result = 0;
		String sql = prop.getProperty("insertChatMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			int chatNo = chatmem.getChatNo();
			String nickname = chatmem.getNickname();
			
			pstmt.setInt(1, chatNo);
			pstmt.setString(2, nickname);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new ChatException("채팅방 멤버추가 오류!");
		}
		return result;
	}
	
	public int insertChatMember(Connection conn, int chatNo, String memberNick) {
		int result = 0;
		String sql = prop.getProperty("insertChatMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			pstmt.setString(2, memberNick);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new ChatException("채팅방 멤버추가 오류!");
		}
		return result;
	}

	public int insertChatLog(Connection conn, ChatLog chatLog) {
		int result = 0;
		String sql = prop.getProperty("insertChatLog");
		System.out.println("ChatDao.insertChatLog = " + chatLog);
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatLog.getChatNo());
			pstmt.setString(2, chatLog.getMemberNick());
			pstmt.setString(3, chatLog.getContent());
			pstmt.setString(4, chatLog.getOriginalFilename());
			pstmt.setString(5, chatLog.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ChatException("채팅방 로그추가 오류!", e);
		}
		return result;
	}
	
	public int upNowCntChat(Connection conn, int chatNo) {
		int result = 0;
		String sql = prop.getProperty("upNowCntChat");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ChatException("채팅방 인원 카운트 업 오류!", e);
		}
		return result;
	}

	public int downNowCntChat(Connection conn, int chatNo) {
		int result = 0;
		String sql = prop.getProperty("downNowCntChat");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ChatException("채팅방 인원 카운트 다운 오류!", e);
		}
		return result;
	}

	public int updateChatMemEndDate(Connection conn, int chatNo, String memberNick) {
		int result = 0;
		String sql = prop.getProperty("updateChatMemEndDate");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			pstmt.setString(2, memberNick);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ChatException("채팅멤버 나간시간 지정오류!", e);
		}
		return result;
	}

	public int getNowCount(Connection conn, int chatNo) {
		int nowCount = 0;
		String sql = prop.getProperty("getNowCount");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					nowCount = rset.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new ChatException("채팅방 현재인원 조회오류!", e);
		}
		return nowCount;
	}

	public int deleteChat(Connection conn, int chatNo) {
		int result = 0;
		String sql = prop.getProperty("deleteChat");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, chatNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new ChatException("채팅방 현재인원 조회오류!", e);
		}
		return result;
	}

}
