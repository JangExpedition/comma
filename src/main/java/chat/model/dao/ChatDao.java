package chat.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import member.model.dao.MemberDao;

public class ChatDao {

	Properties prop = new Properties();
	
	public ChatDao() {
		String path = MemberDao.class.getResource("/sql/counseling/chat-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
