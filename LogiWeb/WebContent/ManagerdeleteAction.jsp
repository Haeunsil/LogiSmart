<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.ManagerDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="manager" class="manager.Manager" scope="page" />
<jsp:setProperty name="manager" property="m_ID" />
<jsp:setProperty name="manager" property="m_Password" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Logi Mananger Web</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			int m_ID = 0;
			if(request.getParameter("m_ID") != null){
				m_ID = Integer.parseInt(request.getParameter("m_ID"));
			}
			if(m_ID ==0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다..')");
				script.println("location.href = 'manage_bbs.jsp'");
				script.println("</script>");
			}
				ManagerDAO managerDAO = new ManagerDAO();
				
				int result = managerDAO.delete(m_ID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('관리자 삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_bbs.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>