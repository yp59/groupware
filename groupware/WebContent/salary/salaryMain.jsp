<%@page import="java.text.DecimalFormat"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.SalaryDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)session.getAttribute("id");
	SalaryDao salaryDao = new SalaryDao();
   List<String> yearList = salaryDao.getYear(empNo);
   List<String> monthList = salaryDao.getMonth(empNo);
   
   String searchYear = request.getParameter("searchYear");
   String searchMonth = request.getParameter("searchMonth");
   
   boolean isSearch = searchYear != null && searchMonth != null;
   
  
   List<SalaryDto> salaryList = salaryDao.list(empNo);
   
   if(isSearch){
	   salaryList = salaryDao.search(empNo,searchYear, searchMonth);
	} 
	else{
		salaryList = salaryDao.list(empNo); 
	}
   
   //지급액에 , 찍어주기
   DecimalFormat df = new DecimalFormat("###,###");
%>
  
<jsp:include page="/template/header.jsp"></jsp:include>
<%if(isSearch){ %>
<script>
	//서버에서 수신한 searchYear와 searchMonth에 해당하는 값들을 각각의 입력창에 설정하여 유지되는것처럼 보이도록 구현
	$(function(){
		$("select[name=searchYear]").val("<%=searchYear%>");
		$("select[name=searchMonth]").val("<%=searchMonth%>");
	});
</script>
<%} %>
<div class="row">
      <h2>급여</h2>
</div>
	<div class="row">
		<form action="salaryMain.jsp" method="get">
			<select name="searchYear" class="form-input form-input-inline">
			<%for(String year : yearList){ %>
				<option value="<%=year %>"><%=year%></option>
			<%} %>
			</select>
			<select name="searchMonth" class="form-input form-input-inline">
			<%for(String month : monthList){ %>
				<option value="<%=month%>"><%=month%></option>
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
					<a href="salaryDetail.jsp?salaryDate=<%=salaryDto.getSalaryDate().substring(0,10)%>">
					<%=salaryDto.getSalaryDate().substring(5, 7)%>월 급여 명세서
					</a>
					</td>
					<td>₩<%=df.format(salaryDto.getSalaryTotal())%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
			   	
		   
   <div class="row">
     
        
   </div>
<jsp:include page="/template/footer.jsp"></jsp:include>