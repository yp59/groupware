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
		  height:400px;
		  padding: 30px, 20px;
		  text-align:center;
		  top:50%;
		  left:50%;
		  transform: translate(-50%,-50%);
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
		
		.btn {
		  position:relative;
		  left:40%;
		  transform: translateX(-50%);
		  margin-bottom: 40px;
		  width:80%;
		  height:40px;
		  background:rgb(52,152,219);
		  background-position: left;
		  background-size: 200%;
		  color:white;
		  font-weight: bold;
		  border:none;
		  display:inline;
		}
		.bottomText {
		  text-align: center;
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
	
	<input type="submit" class="btn" value="로그인">
	
</form>
<%if(request.getParameter("error")!=null){
%>

<div class = "error">아이디 혹은 비밀번호가 일치하지 않습니다.</div>
<%} %>
<a href = "<%=request.getContextPath()%>/login/signUp.jsp">회원가입</a>
</div>

</body>
</html>