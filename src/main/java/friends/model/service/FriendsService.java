package friends.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

import friends.model.dao.FriendsDao;
import friends.model.dto.Friends;

public class FriendsService {

	private FriendsDao friendsDao = new FriendsDao();

	public List<Friends> selectAllFriends(String nickname) {
		Connection conn = getConnection();
		List<Friends> friendsList = friendsDao.selectAllFriends(conn, nickname);
		close(conn);
		return friendsList;
	} // selectAllFriends() end

	public List<Friends> searchFriends(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Friends> friendsList = friendsDao.searchFriends(conn, param);
		close(conn);
		return friendsList;
	} // searchFriends() end

	public int insertFriend(Friends friends) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = friendsDao.insertFriend(conn, friends);
			
			int lastFNo = friendsDao.getLastFNo(conn);
			
			friends.setNo(lastFNo);
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Friends> selectReceiveFriends(String nickname) {
		Connection conn = getConnection();
		List<Friends> receiveFriendsList = friendsDao.selectReceiveFriends(conn, nickname);
		close(conn);
		return receiveFriendsList;
	} // selectReceiveFriends() end
	
	public int updateIsFriend(Friends friend) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = friendsDao.updateIsFriend(conn, friend);
			result = friendsDao.insertFriend(conn, friend);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // updateIsFriend() end

	public int deleteFriend(Friends friend) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = friendsDao.deleteFriend(conn, friend);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // deleteFriend() end
	
} // class
