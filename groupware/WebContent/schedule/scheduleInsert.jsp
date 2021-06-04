<%@page import="groupware.beans.DepartmentDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.DepartmentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
DepartmentDao departmentDao = new DepartmentDao();
List<DepartmentDto>list = departmentDao.list();



%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>일정등록하기</h2>
	</div>
	<div class="row"><!-- 일정 제목, 일정 내용, 데드라인 -->
		<form action="scheduleInsert.kh" method="post">
			<div class="row">
				<label for="name">제목</label>
				<input id="name" name="sc_name" type="text" placeholder="제목을 입력하세요" required>
			</div>
			<div>
				<label>담당부서</label>
				<select name="dep_name">
					<%for(DepartmentDto departmentDto:list){%>
					<option><%=departmentDto.getDep_name() %></option>
					<%} %>
				</select>
			</div>
			<div class="row">
				<label for="deadline">마감날짜</label>
				<input id="deadline" type="date" name="sc_deadline" required>
			</div>
			<div class="row">
				<label for="content">세부내용</label>
				<textarea name="sc_content"></textarea>
			</div>
			<input type="submit" value="일정등록" class="form-btn">
		</form>
	</div>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>