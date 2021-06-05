<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.HolidayDto"%>
<%@page import="groupware.beans.HolidayDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empNo = (String)session.getAttribute("id");
	int holNo = Integer.parseInt(request.getParameter("holNo"));
	HolidayDao holidayDao = new HolidayDao();
	HolidayDto holidayDto = holidayDao.get(empNo, holNo);
	int holCount = holidayDao.count(empNo, holNo);
	
	employeesDao employeesDao = new employeesDao();
	employeesDao.holidayPlus(empNo, holCount);
	employeesDto employeesDto = employeesDao.loginInfo(empNo);
	
%>
<style>
	.container-600{
		position:relative;
		top:30px;
	}
</style> 
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		//목표 : 시작하자마자 휴가 종류를 holidayDto의 값으로 설정
		$("select[name=holidayType]").val("<%=holidayDto.getHolType()%>");
	
		//이거 왜 안되지...
		$("input[name=holidayStart]").val("<%=holidayDto.getHolStart()%>");
		$("input[name=holidayStartEnd]").val("<%=holidayDto.getHolEnd()%>");
		
		$("#holSubmit").click(function(){
			var startArr = $('#startDay').val().split("-");
			var endArr = $('#endDay').val().split("-");
			
			var startDay = new Date(startArr[0], startArr[1], startArr[2]);
			var endDay = new Date(endArr[0], endArr[1], endArr[2]);
			
			
			if(startDay.getTime() > endDay.getTime()){ //시작일이 종료일보다 뒤 일경우
				console.log((endDay)/ 1000 / 60 / 60 / 24);
				window.alert("휴가 신청을 할 수 없습니다.\n날짜를 조정하세요");
				return false;
			
			}
			
			//남은 휴가 일수가 사용하려는 휴가 일수보다 작은 경우
			else if(<%=employeesDto.getHolidayCount()%>
					- ((endDay.getTime() - startDay.getTime())/ 1000 / 60 / 60 / 24 + 1) < 0){	
				window.alert("남은 휴가 일수를 초과하였습니다.\n날짜를 조정하세요");
				return false;
			}
			else{
				return true;
			}
			
		});
	});
</script>
<div class="container-600">
	
	<div class="row">
		<h2>아이템 정보 수정</h2>
	</div>
	
	<form action="holidayEdit.gw" method="post">
		<input type="hidden" name="holidayNo" value="<%=holidayDto.getHolNo()%>">
	
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
			<input type="submit" value="수정" class="form-btn form-btn-positive" id="holSubmit">
		</div>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>