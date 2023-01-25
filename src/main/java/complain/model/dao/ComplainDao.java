package complain.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import complain.model.dto.Complain;
import complain.model.exception.ComplainException;
import letter.model.dao.LetterDao;

public class ComplainDao {

	private Properties prop = new Properties();
	
	public ComplainDao() {
		String path = LetterDao.class.getResource("/sql/complain/complain-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // ComplainDao() end

	public int insertComplain(Connection conn, Complain complain) {
		int result = 0;
		String sql = prop.getProperty("insertComplain");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, complain.getWriter());
			pstmt.setString(2, complain.getVillain());
			pstmt.setString(3, complain.getPartition().name());
			pstmt.setString(4, complain.getContent());
			pstmt.setInt(5, complain.getPartitionNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ComplainException("신고 내역 등록 오류", e);
		}
		return result;
	} // insertComplain() end
	
}
