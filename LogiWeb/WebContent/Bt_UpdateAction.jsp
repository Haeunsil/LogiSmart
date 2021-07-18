<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="bluetooth.Bluetooth" %>
<%@ page import="bluetooth.BluetoothDAO" %>
<%@ page import="carriers.Carriers" %>
<%@ page import="carriers.CarriersDAO" %>
<%@ page import="locate.Locate" %>
<%@ page import="locate.LocateDAO" %>
<%@ page import="temper.Temper" %>
<%@ page import="temper.TemperDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>
<jsp:useBean id="bluetooth" class="bluetooth.Bluetooth" scope="page" />
<jsp:setProperty name="bluetooth" property="b_num" />
<jsp:setProperty name="bluetooth" property="b_name" />
<jsp:setProperty name="bluetooth" property="b_carrier" />
<jsp:setProperty name="bluetooth" property="b_thing" />
<jsp:setProperty name="bluetooth" property="b_conn" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Eunsil's Search Page!!</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>

	<%
		String m_ID = null;
		if (session.getAttribute("m_ID") != null) {
			m_ID = (String) session.getAttribute("m_ID");
		}
		if (m_ID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		int b_num = 0;
		if(request.getParameter("b_num") != null){
			b_num = Integer.parseInt(request.getParameter("b_num"));
		}
		Bluetooth Bluetooth = new BluetoothDAO().getBluetooth(b_num);
		BluetoothDAO bluetoothDAO = new BluetoothDAO();
		int c_id = Integer.parseInt(request.getParameter("b_carrier"));
		int result = bluetoothDAO.update(b_num, c_id);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_Accept.jsp'");
					script.println("</script>");
				}

	%>
</body>
</html>