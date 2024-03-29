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
<jsp:useBean id="manageBbs" class="managebbs.ManageBbs" scope="page" />
<jsp:setProperty name="manageBbs" property="bbs_num" />
<jsp:setProperty name="manageBbs" property="bbs_name" />
<jsp:setProperty name="manageBbs" property="bbs_manager" />
<jsp:setProperty name="manageBbs" property="bbs_carrierID" />
<jsp:setProperty name="manageBbs" property="bbs_start" />
<jsp:setProperty name="manageBbs" property="bbs_arrival" />
<jsp:setProperty name="manageBbs" property="bbs_upper" />
<jsp:setProperty name="manageBbs" property="bbs_lower" />
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
		int bbs_num = 0;
		if(request.getParameter("bbs_num") != null){
			bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
		}
		ManageBbs managebbs = new ManageBbsDAO().getmanageBbs(bbs_num);
		ManageBbsDAO managebbsDAO = new ManageBbsDAO();
		int c_id = Integer.parseInt(request.getParameter("bbs_carrierID"));
		int result = managebbsDAO.update(bbs_num, c_id);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_bbs.jsp'");
					script.println("</script>");
				}
				Bluetooth Bluetooth = new BluetoothDAO().getBluetooth(bbs_num);
				BluetoothDAO bluetoothDAO = new BluetoothDAO();
				int b_thing = Integer.parseInt(request.getParameter("bbs_num"));
				int result2 = bluetoothDAO.update2(c_id);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
			} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_bbs.jsp'");
					script.println("</script>");
			}


	%>
</body>
</html>