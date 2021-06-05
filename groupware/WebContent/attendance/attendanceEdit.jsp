<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String empNo = (String)request.getParameter("empNo");
	String attDate = (String)request.getParameter("attDate");
	
	AttendanceDao attendanceDao = new AttendanceDao();
	AttendanceDto attendanceDto = attendanceDao.get(empNo, attDate);
%>    
<style>
	.container-400{
		position:relative;
		top:50px;
	}
	.attend, .leave{
		margin-top:10% !important;
	}
	.container-200{
		width:200px !important;
	}
	.who{
		border-radius:5px;
		border:1px solid #3498DB !important;
	}
	h4{
		margin-top:0.5em;
		margin-bottom:0.5em;
	}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<script>
	function goBack(){
		window.history.back();
	}
</script>
<div class="container-400">
	
	<div class="row">
		<h2>출퇴근 수정</h2>
	</div>
	<div class="row who">
		<h4><%=attendanceDto.getEmpName()%>님, <%=attendanceDto.getAttDate()%> 일자 수정</h4>
	</div>
	
	<form action="attendanceEdit.gw" method="post">
		<input type="hidden" name="empNo" value="<%=attendanceDto.getEmpNo()%>">
		<input type="hidden" name="attDate" value="<%=attendanceDto.getAttDate()%>">
	
		
		<div class="row text-left container-200">
			<div class="row attend text-left">
			<label>출근 시간</label>
			<input type="time" name="attend" class="form-input form-input-underline" value="<%=attendanceDto.getAttAttend()%>">
			</div>
			<div class="row leave text-left">
			<label class="leave">퇴근 시간</label>
			<input type="time" name="leave" class="form-input form-input-underline" value="<%=attendanceDto.getAttLeave()%>">
			</div>
		</div>
		
		
		<div class="row" style="margin-top:5%;">
			
			<input type="submit" value="수정" class="form-btn form-btn-inline" id="holSubmit">
			<input type="button" value="취소" class="form-btn btn-cancle" onclick="goBack();" >
		</div>
		
	</form>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>