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
	
	int authLev = (int)request.getSession().getAttribute("authorityLevel");
	boolean isHeader = authLev ==1; //사장님만
%>        
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>groupware5</title>
	
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	
	<!-- 가장 바깥 영역 -->
	<main>
	<header>
	<div class="text-center"><h2><a href="<%=root%>/index.jsp">groupware5</a></h2></div>
	<%if(isLogin){ %>
		<div class="row text-right"><%=employeesdto.getEmpName()%>님 환영합니다.
			<a href="<%=root%>/login/logOut.gw">로그아웃</a>
			<div class = "row"><a href="<%=root%>/login/loginInfo.jsp">회원정보</a></div>
			
				<!-- 사원등록: 사장님만 가능 -->
				<%if(isHeader) {%>
					<div class="row text-right">
						<a href="<%=root%>/login/signUp.jsp" class="link-btn">사원등록</a>
					</div>
				<%} %>
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
				<a href="#">분류</a>
				</li>
				<li class = "menu menu_detail">
				<a href="#">분류</a>
				</li>
			</ul>
			</ul>
			<ul>
				<li class = "menu menu-title">

					<a href="<%=root%>/salary/salaryMain.jsp">급여</a>
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
					<a href="<%=root%>/mail/mailList.jsp">메일</a>
				</li>
			<ul>
				<li class = "menu menu_detail">
				<a href="<%=root%>/mail/mailSend.jsp">메일보내기</a>
				</li>
			</ul>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section>
	