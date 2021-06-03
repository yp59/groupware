<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.beans.PositionSalaryDto"%>
<%@page import="groupware.beans.PositionSalaryDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empNo = (String)session.getAttribute("id");
	
	PositionSalaryDao positionSalaryDao = new PositionSalaryDao();
	List<PositionSalaryDto> positionSalaryList = positionSalaryDao.list();
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<div class="container-600 center">
	<div class="row">
		<h2>급여 명세서 작성</h2>
	</div>

	<form action="salaryInsert.gw" method="post">

		<div class="row text-left">
			<label>사원 선택</label>
			<select name="employeesChoice" class="form-input form-input-inline">
				<option value="">선택하세요</option>
				<%for(PositionSalaryDto positionSalary : positionSalaryList){%>
					<option value="<%=positionSalary.getEmpNo()%>"><%=positionSalary.getEmpName()%></option>
				<% } %>
			</select>
		</div>
		
		
		<%for(PositionSalaryDto positionSalary : positionSalaryList){
			AttendanceDao attendanceDao = new AttendanceDao();
			int overtime = attendanceDao.getOvertime(positionSalary.getEmpNo());
		%>
			<script>
				$(function(){
					$("select[name=employeesChoice]").on("input", function(){
						var employee = $(this).val();
						if(<%=positionSalary.getEmpNo()%> == employee){
							$("input[name=payBasic]").val("<%=positionSalary.getSalaryPay()%>");
							$("input[name=payOvertime]").val("<%=positionSalary.getSalaryOvertime()%>");
							$("input[name=payMeal]").val("<%=positionSalary.getSalaryMeal()%>");
							$("input[name=payTransportation]").val("<%=positionSalary.getSalaryTransportation()%>");
							overtimeInsert();
						}
					});
				});
			</script>
			
			<script>
				function overtimeInsert(){
					$(".overtime").text("추가 근무 시간 : <%=overtime%>시간");
					$("input[name=totalPayOvertime]").val("<%=positionSalary.getSalaryOvertime()%>*<%=overtime%>");
				}
			</script>
		<%} %>
			
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