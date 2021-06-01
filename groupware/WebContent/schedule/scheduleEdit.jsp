<%@page import="java.util.List"%>
<%@page import="groupware.beans.DepartmentDao"%>
<%@page import="groupware.beans.DepartmentDto"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ScheduleDao scheduleDao = new ScheduleDao();
int sc_no =Integer.parseInt(request.getParameter("sc_no"));
ScheduleDto scheduleDto = scheduleDao.detail(sc_no);


DepartmentDao departmentDao = new DepartmentDao();
List<DepartmentDto>list = departmentDao.list();


%>

<jsp:include page="/template/header.jsp"></jsp:include>




<div class="container-600">
	<div class="row">
		<h2>일정 수정</h2>
	</div>
	<div class="row">
		<form action="scheduleEdit.kh" method="post"> 
			<div class="row">
				<input type="hidden" value="<%=scheduleDto.getSc_no()%>" name="sc_no">
			</div>
			
			<div class="row">
				제목<input type="text" value="<%=scheduleDto.getSc_name() %>" name="sc_name">
			</div>
			
			<div>
				<label>담당부서</label>
				<select name="dep_name">
					<option><%=scheduleDto.getDep_name() %></option>			
					
					
					<%for(DepartmentDto departmentDto:list){%>
						<%if(!departmentDto.getDep_name().equals(scheduleDto.getDep_name())) {%>
						<option><%=departmentDto.getDep_name() %></option>
						<%} %>
					<%} %>
				</select>
			</div>
			
			<div class="row">
				내용<textarea name="sc_content"><%=scheduleDto.getSc_content() %></textarea>
			</div>
			<div class="row">
				<input type="submit" value="수정">
			</div>
		
		
		</form>
	
	
	</div>
	<div>
		<h4>로그인상태: <%=request.getSession().getAttribute("id") %></h4>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>
