<%@page import="groupware.beans.HolidayDto"%>
<%@page import="groupware.beans.HolidayDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empNo = (String)session.getAttribute("id");
	int holNo = Integer.parseInt(request.getParameter("holNo"));
	HolidayDao holidayDao = new HolidayDao();
	HolidayDto holidayDto = holidayDao.get(empNo, holNo);
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

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
			<input type="date" name="holidayStart" class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>휴가 내용</label>
			<textarea name="holidayContent" rows="15" class="form-input"></textarea>
		</div>
		<div class="row text-left">
			<label>종료일</label>
			<input type="date" name="holidayEnd" class="form-input form-input-underline">
		</div>
		
		
		
		<div class="row">
			<input type="submit" value="수정" class="form-btn form-btn-positive">
		</div>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>