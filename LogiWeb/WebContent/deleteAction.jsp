<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.ManagerDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="managerBbs" class="manager.ManagerDAO" scope="page" />
<jsp:setProperty name="manager" property="m_Num" />
<jsp:setProperty name="manager" property="m_ID" />
<jsp:setProperty name="manager" property="m_Password" />
<jsp:setProperty name="manager" property="m_Name" />
<jsp:setProperty name="manager" property="m_Gender" />
<jsp:setProperty name="manager" property="m_Phone" />
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
					int m_Num = 0;
					if(request.getParameter("m_Num") != null){
						m_Num = Integer.parseInt(request.getParameter("m_Num"));
					}
					ManagerDAO managerDAO = new ManagerDAO();
				
				int result = managerDAO.delete(m_Num);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert(' 삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_manager.jsp'");
					script.println("</script>");
				}
		
		}
	%>
</body>
</html>