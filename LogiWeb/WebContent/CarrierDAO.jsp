<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%
	String jdbcDriver = "jdbc:mysql://localhost/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
	String dbUser = "logismart";
	String dbPass = "Logi2017253012";
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet result = null;
	
	try {
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String phone = request.getParameter("phone");
		
		String driver = "com.mysql.cj.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String max_id = "SELECT IFNULL(MAX(c_id) + 1, 1) FROM carriers;";
		result = stmt.executeQuery(max_id);
		
		System.out.println("name: " + name);
		
		result.next();
		
		int id = result.getInt(1);
		System.out.println("id: " + id);
		
		String insert_carrier = "INSERT INTO carriers(c_id, c_name, c_birth, c_phone) VALUES(?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(insert_carrier);
		pstmt.setInt(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, birth);
		pstmt.setString(4, phone);
		
		int insert = pstmt.executeUpdate();
		
		JSONObject jObject = new JSONObject();
		
		if (insert > 0) {
			System.out.println("Insert Complete");
		 	jObject.put("name", name);
			jObject.put("birth", birth);
			jObject.put("phone", phone);
			jObject.put("id", id);
			
		}
		System.out.println(jObject.toJSONString());
		out.println(jObject.toJSONString());
		
	} catch (SQLException se) {
		se.printStackTrace();
	} finally {
		try {
			result.close();
			pstmt.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>