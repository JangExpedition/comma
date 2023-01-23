package common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JdbcTemplate {

	static String driverClass;
	static String url;
	static String user;
	static String password;
	
	// 초기화 블럭
	static {
		
		driverClass = "oracle.jdbc.OracleDriver";
		url = "jdbc:oracle:thin:@KEKYC3K85TBQ8DZ9_high?TNS_ADMIN=C:\\Users\\doffl\\Desktop\\세미프로젝트\\Wallet_KEKYC3K85TBQ8DZ9";
		user = "ADMIN";
		password = "Tnlavytnlavy1!";
		
		
		try {
			// 프로그램 실행 시 최초 1회만 처리
			Class.forName(driverClass);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	} // static 초기화 블럭 end
	
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	} // getConnection() end
	
	
	public static void commit(Connection conn) {
		try {
			if (conn != null && !conn.isClosed())
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // commit() end
	
	
	public static void rollback(Connection conn) {
		try {
			if (conn != null && !conn.isClosed())
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // rollback() end
	
	public static void close(Connection conn) {
		try {
			if (conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // close(conn) end
	
	
	public static void close(Statement stmt) {
		try {
			if (stmt != null && !stmt.isClosed())
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // close(stmt) end
	
	
	public static void close(ResultSet rset) {
		try {
			if (rset != null && !rset.isClosed())
				rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // close(rset) end
	
} // class end
