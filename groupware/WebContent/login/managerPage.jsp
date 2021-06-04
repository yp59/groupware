<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<div>
		<h2>관리자페이지</h2>	
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/address/addressList.jsp?manage=1">
			<img alt="인사관리" src="<%=request.getContextPath()%>/login/hr.png" width="100" height="100">
		</a>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/salary/salaryAuthority.jsp">
			<img alt="급여관리" src="<%=request.getContextPath()%>/login/salary.png" width="100" height="100">
		</a>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/attendance/attendanceAuthorityMain.jsp">
			<img alt="근태관리" src="<%=request.getContextPath()%>/login/attendance.png" width="100" height="100">
		</a>
	</div>
</div>







<jsp:include page="/template/footer.jsp"></jsp:include>