package notification.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import letter.model.dao.LetterDao;
import notification.model.dto.Notification;
import notification.model.exception.NotificationException;

public class NotificationDao {

	private Properties prop = new Properties();
	
	public NotificationDao() {
		String path = LetterDao.class.getResource("/sql/notification/notification-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // NotificationDao() end

	public int insertNotification(Connection conn, Notification notification) {
		int result = 0;
		String sql = prop.getProperty("insertNotification");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			
			pstmt.setString(1, notification.getMemNick());
			pstmt.setString(2, notification.getMessageType().toString());
			pstmt.setInt(3, notification.getAttachNo());
			pstmt.setString(4, notification.getMessage());
			pstmt.setString(5, notification.getCheckRead().toString());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new NotificationException("알람 발송 오류!", e);
		}
		return result;
	}
}
