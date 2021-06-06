<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.container-500{
		position:relative;
		top:50px;
		border:1px solid black !important;
		border-radius: 15px;
	}
	.link-btn2{
		width:40%;
		padding:1.5em !important;
		margin:3%;
		
	}
	.row{
	border: none;
	}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container-500">
	<div class="row" style="border: none;">
		<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">관리자페이지</h2>	
	</div>
	
	<div class="row" style="border: none;">
		<a href="<%=request.getContextPath()%>/address/addressList.jsp?manage=1" class="link-btn2">인사 관리</a>
	</div>
	<div class="row" style="border: none;">
		<a href="<%=request.getContextPath()%>/salary/salaryAuthority.jsp" class="link-btn2">급여 관리</a>
	</div>
	<div class="row" style="border: none;">
		<a href="<%=request.getContextPath()%>/attendance/attendanceAuthorityMain.jsp" class="link-btn2">근태 관리</a>
	</div>
</div>