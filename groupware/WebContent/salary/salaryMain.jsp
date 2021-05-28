<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)session.getAttribute("id");
   AttendanceDao attendanceDao = new AttendanceDao();
   List<String> yearList = attendanceDao.getYear(empNo);
   
   int overtime = attendanceDao.getOvertime(empNo,"2021","05");   
%>
  
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row">
      <h2>급여</h2>
</div>
	<div class="row">
		<select>
		<%for(String year : yearList){ %>
			<option value=""><%=year%></option>
		<%} %>
		</select>
	</div>
			   	
		   
   <div class="row">
     
        
   </div>
<jsp:include page="/template/footer.jsp"></jsp:include>