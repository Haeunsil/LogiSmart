package manager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;




public class ManagerDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ManagerDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "logismart";
			String dbPassword = "Logi2017253012";

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String m_ID, String m_Password) {
		String SQL = "SELECT m_Password FROM manager WHERE m_ID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, m_ID);
			rs = pstmt.executeQuery();
			
			/* 컬럼 갯수 구해보기 시작 */
			ResultSetMetaData rsmd;
			rsmd = (ResultSetMetaData) rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			System.out.println("==================>"+ cnt);
			/* 컬럼 갯수 구해보기 끝 */
			
			if (rs.next()) {
				if(rs.getString(1).equals(m_Password))
					return 1; //로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(Manager manager) {
		String SQL = "INSERT INTO manager (m_ID, m_Password, m_Name, m_Gender, m_Phone) VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, manager.getm_ID());
			pstmt.setString(2, manager.getm_Password());
			pstmt.setString(3, manager.getm_Name());
			pstmt.setString(4, manager.getm_Gender());
			pstmt.setString(5, manager.getm_Phone());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}


	public int getNext() {
		String SQL = "SELECT m_ID FROM manager ORDER BY m_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
	}
	
	public ArrayList<Manager> getList(int pageNumber){
		String SQL = "SELECT * FROM manager WHERE m_ID < ? ORDER BY m_ID DESC LIMIT 10;";
		ArrayList<Manager> list = new ArrayList<Manager>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Manager manager = new Manager();
				manager.setm_ID(rs.getString(1));
				manager.setm_Password(rs.getString(2));
				manager.setm_Name(rs.getString(3));
				manager.setm_Gender(rs.getString(4));
				manager.setm_Phone(rs.getString(5));
				list.add(manager);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스오류
	}

	
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM manager WHERE m_ID < ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;		
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; //데이터베이스오류
	}


 public Manager getmanager(int m_ID) {
	String SQL = "SELECT * FROM manager WHERE m_ID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, m_ID);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Manager manager = new Manager();
			manager.setm_ID(rs.getString(1));
			manager.setm_Password(rs.getString(2));
			manager.setm_Name(rs.getString(3));
			manager.setm_Gender(rs.getString(4));
			manager.setm_Phone(rs.getString(5));
			return manager;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}
 

 	public int delete(int m_ID) {
 		String SQL = "UPDATE manager SET WHERE m_ID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, m_ID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류 		
 	}
}
	
