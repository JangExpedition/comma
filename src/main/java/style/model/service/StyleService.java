package style.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import style.model.dao.StyleDao;
import style.model.dto.Design;
import style.model.dto.Font;

public class StyleService {

	private StyleDao styleDao = new StyleDao();

	public List<Font> selectAllFont() {
		Connection conn = getConnection();
		List<Font> fontList = styleDao.selectAllFont(conn);
		close(conn);
		return fontList;
	} // selectAllFont() end

	public List<Font> selectFindFont(String searchKeyword) {
		Connection conn = getConnection();
		List<Font> fontList = styleDao.selectFindFont(conn, searchKeyword);
		close(conn);
		return fontList;
	} // selectFindFont() end
	
	public int insertFont(Font font) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = styleDao.insertFont(conn, font);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	} // insertFont() end
	
	public int updateFont(Font font) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = styleDao.updateFont(conn, font);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	} // updateFont() end

	
	public List<Design> selectAllDesign() {
		Connection conn = getConnection();
		List<Design> designList = styleDao.selectAllDesign(conn);
		close(conn);
		return designList;
	} // selectAllDesign() end

	public List<Design> selectFindDesign(String searchKeyword) {
		Connection conn = getConnection();
		List<Design> designList = styleDao.selectFindDesign(conn, searchKeyword);
		close(conn);
		return designList;
	} // selectFindDesign() end
	
	public int insertDesign(Design design) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = styleDao.insertDesign(conn, design);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	} // insertDesign() end
	
	public int updateDesign(Design design) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = styleDao.updateDesign(conn, design);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	} // updateDesign() end
	
}
