<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empNo = (String)session.getAttribute("id");

	employeesDao employeesDao = new employeesDao();
	employeesDto employeesDto = employeesDao.loginInfo(empNo);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		$("#holSubmit").click(function(){
			var startDay = document.getElementById("startDay").value;
			var endDay = document.getElementById("endDay").value;
			
			if(endDay - startDay > 0 ){ //시작일이 종료일보다 뒤 일경우
				if(<%=employeesDto.getHolidayCount()%> - endDay - startDay+1 > 0){ //남은 휴가 일수가 사용하려는 휴가 일수보다 클경우만
					return true;
					
				}
			}
			else{
				window.alert("휴가 신청을 할 수 없습니다.\n 날짜를 조정하세요");
				return false;
			}
		});
		
	});
	
</script>

<div class="container-600 center">
	<form action="holidayInsert.gw" method="post">
	
		<div class="row text-left">
			<label>휴가 종류</label>
			<select name="holidayType" class="form-input form-input-inline">
				<option value="">선택하세요</option>
				<option>연차</option>
				<option>병가</option>
				<option>휴가</option>
				<option>조의</option>
				<option>기타</option>
			</select>
		</div>
		
		<div class="row text-left">
			<label>시작일</label>
			<input type="date" name="holidayStart" class="form-input form-input-underline" id="startDay">
		</div>
		<div class="row text-left">
			<label>종료일</label>
			<input type="date" name="holidayEnd" class="form-input form-input-underline" id="endDay">
		</div>
		
		<div class="row text-left">
			<label>휴가 내용</label>
			<textarea name="holidayContent" rows="15" class="form-input"></textarea>
		</div>
		
		<div class="row">
			<input type="submit" value="신청" class="form-btn form-btn-positive" id="holSubmit">
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>