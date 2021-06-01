<%@page import="java.util.ArrayList"%>
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
	List<String> yearMonthList = salaryDao.getMonth(empNo); //yyyy-mm 형태
	  
	String searchYear = request.getParameter("searchYear");
	String searchMonth = request.getParameter("searchMonth");
	//searchMonth = searchMonth.replace("월","");
	
	boolean isSearchYear = searchYear != "" && searchMonth == "";
	boolean isSearchMonth = searchYear == "" && searchMonth != "";
	boolean isSearchBoth = searchYear == "" && searchMonth == "";
	boolean isSearch = searchYear != null && searchMonth != null;
	
	  
	 
	List<SalaryDto> salaryList = null;
	SalaryDto salaryDto = null;
	  
	if(isSearch){
		salaryDto = salaryDao.search(empNo,searchYear, searchMonth);
		if(isSearchYear){
			salaryList = salaryDao.searchList(empNo,searchYear, searchMonth);
		}
		else if(isSearchMonth){
			salaryList = salaryDao.searchList(empNo,searchYear, searchMonth);
		}
		else if(isSearchBoth){
			salaryList = salaryDao.list(empNo); 
		}
	}
	else{
		salaryList = salaryDao.list(empNo); 
	}
	  
	//지급액에 , 찍어주기
	DecimalFormat df = new DecimalFormat("###,###");
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<script>
	$(function(){

		$("select[name=searchYear]").on("click",function(){
			$("select[name=searchMonth]").empty();
			var month = new Array;
			var year = $(this).val();
			
			<%for(String yearMonth : yearMonthList){%>
				if(year==""){
					month.push(<%=yearMonth.substring(5, 7)%>);
				}
				else if(year ==<%=yearMonth.substring(0, 4)%>){ //'yyyy'가 같으면
					month.push(<%=yearMonth.substring(5, 7)%>); //2021-06 숫자로 인식되어 뺄셈 적용됨ㅠ
				}
			<%}%>
			
			//중복된 월 제거 -> 월만 검색
			var result = [];
			$.each(month, function(i, value){
			        if(result.indexOf(value) === -1) result.push(value);
			});
			
			console.log(result);
			monthSelect(result);
			
		});
		
		$("select[name=searchYear]").on("click",function(){});
		
		
	});
	</script>

<script>
function monthSelect(monthList){
	var option = $("<option value='' selected>선택하세요</option>");
	$("select[name=searchMonth]").append(option);
	for (var count = 0; count < monthList.length; count++) {
		var option = $("<option>" + monthList[count] + "</option>");
		$("select[name=searchMonth]").append(option);
	}
	
}

</script>

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
			<option value="" selected>선택하세요</option>
			<%for(String year : yearList){ %>
				<option value="<%=year %>"><%=year%></option>
			<%} %>
			</select>
			<select name="searchMonth" class="form-input form-input-inline">
			<option value="" selected>선택하세요</option>
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
			<%if(salaryDto != null){%>
				<tbody>
					<tr>
						<td><%=salaryDto.getSalaryDate().substring(0,10)%></td>
						<td>
						<a href="salaryDetail.jsp?salaryDate=<%=salaryDto.getSalaryDate().substring(0,10)%>">
						<%=salaryDto.getSalaryDate().substring(5, 7)%>월 급여 명세서
						</a>
						</td>
						<td>₩<%=df.format(salaryDto.getSalaryTotal())%></td>
					</tr>
				</tbody>
			<%} %>
			
			<tbody>
				<%if(salaryList != null){
					for(SalaryDto salary : salaryList){ %>
				<tr>
					<td><%=salary.getSalaryDate().substring(0,10)%></td>
					<td>
					<a href="salaryDetail.jsp?salaryDate=<%=salary.getSalaryDate().substring(0,10)%>">
					<%=salary.getSalaryDate().substring(5, 7)%>월 급여 명세서
					</a>
					</td>
					<td>₩<%=df.format(salary.getSalaryTotal())%></td>
				</tr>
				<%}
				} %>
			</tbody>
		</table>
	</div>
			   	
		   
   <div class="row">
     
        
   </div>
<jsp:include page="/template/footer.jsp"></jsp:include>