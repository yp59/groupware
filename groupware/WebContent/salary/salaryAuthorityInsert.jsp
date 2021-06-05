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

<style>
	.container-400{
		position:relative;
		top:50px;
	}
	.sumOvertime{
		border-radius:5px;
		padding:0.3em;
		border:1px solid #3498DB !important;
	}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<%
	AttendanceDao attendanceDao = new AttendanceDao(); 
	for(PositionSalaryDto positionSalary : positionSalaryList){
		int overtime = attendanceDao.getOvertime(positionSalary.getEmpNo());
%>
<script>
	$(function(){
		$("select[name=employeesChoice]").on("input", function(){
			var employee = $(this).val();
			if(<%=positionSalary.getEmpNo()%> == employee){
				$("input[name=payBasic]").val("<%=positionSalary.getSalaryPay()%>");
				$("input[name=payOvertime]").val("<%=positionSalary.getSalaryOvertime()%>");
				$(".sumOvertime").text("추가 근무 시간 : <%=overtime%>시간");
				$(".totalPayOvertime").text("<%=positionSalary.getSalaryOvertime()%>*<%=overtime%>원");
				$("input[name=payMeal]").val("<%=positionSalary.getSalaryMeal()%>");
				$("input[name=payTransportation]").val("<%=positionSalary.getSalaryTransportation()%>");
				$(".hiddenEmpNo").val("<%=positionSalary.getEmpNo()%>")
				$(".hiddenPoNo").val("<%=positionSalary.getPoNo()%>")
			}
		});
	});
	
</script>
<%} %>
<script>
	function goBack(){
		window.history.back();
	}
</script>
<div class="container-400 center">
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
		
	
		<input type="hidden" name="empNo" class="hiddenEmpNo" value="">
		<input type="hidden" name="poNo" class="hiddenPoNo" value="">
		
		<div class="row text-left">
			<label>기본급</label>
			<input type="text" name="payBasic" class="form-input form-input-underline">
		</div>
		
		<div class="row text-left">
			<label>추가 근무 시간당 수당</label>
			<input type="text" name="payOvertime" class="form-input form-input-underline">
			<div class="sumOvertime">
			<label>추가 근무 시간 : </label>
			</div>
		</div>
		
		<div class="row text-left">
			<label>총 추가 근무 수당</label>
			<span class="totalPayOvertime"></span>
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
			<input type="submit" value="완료" class="form-btn form-btn-inline">
			<input type="button" value="취소" class="form-btn btn-cancle" onclick="goBack();" >
		</div>
	
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>