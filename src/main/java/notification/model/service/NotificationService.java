package notification.model.service;

import static common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import common.CommaUtils;
import common.OX;
import counseling.model.dto.Counseling;
import letter.model.dto.Letter;
import notification.model.dao.NotificationDao;
import notification.model.dto.Notification;
import ws.MessageType;

public class NotificationService {

	private NotificationDao notificationDao = new NotificationDao();
	
	public void notifyNewComment(Counseling counseling) {
		Connection conn = getConnection();
		String writer = counseling.getWriter();
		int attachNo = counseling.getNo();
		String message = "[" + counseling.getTitle() + "] 게시글에 새 댓글이 달렸습니다.";
		MessageType messageType = MessageType.NOTIFY_NEW_COMMENT;
		
		Notification notification = new Notification(0, writer, messageType, attachNo, message, null, OX.X);
		int result = notificationDao.insertNotification(conn, notification);
		
		if(CommaUtils.isConnected(writer)) {
			Map<String, Object> data = new HashMap<>();
			data.put("receiver", writer);
			data.put("messageType", messageType);
			data.put("message", message);
			data.put("datetime", System.currentTimeMillis());
			CommaUtils.sendNotification(writer, data);
		}
	}
	
	public void notifyNewLetter(Letter letter) {
		Connection conn = getConnection();
		String addressee = letter.getAddressee();
		int attachNo = letter.getNo();
		String message = "[" + ( letter.getAnonymous() == OX.X ? letter.getWriter() : "익명") + "] 새로운 편지가 도착했습니다.";
		MessageType messageType = MessageType.NOTIFY_NEW_COMMENT;
		
		Notification notification = new Notification(0, addressee, messageType, attachNo, message, null, OX.X);
		
		int result = notificationDao.insertNotification(conn, notification);
		
		if (CommaUtils.isConnected(addressee)) {
			Map<String, Object> data = new HashMap<>();
			data.put("receiver", addressee);
			data.put("messageType", messageType);
			data.put("message", message);
			data.put("datatime", System.currentTimeMillis());
			CommaUtils.sendNotification(addressee, data);
		} // if() end
	} // notifyNewLetter() end
}
