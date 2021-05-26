<%@page import="java.util.List"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.employeesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
employeesDao empDao = new employeesDao();

List<employeesDto> empList =empDao.list();







%>



<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800">
	<div class="row">
		<form action ="massageInsert.kh" method ="post">
			<label for="name">제목</label>
			<input id="name" type ="text" name="m_name" required>		
			<br>
			<label for="content">내용</label>
			<textarea id="content" name="m_content"></textarea>
			<br>
			<label>수신자</label>
			<select name="e2_name">
				 <!-- 수신자 이름 보냄 -->
				<%for(employeesDto empDto : empList) {%>
					<option><%=empDto.getEmpName()%></option>
				<%} %>
			</select>
			<input type="submit" value ="보내기" class="form-btn">
		</form>
	</div>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>