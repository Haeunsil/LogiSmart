<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="manager.ManagerDAO" %>    
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="manager" class="manager.Manager" scope="page"/>
<jsp:setProperty name="manager" property="m_ID" />
<jsp:setProperty name="manager" property="m_Password" />
<jsp:setProperty name="manager" property="m_Name" />
<jsp:setProperty name="manager" property="m_Gender" />
<jsp:setProperty name="manager" property="m_Phone" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Logi Manager Web</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("m_ID") != null){
			userID = (String) session.getAttribute("m_ID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if (manager.getm_ID() == null || manager.getm_Password() == null || manager.getm_Name() ==null
		|| manager.getm_Phone() ==null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			ManagerDAO ManagerDAO = new ManagerDAO();
			int result = ManagerDAO.join(manager);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				session.setAttribute("m_ID", manager.getm_ID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>