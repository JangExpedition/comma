package complain.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import complain.model.dto.Complain;
import complain.model.dto.Partition;
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

	
	public Complain handleComplainResultSet(ResultSet rset) throws SQLException {
		Complain complain = new Complain();
		complain.setNo(rset.getInt("no"));
		complain.setWriter(rset.getString("writer"));
		complain.setVillain(rset.getString("villain"));
		complain.setPartition(Partition.valueOf(rset.getString("partition")));
		complain.setContent(rset.getString("content"));
		complain.setPartitionNo(rset.getInt("partition_no"));
		complain.setWarningCnt(rset.getInt("warning_count"));
		complain.setRegDate(rset.getDate("reg_date"));
		return complain;
	} // handleComplainResultSet() end

	
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

	public List<Complain> selectAllComplain(Connection conn) {
		List<Complain> complainList = new ArrayList<>();
		String sql = prop.getProperty("selectAllComplain");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			while (rset.next()) {
				Complain complain = handleComplainResultSet(rset);
				complainList.add(complain);
			}
		} catch (SQLException e) {
			throw new ComplainException("신고 목록 조회 오류", e);
		}
		return complainList;
	} // selectAllComplain() end

	public List<Complain> selectComplainFind(Connection conn, Map<String, Object> param) {
		List<Complain> complainList = new ArrayList<>();
		String sql = prop.getProperty("selectComplainFind");
		
		String type = (String) param.get("searchType");
		Object keyword = param.get("searchKeyword");
		
		sql = sql.replace("#", type);
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setObject(1, keyword);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next())
					complainList.add(handleComplainResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ComplainException("신고 목록 검색 오류", e);
		}
		return complainList;
	} // slectComplainFind() end
	
}
