<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="bluetooth.Bluetooth" %>
<%@ page import="bluetooth.BluetoothDAO" %>
<%@ page import="locate.Locate" %>
<%@ page import="locate.LocateDAO" %>
<%@ page import="temper.Temper" %>
<%@ page import="temper.TemperDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Logi Mananger Web</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<!-- <link rel="stylesheet" href="css/btn-deco.css"> -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
	<%

		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 0;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String searchType="전체";
		if(request.getParameter("searchType") != null){
			searchType = request.getParameter("searchType");
		}
		String search="";
		if(request.getParameter("search") != null){
			search = request.getParameter("search");
		}
		int bbs_num = 0;
		if(request.getParameter("bbs_num") != null){
			bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
		}
		ManageBbs managebbs = new ManageBbsDAO().getmanageBbs(bbs_num);
		int l_id = 0;
		if(request.getParameter("l_id") != null){
			l_id = Integer.parseInt(request.getParameter("l_id"));
		}
		Locate locate = new LocateDAO().getLocate(bbs_num);

		int b_thing = 0;
		if(request.getParameter("b_thing") != null){
			b_thing = Integer.parseInt(request.getParameter("b_thing"));
		}
		Bluetooth bluetooth = new BluetoothDAO().getBluetooth(bbs_num);
		int t_id = 0;
		if(request.getParameter("t_id") != null){
			t_id = Integer.parseInt(request.getParameter("t_id"));
		}
		Temper temper = new TemperDAO().getTemper(bbs_num);
		String m_ID = null;
		if (session.getAttribute("m_ID") != null) {
			m_ID = (String) session.getAttribute("m_ID");
		}
		Manager manager = new ManagerDAO().getmanager(m_ID);
		
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
	 	<li class="active"><a href="manage_bbs.jsp">운반현황</a></li>
	 	<li><a href="manage_manager.jsp">관리자현황</a></li>
	 	<li><a href="manage_carrier.jsp">운반자현황</a></li>
	 	</ul>
	 		<%
	 		if(m_ID == null){
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">관리자 접속하기<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="login.jsp">로그인</a></li>
	 				<li><a href="join.jsp">관리자가입</a></li>
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
	 				aria-expanded="false">"<%=manager.getM_ID() %>" 님 접 속 중<span class="caret"></span></a>
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
		
		<form method="get" action="manage_bbs.jsp" class="form-inline" style="margin-bottom: 10px">
				<select name="searchType" class="form-control">
					<option value="전체">전체</option>
					<option value="번호" <%if(searchType.equals("이름")) out.println("selected");%>>이름</option>
					<option value="상태" <%if(searchType.equals("상태")) out.println("selected");%>>상태</option>
					<option value="정보" <%if(searchType.equals("정보")) out.println("selected");%>>정보</option>
				</select>
				<input type="text" name="search" class="form-control" <% if(!search.equals("")) out.println("value="+ search); else out.println("placeholder=\"내용을 입력하세요\""); %>>
				<button type="submit" class="form-control btn btn-primary">검색</button>
				<a href="manage_bbs.jsp" class="btn btn-primary pull-right">새로고침</a>
		</form>
	
	
		<div class="row">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeee; text-align: center;">물품번호</th>
						<th style="background-color: #eeeee; text-align: center;">물품이름</th>
						<th style="background-color: #eeeee; text-align: center;">출발지</th>
						<th style="background-color: #eeeee; text-align: center;">도착지</th>
						<th style="background-color: #eeeee; text-align: center;">실시간온도위치</th>
						<th style="background-color: #eeeee; text-align: center;">상세정보</th>
					</tr>
				</thead>
				<tbody>
				
 				<%			
 					ManageBbsDAO managebbsDAO = new ManageBbsDAO();
					ArrayList<ManageBbs> list = managebbsDAO.getList(searchType, search, pageNumber);
					for(int i = 0; i < list.size(); i++){		
				%>
					<tr>
						<td><%= list.get(i).getBbs_num() %></td>
						<td><%= list.get(i).getBbs_name() %></td>
						<td><%= list.get(i).getBbs_start() %></td>
						<td><%= list.get(i).getBbs_arrival() %></td>
						<td><a href="LocateView.jsp?bbs_num=<%= list.get(i).getBbs_num()%>" class="btn btn-primary pull-center" style="text-align: center">View</a></td>	
						<td><a href="DetailView.jsp?bbs_num=<%= list.get(i).getBbs_num()%>" class="btn btn-primary pull-center" style="text-align: center">View</a></td>
					</tr>
					
					<%
					}
					%>

				</tbody>
			</table>

</body>
</html>