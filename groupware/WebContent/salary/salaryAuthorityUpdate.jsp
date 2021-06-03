<%@page import="groupware.beans.SalaryDao"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.beans.PositionSalaryDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.PositionSalaryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String empNo = (String)session.getAttribute("id");
	String salaryDate = (String)request.getParameter("salaryDate");

	SalaryDao salaryDao = new SalaryDao();
	SalaryDto salaryDto = salaryDao.get(empNo, salaryDate);
	
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
			<input type="text" name="empName" value="<%=salaryDto.getEmpName()%>">
		</div>		
		<div class="row text-left">
				<label>지급일</label>
				<input type="date" name="payDate" class="form-input form-input-underline">
		</div>	
			<div class="row text-left">
				<label>기본급</label>
				<input type="text" name="payBasic" class="form-input form-input-underline">
			</div>
			
			<div class="row text-left">
				<label>추가 근무 시간당 수당</label>
				<input type="text" name="payOvertime" class="form-input form-input-underline">
				<label>추가 근무 시간</label>
				<span class="overtime"></span>
			</div>
			
			<div class="row text-left">
				<label>총 추가 근무 수당</label>
				<input type="text" name="totalPayOvertime" class="form-input form-input-underline">
			</div>
			
			<div class="row text-left">
				<label>식비</label>
				<input type="text" name="payMeal" class="form-input form-input-underline">
			</div>
			
			<div class="row text-left">
				<label>교통비</label>
				<input type="text" name="payTransportation" class="form-input form-input-underline">
			</div>
			
			<div class="row">
				<input type="submit" value="작성 완료" class="form-btn form-btn-positive" id="holSubmit">
			</div>
		
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>