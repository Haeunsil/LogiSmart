<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="manager.ManagerDAO" %>    
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="manager" class="manager.Manager" scope="page"/>
<jsp:setProperty name="manager" property="m_ID" />
<jsp:setProperty name="manager" property="m_Password" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logi Manager Web</title>
</head>
<body>
	<%
	
		String m_ID = null;
		if(session.getAttribute("m_ID") != null){
			m_ID = (String) session.getAttribute("m_ID");
		}
		if(m_ID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		ManagerDAO managerDAO = new ManagerDAO();
		int result = managerDAO.login(manager.getM_ID(), manager.getM_Password());
		if (result ==1) {
			session.setAttribute("m_ID", manager.getM_ID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href= 'main.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다..')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>