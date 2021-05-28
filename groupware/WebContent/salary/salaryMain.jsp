<%@page import="java.text.DecimalFormat"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.SalaryDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)session.getAttribute("id");
   AttendanceDao attendanceDao = new AttendanceDao();
   List<String> yearList = attendanceDao.getYear(empNo);
   List<String> monthList = attendanceDao.getMonth(empNo);
   
   SalaryDao salaryDao = new SalaryDao();
   List<SalaryDto> salaryList = salaryDao.list(empNo);
   
   //지급액에 , 찍어주기
   DecimalFormat df = new DecimalFormat("###,###");
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
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th width=20%>지급일</th>
					<th>제목</th>
					<th>지급액</th>
					
				</tr>
			</thead>
			<tbody>
				<%for(SalaryDto salaryDto : salaryList){ %>
				<tr>
					<td><%=salaryDto.getSalaryDate().substring(0,10)%></td>
					<td>
					<a href="#">
					<%=salaryDto.getSalaryDate().substring(5, 7)%>월 급여 명세서
					</a>
					</td>
					<td>₩<%=df.format(salaryDto.getSalaryPay()+salaryDto.getSalaryOvertime()
					+salaryDto.getSalaryMeal()+salaryDto.getSalaryTransportation())%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
			   	
		   
   <div class="row">
     
        
   </div>
<jsp:include page="/template/footer.jsp"></jsp:include>