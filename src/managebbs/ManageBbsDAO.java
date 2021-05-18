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
		String SQL = "SELECT bbsID FROM managebbs ORDER BY bbsID DESC";
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
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO managebbs (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6,1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}


	public ArrayList<ManageBbs> getList(int pageNumber){
		String SQL = "SELECT * FROM managebbs WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10;";
		ArrayList<ManageBbs> list = new ArrayList<ManageBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ManageBbs managebbs = new ManageBbs();
				managebbs.setBbsID(rs.getInt(1));
				managebbs.setBbsTitle(rs.getString(2));
				managebbs.setUserID(rs.getString(3));
				managebbs.setBbsDate(rs.getString(4));
				managebbs.setBbsContent(rs.getString(5));
				managebbs.setBbsAvailable(rs.getInt(6));
				list.add(managebbs);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM managebbs WHERE bbsID < ? AND bbsAvailable = 1";
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


 public ManageBbs getmanagebbs(int bbsID) {
	String SQL = "SELECT * FROM managebbs WHERE bbsID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, bbsID);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			ManageBbs managebbs = new ManageBbs();
			managebbs.setBbsID(rs.getInt(1));
			managebbs.setBbsTitle(rs.getString(2));
			managebbs.setUserID(rs.getString(3));
			managebbs.setBbsDate(rs.getString(4));
			managebbs.setBbsContent(rs.getString(5));
			managebbs.setBbsAvailable(rs.getInt(6));
			return managebbs;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}
 
 	public int update(String bbsTitle, String userID, String bbsContent, String bbsWho, String bbsWhere) {
 		String SQL = "UPDATE managebbs SET bbsTitle =?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, bbsContent);
			pstmt.setString(4, bbsWho);
			pstmt.setString(5, bbsWhere);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
 	
 	public int delete(int bbsID) {
 		String SQL = "UPDATE managebbs SET bbsAvailable = 0 WHERE bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류 		
 	}
}