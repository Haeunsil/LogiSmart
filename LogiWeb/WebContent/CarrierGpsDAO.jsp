<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
	String jdbcDriver = "jdbc:mysql://localhost/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
	String dbUser = "logismart";
	String dbPass = "Logi2017253012";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("strings1");
		String LAT = request.getParameter("strings2");
		String LON = request.getParameter("strings3");
		
		JSONObject jObject = new JSONObject();
		
		String driver = "com.mysql.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String insert_gps = "INSERT INTO locate(l_id, l_wido, l_gyeongdo, l_time) VALUES(?, ?, ?, NOW())";
		
		pstmt = conn.prepareStatement(insert_gps);
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setString(2, LAT);
		pstmt.setString(3, LON);
		
		int insert = pstmt.executeUpdate();
		
		if (insert > 0) {
			System.out.println("Insert Complete");
			jObject.put("result", "success");
		}
		else {
			System.out.println("Insert Fail");
			jObject.put("result", "fail");
		}
		System.out.println(jObject.toJSONString());
		out.println(jObject.toJSONString());
		
	} catch (SQLException se) {
		se.printStackTrace();
	} finally {
		try {
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
