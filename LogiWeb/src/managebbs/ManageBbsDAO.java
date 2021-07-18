package managebbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ManageBbsDAO {

		private Connection conn;
		private ResultSet rs;
		
		public ManageBbsDAO() {
			try {
				String dbURL = "jdbc:mysql://logismart.cafe24.com/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
				String dbID = "logismart";
				String dbPassword = "Logi2017253012";
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	public int getNext() {
		String SQL = "SELECT bbs_num FROM managebbs ORDER BY bbs_num ASC";
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
	

	public ArrayList<ManageBbs> getList(String searchType, String search, int pageNumber){
		//String SQL = "SELECT * FROM probbs WHERE proID < ? AND proAvailable = 1 ORDER BY proID DESC LIMIT 10";
		if(searchType.equals("전체")) searchType ="";
		String SQL = "";
		ArrayList<ManageBbs> list = new ArrayList<ManageBbs>();
		try {
			if(searchType.equals("물품이름")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_name LIKE ? ORDER BY bbs_num ASC LIMIT "+ pageNumber*10 +", " + pageNumber*10+11;
			}else if(searchType.equals("담당운반자")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_carrierID LIKE ? ORDER BY bbs_num ASC LIMIT " + pageNumber*10 +", " + pageNumber*10+11;
			}else {
				SQL = "SELECT * FROM managebbs WHERE CONCAT(bbs_manager,bbs_start,bbs_arrival) LIKE ? ORDER BY bbs_num ASC LIMIT "	+ pageNumber*10 +", " + pageNumber*10+11;
			}
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ManageBbs managebbs = new ManageBbs();
				managebbs.setBbs_num(rs.getInt(1));
				managebbs.setBbs_name(rs.getString(2));
				managebbs.setBbs_manager(rs.getString(3));
				managebbs.setBbs_carrierID(rs.getInt(4));
				managebbs.setBbs_start(rs.getString(5));
				managebbs.setBbs_arrival(rs.getString(6));
				managebbs.setBbs_upper(rs.getInt(7));
				managebbs.setBbs_lower(rs.getInt(8));
				list.add(managebbs);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM managebbs WHERE bbs_num < ?";
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


 public ManageBbs getmanageBbs(int bbs_num) {
	String SQL = "SELECT * FROM managebbs LEFT OUTER JOIN carriers ON bbs_num = c_id WHERE bbs_num = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, bbs_num);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			ManageBbs managebbs = new ManageBbs();
			managebbs.setBbs_num(rs.getInt(1));
			managebbs.setBbs_name(rs.getString(2));
			managebbs.setBbs_manager(rs.getString(3));
			managebbs.setBbs_carrierID(rs.getInt(4));
			managebbs.setBbs_start(rs.getString(5));
			managebbs.setBbs_arrival(rs.getString(6));
			managebbs.setBbs_upper(rs.getInt(7));
			managebbs.setBbs_lower(rs.getInt(8));
			return managebbs;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}

 	public int update(int bbs_num, int bbs_carrierID) {
 		String SQL = "UPDATE managebbs SET bbs_carrierID =?  WHERE bbs_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbs_carrierID);
			pstmt.setInt(2, bbs_num);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
	public int delete(int bbs_num) {
 		String SQL = "delete from managebbs where bbs_num =?";
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