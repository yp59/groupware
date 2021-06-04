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
	
	int authLev;
	try{
	
	authLev = (int)request.getSession().getAttribute("authorityLevel");
	
	}catch(Exception e){
		authLev = 0;	
		
		
	}
	boolean isHeader = authLev ==1; //사장님만
%>        
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>groupware5</title>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<style>
li {
	list-style: none;
	float: left;
}
.right {
width: 830px;
margin-right:0px;
margin-bottom: 15px;
}
.float-container,nav {
margin-bottom: 10px;
height: 70px;
}

	</style>
</head>
<body>
	<!-- 로고영역 -->
			<div class="text-center ">
				<div class="company-logo">
				<a href="<%=root%>/index.jsp">Groupware</a>
				</div>
			
				<!-- 관리자기능 --> 
				<div style = float:left; >
				
				
				<%if(isLogin){ %>
							<%if(isHeader) {%>
								<div class="row text-right">
									<a href="<%=root%>/login/managerPage.jsp" class="link-btn">관리자페이지</a>
								</div>
							<%} %>
					</div>
				<%} else{%>
					<div class = "row text-right">
						<a href="<%=root%>/login/loginMain.jsp"class="link-btn">로그인</a>
					</div>
				<%} %>
				
				</div>
				<!--  -->
				
				
				
				<%if(isLogin) {%>
				<div class="text-right"><%=employeesdto.getEmpName()%>님 환영합니다.
				<div><a href="<%=root%>/login/logOut.gw">로그아웃</a></div>
				<%} %>
			</div>
			</div>
			
			<!-- 네비게이션 영역 -->
			<div class="float-container nav">
				<div class="right">
					<ul>
					<li><a href="<%=root%>/mail/mailSend.jsp">공지메일</a></li>
					</ul>
					<ul>
					<li><a href="<%=root%>/massage/massageReceiverList.jsp">메세지</a></li>
					</ul>
					<ul>
					<li><a href="<%=root%>/approval/approvalList.jsp">전자결재</a></li>
					</ul>
					<ul>
					<li><a href="<%=root%>/schedule/scheduleList.jsp">일정관리</a></li>
					</ul>
					<ul>
					<li><a href="#">근태관리</a></li>
					</ul>
					<ul>
					<li><a href="<%=root%>/board/boardmain.jsp">게시판</a></li>
					</ul>
					<ul>
					<li><a href="<%=root%>/login/loginInfo.jsp">마이페이지</a></li>
					</ul>
				</div>
			</div>
	
	
	
	
	<!-- 가장 바깥 영역 -->
	<main>
	


	

		
		<!-- 컨텐츠영역 -->
		<section>
			<header></header>
			<article>
			