package diary.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class DiaryDao {

	private Properties prop = new Properties();
	
	public DiaryDao() {
		String path = DiaryDao.class.getResource("/sql/diary/diary-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	} // DiaryDao() end
	
} // class end
