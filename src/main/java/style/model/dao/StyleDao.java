package style.model.dao;

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

import style.model.dto.Design;
import style.model.dto.Font;
import style.model.dto.Part;
import style.model.exception.StyleException;


public class StyleDao {

	private Properties prop = new Properties();
	
	public StyleDao() {
		String path = StyleDao.class.getResource("/sql/style/style-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // FontDao() end

	public Font handleFontResultSet(ResultSet rset) throws SQLException {
		Font font = new Font();
		font.setNo(rset.getInt("no"));
		font.setRnum(rset.getInt("rnum"));
		font.setName(rset.getString("name"));
		font.setLink(rset.getString("link"));
		return font;
	} // handleFontResultSet() end

	public List<Font> selectAllFont(Connection conn) {
		List<Font> fontList = new ArrayList<>();
		String sql = prop.getProperty("selectAllFont");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			while (rset.next())
				fontList.add(handleFontResultSet(rset));
		} catch (SQLException e) {
			throw new StyleException("폰트 전체 조회 오류", e);
		}
		return fontList;
	} // selectAllFont() end

	public List<Font> selectFindFont(Connection conn, String searchKeyword) {
		List<Font> fontList = new ArrayList<>();
		String sql = prop.getProperty("selectFindFont");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, searchKeyword);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next())
					fontList.add(handleFontResultSet(rset));
			}
		} catch (SQLException e) {
			throw new StyleException("폰트 목록 검색 오류", e);
		}
		return fontList;
	} // selectFindFont() end

	public int insertFont(Connection conn, Font font) {
		int result = 0;
		String sql = prop.getProperty("insertFont");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, font.getName());
			pstmt.setString(2, font.getLink());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new StyleException("폰트 추가 오류", e);
		}
		return result;
	} // insertFont() end

	public int updateFont(Connection conn, Font font) {
		int result = 0;
		String sql = prop.getProperty("updateFont");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, font.getName());
			pstmt.setString(2, font.getLink());
			pstmt.setInt(3, font.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new StyleException("폰트 수정 오류", e);
		}
		return result;
	} // updateFont() end

	
	public Design handleDesignResultSet(ResultSet rset) throws SQLException {
		Design design = new Design();
		design.setNo(rset.getInt("no"));
		design.setRnum(rset.getInt("rnum"));
		design.setPart(Part.valueOf(rset.getString("part")));
		design.setOriginalFilename(rset.getString("original_filename"));
		design.setRenamedFilename(rset.getString("renamed_filename"));
		design.setRegDate(rset.getDate("reg_date"));
		return design;
	} // handleDesignResultSet() end

	public List<Design> selectAllDesign(Connection conn) {
		List<Design> designList = new ArrayList<>();
		String sql = prop.getProperty("selectAllDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			while (rset.next())
				designList.add(handleDesignResultSet(rset));
		} catch (SQLException e) {
			throw new StyleException("디자인 전체 조회 오류", e);
		}
		return designList;
	} // selectAllDesign() end

	public Design selectOneDesign(Connection conn, int no) {
		Design design = null;
		String sql = prop.getProperty("selectOneDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, no);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next())
					design = handleDesignResultSet(rset);
			}
		} catch (SQLException e) {
			throw new StyleException("디자인 한 건 조회 오류", e);
		}
		return design;
	} // selectOneDesign() end

	public List<Design> selectFindDesign(Connection conn, String searchKeyword) {
		List<Design> designList = new ArrayList<>();
		String sql = prop.getProperty("selectFindDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, searchKeyword);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next())
					designList.add(handleDesignResultSet(rset));
			}
		} catch (SQLException e) {
			throw new StyleException("디자인 목록 검색 오류", e);
		}
		return designList;
	} // selectFindDesign() end

	public int insertDesign(Connection conn, Design design) {
		int result = 0;
		String sql = prop.getProperty("insertDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, design.getPart().name());
			pstmt.setString(2, design.getOriginalFilename());
			pstmt.setString(3, design.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new StyleException("디자인 추가 오류", e);
		}
		return result;
	} // insertDesign() end

	public int updateDesign(Connection conn, Design design) {
		int result = 0;
		String sql = prop.getProperty("updateDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, design.getPart().name());
			pstmt.setString(2, design.getOriginalFilename());
			pstmt.setString(3, design.getRenamedFilename());
			pstmt.setInt(4, design.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new StyleException("디자인 수정 오류", e);
		}
		return result;
	} // updateDesign() end

}
