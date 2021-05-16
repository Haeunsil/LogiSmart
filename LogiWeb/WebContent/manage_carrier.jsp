<%@ page  contentType="text/html;charset=euc-kr" 
        import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
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
		String searchType="��ü";
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
	 	<li><a href="main.jsp">����</a></li>
	 	<li><a href="manage_Accept.jsp">��ݼ���</a></li>
	 	<li><a href="manage_bbs.jsp">�����Ȳ</a></li>
	 	<li><a href="manage_manager.jsp">��������Ȳ</a></li>
	 	<li><a href="manage_carrier.jsp">�������Ȳ</a></li>
	 	</ul>
	 	<%
	 		if(userID == null){
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">������ �����ϱ�<span class="caret"></span></a>
	 				<ul class="dropdown-menu">
	 				<li><a href="login.jsp">�α���</a></li>
	 				<li><a href="join.jsp">�������߰�</a></li>
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
	 				aria-expanded="false">ȸ������<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="logoutAction.jsp">�α׾ƿ�</a></li>
	 			</ul>
	 		</li>
	 	</ul>
		<%
	 		}
		%>
	 </div>
	</nav>
	
	<div class = "container">
		
		<form method="get" action="manage_manager.jsp" class="form-inline" style="margin-bottom: 10px">
				<select name="searchType" class="form-control">
					<option value="��ü">��ü</option>
					<option value="�̸�" <%if(searchType.equals("�̸�")) out.println("selected");%>>�̸�</option>
					<option value="����" <%if(searchType.equals("����")) out.println("selected");%>>����</option>
					<option value="����" <%if(searchType.equals("����")) out.println("selected");%>>����</option>
				</select>
				<input type="text" name="search" class="form-control" <% if(!search.equals("")) out.println("value="+ search); else out.println("placeholder=\"������ �Է��ϼ���\""); %>>
				<button type="submit" class="form-control btn btn-primary">�˻�</button>
			
		</form>
	
	
		<div class="row">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeee; text-align: center;">����</th>
						<th style="background-color: #eeeee; text-align: center;">�̸�</th>
						<th style="background-color: #eeeee; text-align: center;">����</th>
						<th style="background-color: #eeeee; text-align: center;">�ڵ�����ȣ</th>
						<th style="background-color: #eeeee; text-align: center;">���</th>
					</tr>
				</thead>           
 
		 <tbody>              
		<%
		  response.setContentType("text/html;charset=euc-kr;");
		  request.setCharacterEncoding("euc-kr");     //charset, Encoding ����
		
		  Class.forName("com.mysql.jdbc.Driver");    // load the drive
		  String DB_URL = 
				  "jdbc:mysql://localhost/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
		                 // ���� : test by changing mydb to name that you make
		
		  String DB_USER = "logismart";
		  String DB_PASSWORD= "Logi2017253012";
		
		  Connection conn= null;
		  Statement stmt = null;
		  ResultSet rs   = null;
		
		  try {
		      conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		      stmt = conn.createStatement();
		
		      String query = "SELECT c_id, c_name, c_birth, c_phone FROM carriers";
		      rs = stmt.executeQuery(query);
		 %>
		
		<%
		    while(rs.next()) { //rs �� ���� ���̺� ��ü���� �ʵ尪�� �Ѱܺ� �� �ִ�.
		%><tr>
		<td><%=rs.getString(1)%></td>
		<td><%=rs.getString(2)%></td>
		<td><%=rs.getString("c_birth")%></td>
		<td><%=rs.getString("c_phone")%></td>
		<td><a href="deleteAction.jsp?del=<%=rs.getString(1)%>">����</a>
		</td>
		</tr>
			</tbody>				
		<%
		    } // end while
		%></table>
		
		<%
		  rs.close();        // ResultSet exit
		  stmt.close();     // Statement exit
		  conn.close();    // Connection exit
		}
		catch (SQLException e) {
		      out.println("err:"+e.toString());
		}
		%>
		



</body>
</html>


