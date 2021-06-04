<%@page import="groupware.beans.ScheduleIngDto"%>
<%@page import="groupware.beans.ScheduleIngDao"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@page import="groupware.beans.ScheduleEndDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.ScheduleEndDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");//

ScheduleIngDao scheduleIngDao = new ScheduleIngDao();
List<ScheduleIngDto> list_ing =scheduleIngDao.index_schedule();




////////////////////////////////////////////////////////////////////////

%>




    
<jsp:include page="/template/header.jsp"></jsp:include>

<%-- <jsp:include page="/template/section.jsp"></jsp:include> --%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 


	
	

<!-- </script> -->




<!-- 상단영역 -->
	<div class="float-container">
		<!-- 출석영역 -->
		<div class="multi-container">
			<table class="table table-border">
				<tr>
					<th width="100">출근(버튼)</th>
					<td></td>
					<th width="100">출근시간</th>
					<td></td>
				</tr>
			</table>
			
			<table class="table table-border">
				<tr>
					<th width="100">퇴근(버튼)</th>
					<td></td>
					<th width="100">퇴근시간</th>
					<td></td>
				</tr>
			</table>
		
		
		</div>
		<!-- 출석영역 끝 -->
		
		<!-- 사진과 정보 영역 -->
		<div class="multi-container">
			<div class="text-center">
				<img alt="사진영역" src="<%=request.getContextPath()%>/imageFile/picture.png" width="200" height="200" >
			</div>
			<br>
			<div class="text-center">이름</div>
			<div class="text-center">이메일</div>
			
		
		
		</div>
		<!-- 사진과 정보 영역 끝 -->
	
</div>
<!-- 상단영역 끝 -->






<!-- 게시글 영역 -->
<div class="float-container">
	
	


	<!-- 진행영역 -->
	<div class="multi-container"><div class="row">
		<table class="table table-border">
			<thead>
				<tr>
<!-- 					<th>상황</th> -->
<!-- 					<th>번호</th> -->
					<th>담당부서</th>
					<th>제목</th>
<!-- 					<th>작성자</th> -->
<!-- 					<th>작성일</th> -->
					<th>마감일</th>
				</tr>
			</thead>
			<tbody>
				<%for(ScheduleIngDto scheduleIngDto:list_ing) {%>
				<tr>
<%-- 					<td><%=scheduleIngDto.getSc_state() %></td> --%>
<%-- 					<td><%=scheduleIngDto.getSc_no() %></td> --%>
					<td><%=scheduleIngDto.getDep_name() %>
					<td>
						<a href="<%=request.getContextPath()%>/schedule/scheduleDetail.jsp?sc_no=<%=scheduleIngDto.getSc_no()%>">
						<%=scheduleIngDto.getSc_name() %>
						</a>
					</td>
<%-- 					<td><%=scheduleIngDto.getEmpName() %></td> --%>
<%-- 					<td><%=scheduleIngDto.getSc_made().substring(0,10) %></td> --%>
					<td><%=scheduleIngDto.getSc_deadline().substring(0,10) %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<!-- 멀티컨테이너 끝 -->
	</div>
	
	
	
	<div class="multi-container">
	<!-- 멀테컨테이너 시작 -->
		
		공지글 영역
		<img alt="공지글영역" src="https://via.placeholder.com/30x30?text=G" width="300" height="100">
	
	
	<!-- 멀티컨테이너 끝 -->
	</div>

	
	

<!--  -->
</div>	











<jsp:include page="/template/footer.jsp"></jsp:include>     