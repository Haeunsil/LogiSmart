<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="carriers.Carriers"%>
<%@ page import="carriers.CarriersDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="carriers" class="carriers.Carriers" scope="page" />
<jsp:setProperty name="carriers" property="c_id" />
<jsp:setProperty name="carriers" property="c_name" />
<jsp:setProperty name="carriers" property="c_birth" />
<jsp:setProperty name="carriers" property="c_phone" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Eunsil's Search Page!!</title>
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
			int c_id = 0;
			if(request.getParameter("c_id") != null){
				c_id = Integer.parseInt(request.getParameter("c_id"));
			}
			if(c_id ==0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다..')");
				script.println("location.href = 'manage_Accept.jsp'");
				script.println("</script>");
			}
			CarriersDAO carriersDAO = new CarriersDAO();
				
				int result = carriersDAO.delete(c_id);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'manage_Accept.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>