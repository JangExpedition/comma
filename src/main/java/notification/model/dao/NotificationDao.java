package notification.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import letter.model.dao.LetterDao;

public class NotificationDao {

	private Properties prop = new Properties();
	
	public NotificationDao() {
		String path = LetterDao.class.getResource("/sql/letter/letter-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // NotificationDao() end
}
