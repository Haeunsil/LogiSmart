<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="carriers.Carriers"%>
<%@ page import="carriers.CarriersDAO"%>
<%@ page import="managebbs.ManageBbs"%>
<%@ page import="managebbs.ManageBbsDAO"%>
<%@ page import="bluetooth.Bluetooth"%>
<%@ page import="bluetooth.BluetoothDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bluetooth" class="bluetooth.Bluetooth" scope="page" />
<jsp:setProperty name="bluetooth" property="b_num" />
<jsp:setProperty name="bluetooth" property="b_name" />
<jsp:setProperty name="bluetooth" property="b_carrier" />
<jsp:setProperty name="bluetooth" property="b_thing" />
<jsp:setProperty name="bluetooth" property="b_conn" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Logi Mananger Web</title>
</head>
<body>
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
			} else {
			int b_num = 0;
			if(request.getParameter("b_num") != null){
				b_num = Integer.parseInt(request.getParameter("b_num"));
			}
			BluetoothDAO bluetoothDAO = new BluetoothDAO();
				int result = bluetoothDAO.delete(b_num);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_bluetooth.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>