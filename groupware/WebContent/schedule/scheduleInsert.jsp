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

<style>


	.form-textarea{
		width:100%;
		min-height:300px; 
	
	
	}
	
	
	
	.form-select{
		width:15%;
		padding:0.5rem;
		outline:none;
	}
	
	
	.row{
		text-align:left;
	
	}

</style>


<div class="container-600">
	<div class="text-center">
		<h2>일정등록하기</h2>
	</div>
	<div> <!-- 일정 제목, 일정 내용, 데드라인 -->
		<form action="scheduleInsert.kh" method="post">
			<div class="row">
				<label for="name">제목</label>
				<input id="name" name="sc_name" type="text" placeholder="제목을 입력하세요" required class="form-input">
			</div>
			<div class="row">
				<label class="text-left">담당부서</label>
				<select name="dep_name" class="form-select">
					<%for(DepartmentDto departmentDto:list){%>
					<option><%=departmentDto.getDep_name() %></option>
					<%} %>
				</select>
			</div>
			<div class="row">
				<label for="deadline">마감날짜</label>
				<input id="deadline" type="date" name="sc_deadline" required class="form-input">
			</div>
			<div class="row">
				<label for="content">세부내용</label>
				<textarea name="sc_content" class="form-textarea"></textarea>
			</div>
			<input type="submit" value="일정등록" class="form-btn">
		</form>
	</div>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>