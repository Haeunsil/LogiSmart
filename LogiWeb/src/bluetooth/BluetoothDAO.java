package bluetooth;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BluetoothDAO {

		private Connection conn;
		private ResultSet rs;
		
		public BluetoothDAO() {
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
		String SQL = "SELECT b_num FROM bluetooth ORDER BY b_num DESC";
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
	

	public ArrayList<Bluetooth> getList(String searchType, String search, int pageNumber){
		if(searchType.equals("전체")) searchType ="";
		String SQL = "";
		ArrayList<Bluetooth> list = new ArrayList<Bluetooth>();
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
				Bluetooth bluetooth = new Bluetooth();
				bluetooth.setB_num(rs.getInt(1));
				bluetooth.setB_name(rs.getString(2));
				bluetooth.setB_carrier(rs.getInt(3));
				bluetooth.setB_thing(rs.getInt(4));
				bluetooth.setB_conn(rs.getInt(5));
				list.add(bluetooth);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; //데이터베이스오류
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bluetooth WHERE b_num < ?";
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


	 public Bluetooth getBluetooth(int b_carrier) {
			String SQL = "SELECT * FROM bluetooth WHERE b_carrier = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, b_carrier);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					Bluetooth bluetooth = new Bluetooth();
					bluetooth.setB_num(rs.getInt(1));
					bluetooth.setB_name(rs.getString(2));
					bluetooth.setB_carrier(rs.getInt(3));
					bluetooth.setB_thing(rs.getInt(4));
					bluetooth.setB_conn(rs.getInt(5));
					return bluetooth;
				}			
			}catch(Exception e) {
				e.printStackTrace();
				}
			return null; 
		 	}
 
	public int update(int b_num, int b_carrier) {
 		String SQL = "UPDATE bluetooth SET b_carrier =?  WHERE b_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_carrier);
			pstmt.setInt(2, b_num);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
	public int update2(int b_carrier) {
 		String SQL = "UPDATE bluetooth INNER JOIN managebbs ON bluetooth.b_carrier = managebbs.bbs_carrierID SET bluetooth.b_thing = managebbs.bbs_num WHERE b_carrier=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_carrier);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
	public int update_thing (int b_num, int b_thing) {
 		String SQL = "UPDATE bluetooth SET b_thing =?  WHERE b_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_thing);
			pstmt.setInt(2, b_num);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 		
 	}
	
	public int delete(int b_num) {
 		String SQL = "delete from bluetooth where b_num =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, b_num);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류 		
 	}
}