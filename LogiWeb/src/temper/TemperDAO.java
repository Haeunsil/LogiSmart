package temper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TemperDAO {

		private Connection conn;
		private ResultSet rs;
		
		public TemperDAO() {
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
		
	public int getNext() {
		String SQL = "SELECT l_id FROM temper ORDER BY t_id DESC";
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
	

	public ArrayList<Temper> getList(String searchType, String search, int pageNumber){
		if(searchType.equals("전체")) searchType ="";
		String SQL = "";
		ArrayList<Temper> list = new ArrayList<Temper>();
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
				Temper temper = new Temper();
				temper.setT_id(rs.getInt(1));
				temper.setT_data(rs.getInt(2));
				temper.setT_time(rs.getString(3));
				list.add(temper);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM temper WHERE t_id < ?";
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


 public Temper getTemper(int t_id) {
	String SQL = "SELECT * FROM temper WHERE t_id = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, t_id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Temper temper = new Temper();
			temper.setT_id(rs.getInt(1));
			temper.setT_data(rs.getInt(2));
			temper.setT_time(rs.getString(3));
			return temper;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}

}