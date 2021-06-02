<%@page import="groupware.beans.AddressDetailDto"%>
<%@page import="groupware.beans.AddressDetailDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String emp_no =(String)request.getParameter("empNo");

AddressDetailDao addressDetailDao = new AddressDetailDao();
AddressDetailDto addressDetailDto = addressDetailDao.detail(emp_no);

String id = (String)request.getSession().getAttribute("id");
boolean amI = id.equals(emp_no);

//관리자 기능 추가
int authLev = (int)request.getSession().getAttribute("authorityLevel");
boolean isManage = authLev==1;
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<div class="catainer-800">
	<div class="row"> 
		<h2>사원 정보</h2>
	</div>
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>사원번호</th>
				<td><%=addressDetailDto.getEmp_no() %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=addressDetailDto.getEmp_name() %></td>
			</tr>
			<tr>
				<th>부서</th>
				<td><%=addressDetailDto.getDepartment() %></td>
			</tr>
			<tr>
				<th>직급</th>
				<td><%=addressDetailDto.getPosi() %></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=addressDetailDto.getEmp_phone() %></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=addressDetailDto.getEmail() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=addressDetailDto.getAddress() %></td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><%=addressDetailDto.getJoin_date() %></td>
			</tr>
		</table>
	</div>
	<div class="row text-right">

		<%if(!amI) {%>
		<a class="link-btn " href="<%=request.getContextPath()%>/massage/massageInsert.jsp?empNo=<%=emp_no%>">메세지</a>
		<%} %>
		<a class="link-btn " href="addressList.jsp">주소록</a>

	
	
		<!-- 관리자일 경우에만 사원정보 수정가능 -->
		<%if(isManage) {%>
		<a href="<%=request.getContextPath()%>/login/signUpEdit.jsp?empNo=<%=emp_no%>">정보수정</a>
		<%} %>
	
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>