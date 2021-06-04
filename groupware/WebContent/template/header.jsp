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

	</style>
</head>
<body>
	<!-- 로고영역 -->
			<div class="text-center ">
				<div class="company-logo">
				<a href="<%=root%>/index.jsp">Groupware</a>
				</div>
			
				<!-- 관리자기능 --> 
				<div class ="" style = float:left; >
				
				
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
					<a href="<%=root%>/mail/mailSend.jsp">공지메일</a>
				</li>
				<li>
					<a href="<%=root%>/massage/massageReceiverList.jsp">메세지</a>
				</li>
				<li>
					<a href="<%=root%>/address/addressList.jsp">주소록</a>
				</li>
				<li>
					<a href="<%=root%>/approval/approvalList.jsp">전자결재</a>
					<ul>
						<li><a href="<%=root%>/approval/approvalInsertMain.jsp">기안서 작성</a></li>
						<li><a href="<%=root%>/approval/approvalList.jsp">내 결재 관리</a></li>
					</ul>
				</li>
				<li>
					<a href="#">근태 관리</a>
					<ul>
						<li><a href="<%=root%>/attendance/attendanceMain.jsp">출퇴근 목록</a></li>
						<li><a href="<%=root%>/holiday/holidayList.jsp">휴가 목록</a></li>
						<li>
						<%if(isHeader || authLev == 2) {%> <!-- 권한1 또는 권한 2라면 -->
							<a href="<%=root%>/attendance/attendanceAuthorityMain.jsp">출퇴근 관리</a>
						<%}%>
					</li>
					</ul>
				</li>
				<li>
					<a href="#">게시판</a>
					<ul>
						<li><a href="<%=root%>/board/boardmainNotice.jsp">공지사항</a></li>
						<li><a href="<%=root%>/board/boardmainFree.jsp">자유게시판</a></li>
						<li><a href="<%=root%>/board/boardmainQuestion.jsp">질문게시판</a></li>
					</ul>
				</li>
				<li>
					<a href="#">마이페이지</a> 
					<ul>
						<li><%if(isHeader) {%>
						<a href="<%=root%>/salary/salaryAuthority.jsp">급여</a>
					<%}else{ %>
						<a href="<%=root%>/salary/salaryMain.jsp">급여</a>
					<%} %></li>
						<li><a href="<%=root%>/login/loginInfo.jsp">나의 정보</a></li>
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
			