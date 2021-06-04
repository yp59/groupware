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
	<style>
	main, aside, section, article, header, footer{
			border:1px dotted black;
		}
		
		/* 리셋 스타일 */
		html, body{
			margin:0;
			padding:0;
		}
		
		main {
			width:1300px;
/* 			width:1200px; */
			margin:auto;
		}
		main::after {
			content:"";
			display:block;
			clear: both;
		}
		aside {
			float:left;
			width:10%;
/* 			width:20%; */
			min-height:500px;
			background-color: rgb(224,224,224);
		}
		
		aside a{
		 color:black;
		 text-decoration: none;
		}
		
		section {
			float:left;
			width:90%;
/* 			width:80%; */
			min-height:500px;
		
		}
		
		header {
			min-height: 0;
		}
		article {
			min-height:490px;
		}
		footer {
			min-height:10px;
		}
		
		.company-logo{
		 padding-top:10px;
		 padding-bottom:10px;
		 color:rgb(52, 152, 219);
		 font-style: sanserif;
		 font-size: 30px;
		 font-weight: bold;
		}
		
		
		.nav{
			background-color: rgb(52, 152, 219);
		}
		
		.float-container > .left {
			float:left;
		}
		.float-container > .right {
			float:right;
		}
		
		.float-container{
			padding:15px;
		}
		
		.float-container a {
			margin-left:3rem;
			padding-top:0.2rem;
			padding-bottom:0.2rem;
			display:inline-block;
			text-decoration: none;
			color:white;
			font-weight: bold;

		}
		
		.float-container a:hover{
			color:darkgray;
		}
	
	
	</style>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	
	<!-- 가장 바깥 영역 -->
	<main>
	
	<!-- 로고영역 -->
			<div class="text-center ">
				<div class="company-logo">
				groupware
				</div>
				<%if(isLogin) {%>
				<div class="text-right"><%=employeesdto.getEmpName()%>님 환영합니다.
				<div><a href="<%=root%>/login/logOut.gw">로그아웃</a></div>
				<%} %>
			</div>
			
			<!-- 네비게이션 영역 -->
			<div class="float-container nav">
				<div></div>
				<div class="right">
					<a href="#">전자결재</a>
					<a href="#">일정관리</a>
					<a href="#">근태관리</a>
					<a href="#">게시판</a>
					<a href="<%=root%>/login/loginInfo.jsp">마이페이지</a>
				</div>
			</div>
	
	
	
	<%if(isLogin){ %>
			
				<!-- 사원관리: 사장님만 가능 -->
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

	
		<!-- 사이드영역 -->
		<aside>
		<div class="menu">
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/approval/approvalList.jsp">전자결재</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="<%=root%>/approval/approvalInsertMain.jsp">기안서 작성</a>
				</li>
				<li class = "menu menu_detail">
				<a href="<%=root%>/approval/approvalList.jsp">내 결재 관리</a>
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
						<%if(isHeader || authLev == 2) {%> <!-- 권한1 또는 권한 2라면 -->
							<a href="<%=root%>/attendance/attendanceAuthorityMain.jsp">출퇴근관리</a>
						<%}%>
					</li>
					
				</ul>

			</ul>
			
			<ul>
				<li class = "menu menu-title">
					<%if(isHeader) {%>
						<a href="<%=root%>/salary/salaryAuthority.jsp">급여</a>
					<%}else{ %>
						<a href="<%=root%>/salary/salaryMain.jsp">급여</a>
					<%} %>
					
				</li>
			<ul>
				
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/holiday/holidayList.jsp">휴가</a>
					<a href="<%=root%>/schedule/scheduleList.jsp">일정 목록</a>

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
					<a href="<%=root%>/massage/massageInsert.jsp">쪽지 쓰기</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="<%=root%>/massage/massageSenderList.jsp">발신함</a>
				</li>
				<li class = "menu menu_detail">
				<a href="<%=root%>/massage/massageReceiverList.jsp">수신함</a>
				</li>
			</ul>
			</ul>
		</div>
		
		<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/address/addressList.jsp">주소록</a>
				
			</ul>
			
			<ul>
				<li class = "menu menu-title">
					<a href="<%=root%>/mail/mailList.jsp">공지메일</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="<%=root%>/mail/mailSend.jsp">공지메일발송</a>
				</li>
			</ul>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section>
			<header></header>
			<article>
			