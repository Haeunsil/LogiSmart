<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
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
		request.setCharacterEncoding("UTF-8");
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
	 				aria-expanded="false">회원관리<span class="caret"></span></a>
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
		
		<form method="get" action="manage_Accept.jsp" class="form-inline" style="margin-bottom: 10px">
				<select name="searchType" class="form-control">
					<option value="전체">전체</option>
					<option value="이름" <%if(searchType.equals("이름")) out.println("selected");%>>이름</option>
					<option value="상태" <%if(searchType.equals("상태")) out.println("selected");%>>상태</option>
					<option value="정보" <%if(searchType.equals("정보")) out.println("selected");%>>정보</option>
				</select>
				<input type="text" name="search" class="form-control" <% if(!search.equals("")) out.println("value="+ search); else out.println("placeholder=\"내용을 입력하세요\""); %>>
				<button type="submit" class="form-control btn btn-primary">검색</button>
			
		</form>
	
	
		<div class="row">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeee; text-align: center;">물품 이름</th>
						<th style="background-color: #eeeee; text-align: center;">수락 요청일</th>
						<th style="background-color: #eeeee; text-align: center;">운반자</th>
						<th style="background-color: #eeeee; text-align: center;">수락 여부</th>
						<th style="background-color: #eeeee; text-align: center;">선택</th>
					</tr>
				</thead>
				
				<tbody>
 				<%			
 					ManageBbsDAO managebbsDAO = new ManageBbsDAO();
					ArrayList<ManageBbs> list = managebbsDAO.getList(pageNumber);
					System.out.println("============================> "+list.size());
					for(int i = 0; i < list.size(); i++){	
						if(i==10) break;
				%>
					<tr>
						<td><%= list.get(i).getBbs_num() %></td>
						<td><a href="view.jsp?Bbs_num=<%= list.get(i).getBbs_num() %>"><%= list.get(i).getBbs_name() %></a></td>
						<td><%= list.get(i).getBbs_manager() %></td>
						<td><%= list.get(i).getBbs_start() %></td>
						<td><%= list.get(i).getBbs_arrival() %></td>
						<td><input type='checkbox' name='check' value=list.get(i).getBbs_num()/></a></td>
					
					</tr>
					<% 
						}
					%>
				</tbody>				
			</table>
			<%
				if(pageNumber <=0){
			%>
			
			<a class="btn btn-success disabled">이전</a>
			
			<%
				} else {
			%>
			
			<a href="manage_bbs.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber - 1 %>" class="btn btn-success">이전</a>
			<%
				} 
			%>
			<%
				if(list.size() < 10){
			%>
			
			<a class="btn btn-success disabled">다음</a>
			<%
				} else {
					
			%>
			
			<a href="manage_bbs.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber + 1 %>" class="btn btn-success">다음</a>
			<%
				} 
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">거절</a>
			<a href="write.jsp" class="btn btn-primary pull-right">수락</a>
		</div>
	</div>
</body>
</html>