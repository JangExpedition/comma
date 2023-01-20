package letter.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import letter.model.dao.LetterDao;
import letter.model.dto.Letter;

public class LetterService {

	private LetterDao letterDao = new LetterDao();

	public List<Letter> selectAllLetter(String nickname) {
		Connection conn = getConnection();
		List<Letter> letterList = letterDao.selectAllLetter(conn, nickname);
		close(conn);
		return letterList;
	} // selectAllLetter() end
	
} // class end
