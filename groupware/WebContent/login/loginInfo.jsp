<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%String empNo = (String)session.getAttribute("id");
    
    employeesDao employeesdao = new employeesDao();
    employeesDto employeesdto = employeesdao.loginInfo(empNo);
   
    %>
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>

<div class="container-900">
<table class="table table-border table-striped">
	<tbody>
		<tr>
			<th>사원번호</th>
			<td> <%=employeesdto.getEmpNo()%></td>
		</tr>	
		<tr>
			<th>직급</th>
			<td><%=employeesdao.position(empNo)%></td>
		</tr>	
		<tr>
			<th>이름</th>
			<td><%=employeesdto.getEmpName()%></td>
		</tr>
		<tr>
			<th>입사일</th>
			<td><%=employeesdto.getJoinDate()%></td>
		</tr>
		<tr>
			<th>번호</th>
			<td><%=employeesdto.getEmpPhone()%></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=employeesdto.getEmail()%></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><%=employeesdto.getAddress()%></td>
		</tr>	
	</tbody>
</table>
</div>

<div class="container-900 text-right">
<a href = "<%=request.getContextPath()%>/login/loginInfoEdit.jsp">회원정보 수정</a><!-- 회원정보 수정 페이지로 이동 -->
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>