<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="managebbs.ManageBbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="managebbs" class="managebbs.ManageBbs" scope="page" />
<jsp:setProperty name="managebbs" property="bbsTitle" />
<jsp:setProperty name="managebbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logi Manager Web</title>
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
			if (managebbs.getBbs_name() == null || managebbs.getBbs_manager() == null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				ManageBbsDAO managebbsDAO = new ManageBbsDAO();
				int result = managebbsDAO.write(managebbs.getBbs_name(), managebbs.getBbs_manager(), managebbs.getBbs_start(), managebbs.getBbs_arrival());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('등록하기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_bbs.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>