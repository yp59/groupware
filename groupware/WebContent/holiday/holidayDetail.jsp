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
<style>
	.container-600{
		position:relative;
		top:30px;
	}
</style>   
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">

	<div class="row">
		<h2>휴가 내역</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>휴가 번호</th>
				<td><%=holidayDto.getHolNo()%></td>
			</tr>
			<tr>
				<th>사원</th> <!-- 이름으로 바꾸기! -->
				<td><%=holidayDto.getEmpNo()%></td>
			</tr>
			<tr>	
				<th>휴가 종류</th>
				<td><%if(holidayDto.getHolType()==null) {%>
					기타
				<%} else{ %>
				<%=holidayDto.getHolType()%>
				<%} %>
				</td>
			</tr>
			<tr>
				<th>휴가 내용</th>
				<td><%if(holidayDto.getHolContent() != null){%>
				<%=holidayDto.getHolContent()%>
				<%} %></td>
			</tr>
			<tr>
				<th>시작일</th>
				<td><%=holidayDto.getHolStart().substring(0,10)%></td>
			</tr>
			<tr>
				<th>종료일</th>
				<td><%=holidayDto.getHolEnd().substring(0,10)%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=holidayDto.getHolWriteDate()%></td>
			</tr>
		</table>
	</div>
	
	<div class="row text-right">
		<a href="holidayList.jsp" class="link-btn">목록</a>
		<a href="holidayEdit.jsp?holNo=<%=holNo%>" class="link-btn">수정</a>
		<a href="holidayDelete.gw?holNo=<%=holNo%>" class="link-btn">삭제</a>	
	</div>
	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>