package letter.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import common.Attachment;
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

	public int insertLetter(Letter letter) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// 편지 전송
			result = letterDao.insertLetter(conn, letter);
			
			// 방금 전송된 편지의 no컬럼 값 가져오기
			int letterNo = letterDao.selectLastLetterNo(conn);
			System.out.println("letterNo = " + letterNo);
			
			letter.setNo(letterNo);
			
			// 첨부파일 등록
			List<Attachment> letterAttach = letter.getAttachments();
			if (!letterAttach.isEmpty()) {
				for (Attachment attach : letterAttach) {
					attach.setAttachNo(letterNo);
					result = letterDao.insertAttachment(conn, attach);
				}
			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // insertLetter() end

	public Letter selectOneLetter(int letterNo) {
		Connection conn = getConnection();
		
		Letter letter = letterDao.selectOneLetter(conn, letterNo);
		List<Attachment> attachList = letterDao.selectAllAttachment(conn, letterNo);
		
		letter.setAttachments(attachList);
		
		close(conn);
		return letter;
	} // selectOneLetter() end
	
} // class end
