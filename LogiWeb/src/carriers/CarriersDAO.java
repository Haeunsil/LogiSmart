package carriers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CarriersDAO {

		private Connection conn;
		private ResultSet rs;
		
		public CarriersDAO() {
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
		String SQL = "SELECT c_id FROM carriers ORDER BY c_id DESC";
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
	

	public ArrayList<Carriers> getList(String searchType, String search, int pageNumber){
		if(searchType.equals("전체")) searchType ="";
		String SQL = "";
		ArrayList<Carriers> list = new ArrayList<Carriers>();
		try {
			/*
			if(searchType.equals("물품이름")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_name LIKE ? ORDER BY bbs_num DESC LIMIT "+ pageNumber*10 +", " + pageNumber*10+11;
			}else if(searchType.equals("담당운반자")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_carriersID LIKE ? ORDER BY bbs_num DESC LIMIT " + pageNumber*10 +", " + pageNumber*10+11;
			}else {
				SQL = "SELECT * FROM managebbs WHERE CONCAT(bbs_manager,bbs_start,bbs_arrival) LIKE ? ORDER BY bbs_num DESC LIMIT "	+ pageNumber*10 +", " + pageNumber*10+11;
			}
			*/
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Carriers carriers = new Carriers();
				carriers.setC_id(rs.getInt(1));
				carriers.setC_name(rs.getString(2));
				carriers.setC_birth(rs.getString(3));
				list.add(carriers);					
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM carriers WHERE c_id < ?";
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


 public Carriers getCarriers (int c_id) {
	String SQL = "SELECT * FROM carriers WHERE c_id = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, c_id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Carriers carriers = new Carriers();
			carriers.setC_id(rs.getInt(1));
			carriers.setC_name(rs.getString(2));
			carriers.setC_birth(rs.getString(3));
			carriers.setC_phone(rs.getString(4));
			return carriers;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}
 
 public Carriers UngetCarriers (int c_id) {
	String SQL = "select * from carriers LEFT OUTER JOIN managebbs ON c_id = bbs_carrierID where bbs_carrierID is null";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, c_id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Carriers carriers = new Carriers();
			carriers.setC_id(rs.getInt(1));
			carriers.setC_name(rs.getString(2));
			carriers.setC_birth(rs.getString(3));
			carriers.setC_phone(rs.getString(4));
			return carriers;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}
	public int delete(int c_id) {
 		String SQL = "delete from carriers where c_id =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, c_id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류 		
 	}

}