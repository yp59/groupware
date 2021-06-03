<%@page import="groupware.beans.SalaryAuthorityDao"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.SalaryDao"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.PositionSalaryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String empNo = (String)request.getParameter("empNo");
	String salaryDate = (String)request.getParameter("salaryDate");
	 
     
	 SalaryAuthorityDao salaryAuthorityDao = new SalaryAuthorityDao();
	 SalaryDto salaryDto = salaryAuthorityDao.get(empNo, salaryDate);
	
	AttendanceDao attendanceDao = new AttendanceDao();
	int sumOvertime = attendanceDao.getOvertime(empNo);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<div class="container-600 center">
	<div class="row">
		<h2>급여 명세서 수정</h2>
	</div>

	<form action="salaryUpdate.gw" method="post">


			<div class="row text-left">
			<label>사원 이름</label>
			<%=salaryDto.getEmpName()%> 
			</div>		
			<div class="row text-left">
				<label>지급일</label>
				<%=salaryDto.getSalaryDate()%>
			</div>	
			<div class="row text-left">
				<label>기본급</label>
				<input type="text" name="salaryPay" value="<%=salaryDto.getSalaryPay()%>">
			</div>
			<div class="row text-left">
				<label>추가 근무 수당</label>
				<input type="text" name="salaryOvertime" value= "<%=salaryDto.getSalaryOvertime()%>">
			</div>
			<div class="row text-left">
				<label>식비</label>
				<input type="text" name="salaryMeal" value="<%=salaryDto.getSalaryMeal()%>">
			</div>		
			<div class="row text-left">
				<label>교통비</label>
				<input type="text" name="salaryTransportation" value="<%=salaryDto.getSalaryTransportation()%>">
			</div>			
			<div class="row">
				<input type="submit" value="수정완료" class="form-btn form-btn-positive" >
			</div>
		
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>