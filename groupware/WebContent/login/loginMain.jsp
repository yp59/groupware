<%@page import="groupware.beans.employeesDao"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹웨어 로그인</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
</head>
<body>

<h1>GroupWare</h1>
<%if(request.getParameter("error")!=null){
%>

<form action="confirm.gw" method="post">
	 아이디 : <input type="text" name="empNo" placeholder="아이디 입력" required><br>
	 
	비밀번호 : <input type="password" name="empPw" placeholder="비밀번호 입력" required><br>
	
			<input type="submit" value="로그인">
</form>

<div class = "error">아이디 혹은 비밀번호가 일치하지 않습니다.</div>
<a href = "<%=request.getContextPath()%>/login/signUp.jsp">회원가입(임시)</a>
<%}else{ %>


<form action="confirm.gw" method="post">
	 아이디 : <input type="text" name="empNo" placeholder="아이디 입력" required><br>
	 
	비밀번호 : <input type="password" name="empPw" placeholder="비밀번호 입력" required> <br>
	
			<input type="submit" value="로그인">
</form>

<a href = "<%=request.getContextPath()%>/login/signUp.jsp">회원가입(임시)</a>

<%} %>
</body>
</html>