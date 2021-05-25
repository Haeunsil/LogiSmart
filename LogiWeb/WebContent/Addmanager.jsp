<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">관리자 접속하기<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="login.jsp">로그인</a></li>
	 				<li class="active"><a href="join.jsp">관리자가입</a></li>
	 			</ul>
	 		</li>
	 	</ul>
	 </div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
			<form method="post" action="AddmanagerAction.jsp">
				<h3 style"text-align: center;">관리자 추가 화면</h3>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="아이디" name="m_ID" maxlength="20">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" placeholder="비밀번호" name="m_Password" maxlength="20">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="이름" name="m_Name" maxlength="20">
				</div>
				<div class="form-group" style="text-align: center;">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active">
							<input type="radio" name="m_Gender" autocomplete="off" value="남자" checked>남자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="m_Gender" autocomplete="off" value="여자" checked>여자
						</label>
					</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="핸드폰" name="m_Phone" maxlength="50">
				</div>
				<input type="submit" class="btn btn-primary form-control" value="관리자 추가 전송">
			</form>
			</div>
		</div>
	</div>
</body>
</html>