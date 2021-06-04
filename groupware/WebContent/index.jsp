<%@page import="groupware.beans.boardDao"%>
<%@page import="groupware.beans.boardDto"%>
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


// 공지사항 리스트
boardDao boarddao = new boardDao();
// List<boardDto> list = boarddao.boardSearch(boType,type,keyword,startRow1,endRow1);

////////////////////////////////////////////////////////////////////////

%>




    
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 


	
	

<!-- </script> -->




<!-- 사진 영역 -->
<div>
사진 영역
<img alt="사진영역" src="https://via.placeholder.com/30x30?text=G" width="800" height="100">

</div>

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
		
<!-- 		공지글 영역 -->
		<div class="float-container">
	<table class="table table-border table-hover" >
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
			</tr>
<%-- 			<%for(boardDto boarddto : list){ %> --%>
<!-- 					<tr> -->
<%-- 						<%=boarddto.getBoTitle()%> --%>
<%-- 						<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>"></a> --%>
<%-- 						<td><%=boarddto.getEmpName()%></td> --%>
<%-- 						<td><%=boarddto.getBoDate().substring(0, 10)%></td> --%>
<%-- 					</tr><%}%> --%>

		</tbody>
	</table>
</div>
	
	
	<!-- 멀티컨테이너 끝 -->
	</div>

	
	

<!--  -->




<jsp:include page="/template/footer.jsp"></jsp:include>     