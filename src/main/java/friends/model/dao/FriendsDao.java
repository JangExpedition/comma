package friends.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

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
	
	
	
} // class end
