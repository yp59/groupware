
<%@page import="java.util.List"%>

<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// addressDetail에서 파라미터 받아옴.
String empNo = request.getParameter("empNo");


employeesDao empDao = new employeesDao();
employeesDto empDto = empDao.loginInfo(empNo);




%>
    
<jsp:include page="/template/header.jsp"></jsp:include>


<script>


</script>

<h2>사원정보 수정</h2>

<form action="signUpEdit.kh" method="post"><!-- 회원정보 수정 입력란 -->
		<input type = "text" name="empNo" value="<%=empNo%>">


이름 : <input value="<%=empDto.getEmpName() %>" type="text" name="empName"  required disabled="disabled">

전화번호 : <input type="text" value="<%=empDto.getEmpPhone()%>" disabled="disabled">

이메일 : <input type="text" name="email" value="<%=empDto.getEmail()%>"disabled="disabled">
	
주소: <input type="text" name="address" value="<%=empDto.getAddress()%>" disabled="disabled">

부서:<input type="text" value=<%=empDto.getDepartment()%> name="department" required="required">
		
직급:<input type="text" value=<%=empDto.getPono() %> name="po_no" value="<%=empDto.getPono() %>" required="required">


<input type="submit" value="사원정보 수정">
</form>
<a href = "<%=request.getContextPath()%>/login/loginInfo.jsp">취소</a>
<jsp:include page="/template/footer.jsp"></jsp:include>