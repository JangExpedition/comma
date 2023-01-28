package friends.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import common.OX;
import friends.model.dto.Friends;
import friends.model.exception.FriendsException;

public class FriendsDao {

	private Properties prop = new Properties();
	
	public FriendsDao() {
		String path = FriendsDao.class.getResource("/sql/friends/friends-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // FriendsDao() end
	
	
	public Friends handleFriendsResultSet(ResultSet rset) throws SQLException {
		Friends friends = new Friends();
		friends.setNo(rset.getInt("no"));
		friends.setMyNickname(rset.getString("my_nickname"));
		friends.setfNickname(rset.getString("f_nickname"));
		friends.setIsFriend(OX.valueOf(rset.getString("is_friend")));
		friends.setOriginalFileName(rset.getString("original_filename"));
		friends.setRenamedFileName(rset.getString("renamed_filename"));
		return friends;
	} // handleFriendsResultSet() end

	
	public List<Friends> selectAllFriends(Connection conn, String nickname) {
		List<Friends> friendsList = new ArrayList<>();
		String sql = prop.getProperty("selectAllFriends");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nickname);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next())
					friendsList.add(handleFriendsResultSet(rset));
			}
		} catch (SQLException e) {
			throw new FriendsException("친구 목록 조회 오류", e);
		}
		
		return friendsList;
	} // selectAllFriends() end

	
	public List<Friends> searchFriends(Connection conn, Map<String, Object> param) {
		List<Friends> friendsList = new ArrayList<>();
		String sql = prop.getProperty("searchFriends");
		String nickname = (String) param.get("nickname");
		String searchNick = (String) param.get("searchNick");
		System.out.println("sql = " + sql);
		System.out.println("nickname = " + nickname);
		System.out.println("searchNick = " + searchNick);
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nickname);
			pstmt.setString(2, '%' + searchNick + '%');
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next())
					friendsList.add(handleFriendsResultSet(rset));
			}
		} catch (SQLException e) {
			throw new FriendsException("친구 목록 검색 오류", e);
		}
		
		return friendsList;
	} // searchFriends() end


	public int insertFriend(Connection conn, Friends friends) {
		int result = 0;
		String sql = prop.getProperty("insertFriend");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, friends.getMyNickname());
			pstmt.setString(2, friends.getfNickname());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FriendsException("친구등록 오류!", e);
		}
		return result;
	}


	public int getLastFNo(Connection conn) {
		int lastNo = 0;
		String sql = prop.getProperty("getLastFNo");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					lastNo = rset.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new FriendsException("친구번호 조회오류", e);
		}
		return lastNo;
	}
	
} // class end
