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
    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-500">
	
	<div class="row">
		<h2>출퇴근 수정</h2>
	</div>
	<div class="row">
		<h4><%=attendanceDto.getEmpName()%>님, <%=attendanceDto.getAttDate()%> 일자 수정</h4>
	</div>
	
	<form action="attendanceEdit.gw" method="post">
		<input type="hidden" name="empNo" value="<%=attendanceDto.getEmpNo()%>">
		<input type="hidden" name="attDate" value="<%=attendanceDto.getAttDate()%>">
	
		
		<div class="row text-left">
			<label>출근 시간</label>
			<input type="time" name="attend" class="form-input form-input-underline" value="<%=attendanceDto.getAttAttend()%>" >
			<label>퇴근 시간</label>
			<input type="time" name="leave" class="form-input form-input-underline" value="<%=attendanceDto.getAttLeave()%>">
		</div>
		
		
		<div class="row">
			<input type="submit" value="수정" class="form-btn form-btn-positive" id="holSubmit">
		</div>
		
	</form>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>