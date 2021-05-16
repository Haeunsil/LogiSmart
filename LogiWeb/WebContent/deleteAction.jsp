<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="managebbs.ManageBbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="managebbs" class="managebbs.ManageBbs" scope="page" />
<jsp:setProperty name="managebbs" property="proTitle" />
<jsp:setProperty name="managebbs" property="proContent" />

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
			int proID = 0;
			if(request.getParameter("proID") != null){
				proID = Integer.parseInt(request.getParameter("proID"));
			}
			if(proID ==0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다..')");
				script.println("location.href = 'manage_bbs.jsp'");
				script.println("</script>");
			}
				ManageBbsDAO managebbsDAO = new ManageBbsDAO();
				
				int result = managebbsDAO.delete(proID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('명언 삭제에 실패하였습니다.')");
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