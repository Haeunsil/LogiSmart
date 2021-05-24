package managebbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ManageBbsDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		public ManageBbsDAO() {
			try {
				String dbURL = "jdbc:mysql://localhost/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
				String dbID = "logismart";
				String dbPassword = "Logi2017253012";
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
		
	public int getNext() {
		String SQL = "SELECT bbs_num FROM managebbs ORDER BY bbs_num DESC";
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
	
	public int write(String bbs_name, String bbs_manager, String bbs_start, String bbs_arrival) {
		String SQL = "INSERT INTO managebbs (bbs_num, bbs_name, bbs_manager, bbs_start, bbs_arrival) VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbs_name);
			pstmt.setString(3, bbs_manager);
			pstmt.setString(4, bbs_start);
			pstmt.setString(5, bbs_arrival);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}


	public ArrayList<ManageBbs> getList(int pageNumber){
		String SQL = "SELECT * FROM managebbs WHERE bbs_num < ?  ORDER BY bbs_num DESC LIMIT 10;";
		ArrayList<ManageBbs> list = new ArrayList<ManageBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ManageBbs managebbs = new ManageBbs();
				managebbs.setBbs_num(rs.getInt(1));
				managebbs.setBbs_name(rs.getString(2));
				managebbs.setBbs_manager(rs.getString(3));
				managebbs.setBbs_start(rs.getString(4));
				managebbs.setBbs_arrival(rs.getString(5));
				list.add(managebbs);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM managebbs WHERE bbs_num < ? ";
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


 public ManageBbs getmanagebbs(int bbs_num) {
	String SQL = "SELECT * FROM managebbs WHERE bbs_num = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, bbs_num);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			ManageBbs managebbs = new ManageBbs();
			managebbs.setBbs_num(rs.getInt(1));
			managebbs.setBbs_name(rs.getString(2));
			managebbs.setBbs_manager(rs.getString(3));
			managebbs.setBbs_start(rs.getString(4));
			managebbs.setBbs_arrival(rs.getString(5));
			return managebbs;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}
 
 	public int update(String bbs_name, String bbs_manager, String bbs_start, String bbs_arrival) {
 		String SQL = "UPDATE managebbs SET bbsTitle =?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbs_name);
			pstmt.setString(2, bbs_manager);
			pstmt.setString(3, bbs_start);
			pstmt.setString(4, bbs_arrival);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
 	
 	public int delete(int bbs_num) {
 		String SQL = "UPDATE managebbs WHERE bbs_num =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbs_num);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류 		
 	}
}