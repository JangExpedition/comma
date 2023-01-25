package notification.model.service;

import java.util.HashMap;
import java.util.Map;

import common.CommaUtils;
import common.OX;
import letter.model.dto.Letter;
import notification.model.dao.NotificationDao;
import ws.MessageType;

public class NotificationService {

	private NotificationDao notificationDao = new NotificationDao();
	
	public void notifyNewLetter(Letter letter) {
		// db 저장
		
		// 실시간 알림
		String addressee = letter.getAddressee();
		if (CommaUtils.isConnected(addressee)) {
			Map<String, Object> data = new HashMap<>();
			data.put("receiver", addressee);
			data.put("messageType", MessageType.NOTIFY_NEW_LETTER);
			data.put("message", "[" + ( letter.getAnonymous() == OX.X ? letter.getWriter() : "익명") + "] 새로운 편지가 도착했습니다.");
			data.put("datatime", System.currentTimeMillis());
			CommaUtils.sendNotification(addressee, data);
		} // if() end
	} // notifyNewLetter() end
}
