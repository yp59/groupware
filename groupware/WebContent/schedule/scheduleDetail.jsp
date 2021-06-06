<%@page import="groupware.beans.DepartmentDao"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//리스트->디테일: sc_no

int sc_no= Integer.parseInt(request.getParameter("sc_no"));
ScheduleDao scheduleDao = new ScheduleDao();
ScheduleDto scheduleDto = scheduleDao.detail(sc_no);

            
boolean amI = request.getSession().getAttribute("id").equals(scheduleDto.getEmpNo());


//empNo->emoName : body에서 작성
employeesDao empDao = new employeesDao(); 


boolean authLev = (int)request.getSession().getAttribute("authorityLevel")==1|| (int)request.getSession().getAttribute("authorityLevel")==2;




%>


<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

</script>
<style>
	h2{
/* 		color:gray; */
		text-align:center;
	}
</style>


<div class="container-800">
	<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">세부일정</h2>
	<h4>번호:<%=scheduleDto.getSc_no()%></h4>
	<h4>상태:<%=scheduleDto.getSc_state()%></h4>
	
	
	<%if(amI||authLev) {%>
		<!-- 완료기능 form 영역 -->
		<%if(scheduleDto.getSc_state().equals("진행중")) {%>
		<div class="row">
			<form action ="scheduleComplete.kh" method="post">
				<input type="hidden" value="<%=scheduleDto.getSc_no()%>" name="sc_no">
				<input type="hidden" value="<%=scheduleDto.getSc_state()%>" name="sc_state">
				<input type="submit" value="완료하기" class="form-btn check-btn">
			</form>
		</div>
		<%} else{%>
		<div class="row">
			<form action ="scheduleComplete.kh" method="post">
				<input type="hidden" value="<%=scheduleDto.getSc_no()%>" name="sc_no">
				<input type="hidden" value="<%=scheduleDto.getSc_state()%>" name="sc_state">
				<input type="submit" value="취소하기" class="form-btn check-btn">
			</form>
		</div>
		<%} %>
		<!--  -->
	<%} %>
	
	
	
	<!-- 상세보기 테이블 영역 -->
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>일정명</th>
				<td><%=scheduleDto.getSc_name() %></td>
			</tr>
			<tr>
				<th>담당부서</th>
				<td><%=scheduleDto.getDep_name() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=empDao.getName(scheduleDto.getEmpNo()) %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=scheduleDto.getSc_made() %></td>
			</tr>
			<tr>
				<th>마감일</th>
				<td><%=scheduleDto.getSc_deadline() %></td>
			</tr>
			<tr>
				<th>세부일정</th>
				<td>
					<pre><%=scheduleDto.getSc_content() %></pre>
				</td>
			</tr>
		</table>
	</div>
	<div class="row">
		<%if(amI||authLev) {%>
		<a class="link-btn" href="scheduleEdit.jsp?sc_no=<%=sc_no%>">수정</a>
		<a class="link-btn" href="scheduleDelete.kh?sc_no=<%=sc_no%>">삭제</a>
		<%} %>
		<a class="link-btn" href="scheduleList.jsp">목록</a>
	</div>
	
</div>




<jsp:include page="/template/footer.jsp"></jsp:include>