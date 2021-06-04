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
	
	<title>Groupware</title>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<style>
.li-nav {
list-style: none;
float: right;
clear: left;
}
.right {
width: 900px;
margin-right:0px;
margin-bottom: 30px;
}
.float-container,nav {
margin-top: 10px;
margin-bottom: 20px;
height: 60px;
}
.loginSub{
margin-right: 37px;
text-align: right;
}
.logout {
margin-left: 10px;
}
.company-logo > a:link, a:visited {
  color : rgb(52, 152, 219);
text-decoration: none;
}
.company-logo {
font-size: 40px;
}

.loginSub > a:link, a:visited {
 color : rgb(52, 152, 219);
text-decoration: none;
}

	</style>
</head>
<body>
	<!-- 로고영역 -->
			<div class="text-center ">
				<div class="company-logo">
				<a href="<%=root%>/index.jsp">Groupware</a>
				</div>
			</div>
				
				
			<%if(isLogin) {%>
			<div class="loginSub"><%=employeesdto.getEmpName()%>님 환영합니다.
			<a class="logout" href="<%=root%>/login/logOut.gw">로그아웃</a>
			<%} %>
			</div>
			
			<!-- 네비게이션 영역 -->
			<nav>
			<!-- 메뉴 -->
			<ul class="menu">
			  <li>
					<a href="<%=root%>/mail/mailSend.jsp">공지 메일</a>
				</li>
				<li>
					<a href="<%=root%>/schedule/scheduleList.jsp">일정 목록</a>
				</li>
				<li>
					<a href="<%=root%>/address/addressList.jsp">주소록</a>
				</li>
				<li>
					<a href="<%=root%>/massage/massageInsert.jsp">메시지</a>
					<ul>
						<li><a href="<%=root%>/massage/massageReceiverList.jsp">수신함</a></li>
						<li><a href="<%=root%>/massage/massageSenderList.jsp">발신함</a></li>
					</ul>
				</li>
				<li>
					<a href="<%=root%>/approval/approvalList.jsp">전자 결재</a>
					<ul>
						<li><a href="<%=root%>/approval/approvalInsertMain.jsp">기안서 작성</a></li>
						<li><a href="<%=root%>/approval/approvalList.jsp">내 결재 관리</a></li>
					</ul>
				</li>
				<li>
					<a href="<%=root%>/attendance/attendanceMain.jsp">근태 관리</a>
					<ul>
						<li><a href="<%=root%>/attendance/attendanceMain.jsp">출퇴근 목록</a></li>
						<li><a href="<%=root%>/holiday/holidayList.jsp">휴가 목록</a></li>
					</ul>
				</li>
				<li>
					<a href="<%=root%>/board/boardmain.jsp">게시판</a>
					<ul>
						<li><a href="<%=root%>/board/boardmainNotice.jsp">공지사항</a></li>
						<li><a href="<%=root%>/board/boardmainFree.jsp">자유게시판</a></li>
						<li><a href="<%=root%>/board/boardmainQuestion.jsp">질문게시판</a></li>
						<li><a href="<%=root%>/board/myBoardList.jsp">내 게시글</a></li>
					</ul>
				</li>
				<li>
					<a href="#">마이 페이지</a> 
					<ul>
						<li><a href="<%=root%>/login/loginInfo.jsp">나의 정보</a></li>
						<li>
						<a href="<%=root%>/salary/salaryMain.jsp">급여</a>
						</li>
						<%if(isLogin){ %>
							<%if(isHeader) {%>
									<li><a href="<%=root%>/login/managerPage.jsp">관리자 페이지</a></li>
							<%} %>
				<%} else{%>
						<li><a href="<%=root%>/login/loginMain.jsp">로그인</a></li>
				<%} %>
					</ul>
				</li>
			  </ul>
		</nav>
	
	
	
	
	<!-- 가장 바깥 영역 -->
	<main>
	


	

		
		<!-- 컨텐츠영역 -->
		<section>
			<header></header>
			<article>
			