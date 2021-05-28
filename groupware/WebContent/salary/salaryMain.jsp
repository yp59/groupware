<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)session.getAttribute("id");
   AttendanceDao attendanceDao = new AttendanceDao();
   List<String> yearList = attendanceDao.getYear(empNo);
   List<String> monthList = attendanceDao.getMonth(empNo);
   
   int overtime = attendanceDao.getOvertime(empNo,"2021","05");   
%>
  
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row">
      <h2>급여</h2>
</div>
	<div class="row">
		<form action="searchSalary.gw" method="post">
			<select name="searchYear" class="form-input form-input-inline">
			<%for(String year : yearList){ %>
				<option value=""><%=year%></option>
			<%} %>
			</select>
			<select name="searchMonth" class="form-input form-input-inline">
			<%for(String month : monthList){ %>
				<option value=""><%=month%></option>
			<%} %>
			</select>
			<input type="submit" value="검색" class="form-btn form-btn-inline form-btn-positive">
		</form>
	</div>
			   	
		   
   <div class="row">
     
        
   </div>
<jsp:include page="/template/footer.jsp"></jsp:include>