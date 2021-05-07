<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹웨어 로그인</title>
</head>
<body>

<h1>GroupWare</h1>
<%if(request.getParameter("error")!=null){
%>

<form action="confirm.gw" method="post">
	 아이디 : <input type="text" name="empNo" placeholder="숫자 4자리 입력" required pattern="[0-9]{4,8}"><br>
	비밀번호 : <input type="password" name="empPw" placeholder="비밀번호 입력" required pattern="[a-zA-Z0-9]{8,16}"> <br>
	<input type="submit" value="로그인">
</form>
<div class = "error">정보가 일치하지 않습니다.</div>
<a href = "http://localhost:8080/groupware/login/signUp.jsp">회원가입(임시)</a>
<%}else{ %>
<form action="confirm.gw" method="post">
	 아이디 : <input type="text" name="empNo" placeholder="숫자 4자리 입력" required pattern="[0-9]{4,8}"><br>
	비밀번호 : <input type="password" name="empPw" placeholder="비밀번호 입력" required pattern="[a-zA-Z0-9]{8,16}"> <br>
	<input type="submit" value="로그인">
</form>

<a href = "http://localhost:8080/groupware/login/signUp.jsp">회원가입(임시)</a>

<%} %>
</body>
</html>