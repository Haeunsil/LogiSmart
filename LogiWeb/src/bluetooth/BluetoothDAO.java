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
		String SQL = "SELECT b_thing FROM bluetooth ORDER BY b_thing DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //ù��° �Խù��� ���
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽�����
	}
	

	public ArrayList<Bluetooth> getList(String searchType, String search, int pageNumber){
		if(searchType.equals("��ü")) searchType ="";
		String SQL = "";
		ArrayList<Bluetooth> list = new ArrayList<Bluetooth>();
		try {
			/*
			if(searchType.equals("��ǰ�̸�")) {
				SQL = "SELECT * FROM managebbs WHERE bbs_name LIKE ? ORDER BY bbs_num DESC LIMIT "+ pageNumber*10 +", " + pageNumber*10+11;
			}else if(searchType.equals("�������")) {
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
				bluetooth.setB_name(rs.getString(1));
				bluetooth.setB_carrier(rs.getInt(2));
				bluetooth.setB_thing(rs.getInt(3));
				bluetooth.setB_conn(rs.getInt(4));
				list.add(bluetooth);				
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; //�����ͺ��̽�����
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bluetooth WHERE b_thing < ?";
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
		return false; //�����ͺ��̽�����
	}


 public Bluetooth getBluetooth(int b_thing) {
	String SQL = "SELECT * FROM bluetooth WHERE b_thing = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, b_thing);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Bluetooth bluetooth = new Bluetooth();
			bluetooth.setB_name(rs.getString(1));
			bluetooth.setB_carrier(rs.getInt(2));
			bluetooth.setB_thing(rs.getInt(3));
			bluetooth.setB_conn(rs.getInt(4));
			return bluetooth;
		}			
	}catch(Exception e) {
		e.printStackTrace();
		}
	return null; 
 	}

}