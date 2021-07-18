<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="bluetooth.Bluetooth" %>
<%@ page import="bluetooth.BluetoothDAO" %>
<%@ page import="carriers.Carriers" %>
<%@ page import="carriers.CarriersDAO" %>
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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbs_num = 0;
	if(request.getParameter("bbs_num") != null){
		bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
	}
	if(bbs_num ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다..')");
		script.println("location.href = 'manage_bbs.jsp'");
		script.println("</script>");
	}
	ManageBbs managebbs = new ManageBbsDAO().getmanageBbs(bbs_num);
	
	int l_id = 0;
	if(request.getParameter("l_id") != null){
		l_id = Integer.parseInt(request.getParameter("l_id"));
	}
	Locate locate = new LocateDAO().getLocate(managebbs.getBbs_carrierID());
	
	int t_id = 0;
	if(request.getParameter("t_id") != null){
		t_id = Integer.parseInt(request.getParameter("t_id"));
	}
	Temper temper = new TemperDAO().getTemper(managebbs.getBbs_carrierID());
	int b_thing = 0;
	if(request.getParameter("b_thing") != null){
		b_thing = Integer.parseInt(request.getParameter("b_thing"));
	}
	Bluetooth bluetooth = new BluetoothDAO().getBluetooth(managebbs.getBbs_carrierID());
	
	int c_id = 0;
	if(request.getParameter("c_id") != null){
		c_id = Integer.parseInt(request.getParameter("c_id"));
	}
	Carriers carriers = new CarriersDAO().getCarriers(managebbs.getBbs_carrierID());
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
						<td>물품 순번</td>
						<td colspan="5"><%= managebbs.getBbs_num() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">물품이름</td>
						<td colspan="2"><%= managebbs.getBbs_name() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">담당 관리자</td>
						<td colspan="2"><%= managebbs.getBbs_manager() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">담당 운반자</td>
						<td colspan="2"><%= carriers.getC_name() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">기기명</td>
						<td colspan="2"><%= bluetooth.getB_name() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">기기연결여부</td>
						<td colspan="2"><%= bluetooth.getB_conn() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">출발지</td>
						<td colspan="2"><%= managebbs.getBbs_start() %></td>
					</tr>
										<tr>
						<td style="width: 20%;">도착지</td>
						<td colspan="2"><%= managebbs.getBbs_arrival() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">온도 상한선</td>
						<td colspan="2"><%= managebbs.getBbs_upper() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">온도 하한선</td>
						<td colspan="2"><%= managebbs.getBbs_lower() %></td>
					</tr>
				

				</tbody>
			<a href="manage_bbs.jsp" class="btn btn-primary pull-center">목록</a>

		</form>
		</div>
	</div>
</body>
</html>