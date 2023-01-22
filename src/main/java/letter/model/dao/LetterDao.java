package letter.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import common.OX;
import letter.model.dto.Letter;
import letter.model.exception.LetterException;

public class LetterDao {

	private Properties prop = new Properties();
	
	public LetterDao() {
		String path = LetterDao.class.getResource("/sql/letter/letter-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // LetterDao() end

	
	public Letter handleLetterResultSet(ResultSet rset) throws SQLException {
		Letter letter = new Letter();
		letter.setNo(rset.getInt("no"));
		letter.setWriter(rset.getString("writer"));
		letter.setAddressee(rset.getString("addressee"));
		letter.setDesignNo(rset.getInt("design_no"));
		letter.setFontNo(rset.getInt("font_no"));
		letter.setContent(rset.getString("content"));
		letter.setRegDate(rset.getDate("reg_date"));
		letter.setRead_check(OX.valueOf(rset.getString("read_check")));
		letter.setAnonymous(OX.valueOf(rset.getString("anonymous")));
		return letter;
	} // handleLetterResultSet() end

	
	public List<Letter> selectAllLetter(Connection conn, String nickname) {
		String sql = prop.getProperty("selectAllLetter");
		List<Letter> letterList = new ArrayList<>();
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nickname);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next()) {
					letterList.add(handleLetterResultSet(rset));
				} // while() end
			}
		} catch (SQLException e) {
			throw new LetterException("편지 조회 오류", e);
		}
		return letterList;
	} // selectAllLetter() end
	
} // class end
