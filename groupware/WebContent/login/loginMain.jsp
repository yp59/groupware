<%@page import="groupware.beans.employeesDao"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹웨어 로그인</title>
	<style>
		h1{
	 	color :rgb(52,152,219);
	 	}
		*{
		  margin: 0px;
		  padding: 0px;
		  font-family:sans-serif;
		}
		
		.loginForm {
		  position:absolute;
		  width:300px;
		  height:430px;
		  padding: 30px, 20px;
		  text-align:center;
		  top:50%;
		  left:50%;
		  transform: translate(-50%,-50%);
		  border:1px solid black !important;
		  border-radius: 15px;
		}
		
		.loginForm h1{
		  text-align: center;
		  margin: 30px;
		}
		
		.idForm{
		  border-bottom: 2px solid #adadad;
		  margin: 30px;
		  padding: 10px 10px;
		}
		
		.passForm{
		  border-bottom: 2px solid #adadad;
		  margin: 30px;
		  padding: 10px 10px;
		}
		
		.id {
		  width: 100%;
		  border:none;
		  outline:none;
		  font-size:16px;
		  height:25px;
		  background: none;
		}
		
		.pw {
		  width: 100%;
		  border:none;
		  outline:none;
		  font-size:16px;
		  height:25px;
		  background: none;
		}
		
		.form-btn {
		  width:70% !important;
		}
		
		.signUp{
			padding:0.3em;
			color:black;
			text-decoration:none;
			border-radius: 5px;
			border:1px solid lightgray;
			color:rgb(52,152,219);
		}
		.signUp:hover{
			background-color:rgb(52,152,219);
			color:white;
		}
		
	</style>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
</head>
<body width="100%" height="100%">
<div class="loginForm container-500">

<form action="confirm.gw" method="post">
	<h1>GroupWare</h1>
	<div class="idForm">
	아이디  <input type="text" class="id" name="empNo" placeholder="ID" required>
	</div>
	<div class="passForm">
	비밀번호  <input type="password" class="pw" name="empPw" placeholder="PW" required><br>
	</div>
	
	<input type="submit" class="form-btn form-btn-positive" value="로그인">
</form>

<div class = "row error" style="height:20px;">
<%if(request.getParameter("error")!=null){%>
아이디 혹은 비밀번호가 일치하지 않습니다.
<%} %>
</div>

<div class="row text-right">
<a href = "<%=request.getContextPath()%>/login/signUp.jsp" class="signUp" style="margin-right:20px; margin-bottom:20px;">회원가입</a>
</div>

</div>

</body>
</html>