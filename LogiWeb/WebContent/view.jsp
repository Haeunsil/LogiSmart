<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Logi Mananger Web</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID ==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다..')");
			script.println("location.href = 'manage_bbs.jsp'");
			script.println("</script>");
		}
		ManageBbs managebbs = new ManageBbsDAO().getmanagebbs(bbsID);
		
	%>
	<nav class="navbar navbar-default">
	 <div class="navbar-header">
	 	<button type="button" class="navbar-toggle collapsed"
	 		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" 
	 		aria-expanded="false">
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
	 		</button>
	 		<a class="navbar-brand" href="main.jsp">LogiSmart Manage Page</a>
	 </div>
	 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 	<ul class="nav navbar-nav">
	 	<li><a href="main.jsp">메인</a></li>
	 	<li><a href="manage_Accept.jsp">운반수락</a></li>
	 	<li><a href="manage_bbs.jsp">운반현황</a></li>
	 	<li><a href="manage_manager.jsp">관리자현황</a></li>
	 	<li><a href="manage_carrier.jsp">운반자현황</a></li>
	 	</ul>
	 	<%
	 		if(userID == null){
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">관리자 접속하기<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="login.jsp">로그인</a></li>
	 				<li><a href="join.jsp">관리자추가</a></li>
	 			</ul>
	 		</li>
	 	</ul>
	 	<%
	 		}else {
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">관리자관리<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="logoutAction.jsp">로그아웃</a></li>
	 			</ul>
	 		</li>
	 	</ul>
		<%
	 		}
		%>
	 </div>
	</nav>
	<div class = "container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeee; text-align: center;">물품 상세 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>물품 번호</td>
						<td colspan="2"><%= managebbs.getBbsID() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">물품 이름</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">출발지 -> 도착지</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">운반자</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					</tr>
					</tr>
						<td style="width: 20%;">실시간 온도</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					<tr>
					</tr>
						<td style="width: 20%;">실시간 위치</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					<tr>
					<tr>
						<td style="width: 20%;">기기명</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					</tr>
						<td style="width: 20%;">기기 연결 여부</td>
						<td colspan="2"><%= managebbs.getBbsTitle() %></td>
					<tr>
						<td style="width: 20%;">기타 내용</td>
						<td colspan="2" style="min-height: 200px; text-align: center;"><%= managebbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;") %></td>
					</tr>
				</tbody>
			</table>
			<a href="manage_bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(managebbs.getUserID())){
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a href="deleteAction.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
				<input type="submit" class="btn btn-primary pull-right" value="등록하기">
		</form>
		</div>
	</div>
</body>
</html>