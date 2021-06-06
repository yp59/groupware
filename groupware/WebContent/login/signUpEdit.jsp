
<%@page import="java.util.List"%>

<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// addressDetail에서 파라미터 받아옴.
String empNo = (String)request.getParameter("empNo");


employeesDao empDao = new employeesDao();
employeesDto empDto = empDao.loginInfo(empNo); 




%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.select-form{
	width: 400px;
	padding: .8em .5em;
	border: 1px solid #999;
	border-radius: 0px;
	margin-top:10px;
	border-color: rgb(52, 152, 219);
	margin-bottom:15px;
}
.form-input.form-input-underline {
	width:400px;
	border:none;
	border-bottom: 2px solid lightgray;
	margin-top:10px;
	margin-bottom:15px;
	
}
.input-postNumber{
	width:200px !important;
}
.input-tel{
	width:165px !important;
}
 
</style>

<script>
$(function(){
	$("select[name=department]").val("<%=empDto.getDepartment()%>");
		
});

$(function(){
	$("select[name=poNo]").val("<%=empDto.getPono()%>");
		
});



</script>

<div class="row" style="border: none;">
	<h2>인사정보</h2>
</div>


<div class="container-1200" style="border: none; border-top: 2px solid rgb(102, 177, 227); margin-bottom: 10px;">
<div class="text-right">
<a href = "<%=request.getContextPath()%>/address/addressList.jsp?manage=1" class="link-btn" style="margin-top:15px; ">취소</a></div>

<form action="signUpEdit.kh" method="post">
		
<div>
부서</div>
<div><select name ="department" class="select-form">
		<option>인사부</option>
		<option>총무부</option>
		<option>회계부</option>
		<option>기획부</option>
		<option>영업부</option>
	</select>
</div>
<div>		
직급</div>
<div>	
	<select name="poNo" class="select-form">
		<option value="1">사장</option>
		<option value="2">부장</option>
		<option value="3">차장</option>
		<option value="4">과장</option>
		<option value="5">대리</option>
		<option value="6">사원</option>
	</select>
</div>		
		
		
		
		
		<div>사번</div>
		
		<div><input style="margin-top: 10px;" type = "text" name="empNo" value="<%=empNo%>" required disabled="disabled" class="form-input form-input-underline">
</div>

<div>이름</div> 
<div>
<input value="<%=empDto.getEmpName() %>" type="text" name="empName"  required disabled="disabled" class="form-input form-input-underline">
</div>
<div>전화번호</div> 
<div>
<input type="text" value="<%=empDto.getEmpPhone()%>" disabled="disabled" class="form-input form-input-underline">
</div>
<div>이메일</div>
<div><input type="text" name="email" value="<%=empDto.getEmail()%>"disabled="disabled" class="form-input form-input-underline">
</div>	

<div>주소</div> 
<div>
<input type="text" name="address" value="<%=empDto.getAddress()%>" disabled="disabled" class="form-input form-input-underline">
</div>




<%-- <input type="text" value=<%=empDto.getDepartment()%> name="department" required="required"> --%>
<%-- <input type="text" value=<%=empDto.getPono() %> name="po_no" value="<%=empDto.getPono() %>" required="required"> --%>

<div>
<input type="submit" value="인사정보 수정" class="form-btn form-btn-positive" style="margin-top: 15px;"></div>

</form>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>