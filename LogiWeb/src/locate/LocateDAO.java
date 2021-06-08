package locate;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class LocateDAO {

		private Connection conn;
		private ResultSet rs;
		
		public LocateDAO() {
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
		String SQL = "SELECT l_id FROM locate ORDER BY l_id ASC";
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
	

	public ArrayList<Locate> getList(String searchType, String search, int pageNumber){
		if(searchType.equals("전체")) searchType ="";
		String SQL = "";
		ArrayList<Locate> list = new ArrayList<Locate>();
		try {
			/*
			if(searchType.equals("물품이름")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_name LIKE ? ORDER BY bbs_num DESC LIMIT "+ pageNumber*10 +", " + pageNumber*10+11;
			}else if(searchType.equals("담당운반자")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_carrierID LIKE ? ORDER BY bbs_num DESC LIMIT " + pageNumber*10 +", " + pageNumber*10+11;
			}else {
				SQL = "SELECT * FROM managebbs WHERE CONCAT(bbs_manager,bbs_start,bbs_arrival) LIKE ? ORDER BY bbs_num DESC LIMIT "	+ pageNumber*10 +", " + pageNumber*10+11;
			}
			*/
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			pstmt.setString(1, "%" + search + "%");
			System.out.println("bbsDAO========================> "+ getNext());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Locate locate = new Locate();
				locate.setL_id(rs.getInt(1));
				locate.setL_wido(rs.getString(2));
				locate.setL_gyeongdo(rs.getString(3));
				locate.setL_time(rs.getString(4));
				list.add(locate);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM locate WHERE l_id < ?";
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


 public Locate getLocate(int l_id) {
	String SQL = "SELECT * FROM locate WHERE l_id = ? order by l_time desc";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, l_id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Locate locate = new Locate();
			locate.setL_id(rs.getInt(1));
			locate.setL_wido(rs.getString(2));
			locate.setL_gyeongdo(rs.getString(3));
			locate.setL_time(rs.getString(4));
			return locate;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}

}