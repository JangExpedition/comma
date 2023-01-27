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

	public List<Font> selectAllFont(Connection conn) {
		List<Font> fontList = new ArrayList<>();
		String sql = prop.getProperty("selectAllFont");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			while (rset.next()) {
				Font font = new Font();
				font.setNo(rset.getInt("no"));
				font.setName(rset.getString("name"));
				font.setLink(rset.getString("link"));
				fontList.add(font);
			}
		} catch (SQLException e) {
			throw new StyleException("폰트 전체 조회 오류", e);
		}
		return fontList;
	} // selectAllFont() end

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


	public List<Design> selectAllDesign(Connection conn) {
		List<Design> designList = new ArrayList<>();
		String sql = prop.getProperty("selectAllDesign");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			while (rset.next()) {
				Design design = new Design();
				design.setNo(rset.getInt("no"));
				design.setPart(Part.valueOf(rset.getString("part")));
				design.setOriginalFilename(rset.getString("original_filename"));
				design.setRenamedFilename(rset.getString("renamed_filename"));
				design.setRegDate(rset.getDate("reg_date"));
				designList.add(design);
			}
		} catch (SQLException e) {
			throw new StyleException("디자인 전체 조회 오류", e);
		}
		return designList;
	} // selectAllDesign() end

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
