<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="carriers.Carriers"%>
<%@ page import="carriers.CarriersDAO"%>
<%@ page import="managebbs.ManageBbs"%>
<%@ page import="managebbs.ManageBbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
			int bbs_num = 0;
			if(request.getParameter("bbs_num") != null){
				bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
			}
			ManageBbsDAO managebbsDAO = new ManageBbsDAO();
				int result = managebbsDAO.delete(bbs_num);
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