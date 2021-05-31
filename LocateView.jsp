<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
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
						<th colspan="3" style="background-color: #eeeee; text-align: center;">실시간 위치 정보</th>
					</tr>
				</thead>
				<tbody>
				
							<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbUrl="jdbc:mysql://logismart.cafe24.com/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbUser="logismart";
			String dbpass="Logi2017253012";
			Connection con=DriverManager.getConnection(dbUrl, dbUser, dbpass);
			String sql="select * from managebbs LEFT OUTER JOIN temper ON bbs_num = t_id JOIN locate ON bbs_num = l_id ";
			PreparedStatement pstmt=con.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			%>
			<%
				
			%>	
			
			
			<%
			if(rs.next()){
			%>

					<tr>
						<td>물품 번호</td>
						<td colspan="2"><%=rs.getInt("bbs_num")%> </td>
					</tr>
					<tr>
						<td style="width: 20%;">물품 이름</td>
						<td colspan="2"><%=rs.getString("bbs_name")%></td>
					</tr>
					
					

					<tr>
						<td>실시간 위치</td>
						<td colspan="10">
					<div id="map" style="width:100%;height:300px;"></div>
				    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e715328006c2c7c0960654959d990d9"></script>
				    <script>
				        var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				            mapOption = {
				                center: new kakao.maps.LatLng(37.539922, 127.070609), // 지도의 중심좌표
				                level: 6 // 지도의 확대 레벨
				            };
				        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				        // 지도에 표시될 객체를 가지고 있을 배열입니다
				        const locations = [
				            { place:"건대입구역", lat: 37.539922, lng: 127.070609 }	      
				        ];
				
				        for (var i = 0; i < locations.length; i++) {
				            var marker = new kakao.maps.Marker({
				                map: map,
				                position: new kakao.maps.LatLng(locations[i].lat, locations[i].lng)
				            });
				        }
				    </script>	
					</tr>	
													<%
			}
			%>
				</tbody>
			</table>
			<a href="manage_bbs.jsp" class="btn btn-primary">목록</a>
				<input type="submit" class="btn btn-primary pull-right" value="등록하기">
		</form>
		</div>
	</div>
</body>
</html>