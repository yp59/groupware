<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.boardDao"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//실제 context path를 구하는 명령
	//template 페이지의 모든 경로는 절대경로로 작성해야 한다. 가급적 절대경로로 작성하는 것을 추천
	String root = request.getContextPath();
	
	String empNo=(String)session.getAttribute("id");
	//String에 담는게 편함
	boolean isLogin=empNo!=null;
	
	employeesDao employeesdao = new employeesDao();
	employeesDto employeesdto = employeesdao.loginInfo(empNo);
	
%>        
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>groupware5</title>
	
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	
	<!-- 가장 바깥 영역 -->
	<main>
	<header>
	<div class="text-center"><h2><a href="<%=root%>/index.jsp">groupware5</a></h2></div>
	<%if(isLogin){ %>
		<div class="row text-right"><%=employeesdto.getEmpName()%>님 환영합니다.
			<a href="<%=root%>/login/logOut.gw">로그아웃</a>
			<div clss = "row"><a href="<%=root%>/login/loginInfo.jsp">회원정보</a></div>
		</div>
	<%} else{%>
		<div class = "row text-right">
			<a href="<%=root%>/login/loginMain.jsp"class="link-btn">로그인</a>
		</div>
	<%} %>
	</header>
		<!-- 사이드영역 -->
		<aside>
		<div class="menu">
			<ul>
				<li class = "menu menu-title">
					<a href="#">제목</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">
					<a href="#">제목</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/board/boardmain.jsp">게시판</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="<%=root%>/board/boardmainNotice.jsp">공지사항</a>
				</li>
				<li class = "menu menu_detail">
				<a href="<%=root%>/board/boardmainFree.jsp">자유게시판</a>
				</li>
				<li class = "menu menu_detail">
				<a href="<%=root%>/board/boardmainQuestion.jsp">질문게시판</a>
				</li>
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/attendance/attendanceMain.jsp">출퇴근</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/holiday/holidayList.jsp">휴가</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
			</ul>
			</ul>
		</div>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section>
	