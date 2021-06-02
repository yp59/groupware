<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.SalaryAuthorityDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String empNo = (String)session.getAttribute("id");
	SalaryAuthorityDao salaryAuthorityDao = new SalaryAuthorityDao();
	
	List<String> yearList = salaryAuthorityDao.getYear();
	List<String> yearMonthList = salaryAuthorityDao.getMonth(); //yyyy-mm 형태
	  
	String searchYear = request.getParameter("searchYear");
	String searchMonth = request.getParameter("searchMonth");
	//searchMonth = searchMonth.replace("월","");
	
	int authoritylevel = ((Integer)(session.getAttribute("authorityLevel"))).intValue(); //관리자번호 
	
	int pageNo;//현재 페이지 번호
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 5){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 5;//기본값 5개
	}
	
	//(2) rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	boolean isSearchYear = searchYear != "" && searchMonth == "";
	boolean isSearchMonth = searchYear == "" && searchMonth != "";
	boolean isSearchBoth = searchYear == "" && searchMonth == ""; //둘다 선택하세요일때
	boolean isSearch = searchYear != null && searchMonth != null;
	
	
	//List<SalaryDto> boardList;
	List<SalaryDto> salaryList = null;
	SalaryDto salaryDto = null;
	
	if(isSearch){

		if(isSearchYear){
			salaryList = salaryAuthorityDao.searchList(searchYear, searchMonth, startRow, endRow); //연도만 검색
		}
		else if(isSearchMonth){
			salaryList = salaryAuthorityDao.searchList(searchYear, searchMonth, startRow, endRow); //월만 검색
		}
		else if(isSearchBoth){ //둘다 선택하세요 일 때
			salaryList = salaryAuthorityDao.list(startRow, endRow);
		}
		else{
			salaryDto = salaryAuthorityDao.search(searchYear, searchMonth); //둘다 값설정해서 검색했을때
		}
	}
	else{
		salaryList = salaryAuthorityDao.list(startRow, endRow);
	}
	
	/////////////////////////////////////////////////////////////////////
	// 페이지 네비게이션 영역 계산
	/////////////////////////////////////////////////////////////////////
	
	int count;
	if(isSearch){
		if(isSearchYear || isSearchMonth ){
			count = salaryAuthorityDao.getCount2(searchYear, searchMonth); // or
		}
		else if(isSearchBoth){
			count = salaryAuthorityDao.getCount(); //둘다 선택하세요일때
		}
		else{
			count = salaryAuthorityDao.getCount1(searchYear, searchMonth); //and
		}
	}
	else{
		count = salaryAuthorityDao.getCount();
	}
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
// 	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	  
	//지급액에 , 찍어주기
	DecimalFormat df = new DecimalFormat("###,###");
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<script>
	$(function(){
		monthPrepare();
		$("select[name=searchYear]").on("click",function(){
			$("select[name=searchMonth]").empty();
			monthPrepare();
		});
		
		$("select[name=searchYear]").on("click",function(){});
		
		
	});
	
	function monthPrepare(){
		var month = [];
		var year = $("select[name=searchYear]").val();
		
		<%for(String yearMonth : yearMonthList){%>
			if(year==""){
				month.push("<%=yearMonth.substring(5, 7)%>");
			}
			else if(year == "<%=yearMonth.substring(0, 4)%>"){ //'yyyy'가 같으면
				month.push("<%=yearMonth.substring(5, 7)%>"); 
			}
		<%}%>
		
		//중복된 월 제거 -> 월만 검색
		var result = [];
		$.each(month, function(i, value){
		        if(result.indexOf(value) === -1) result.push(value);
		});
		
		console.log(result);
		monthSelect(result);
	}
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

<script>
	$(function(){
		$(".pagination > a").click(function(){
			var pageNo = $(this).text();
			if(pageNo == "이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}	
			else if(pageNo == "다음"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
			else{//숫자 링크
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
		});
	});
</script>
<div class="row">
      <h2>급여</h2>
</div>

	<div class="row">
		<form action="salaryMain.jsp" method="get">
			<select name="searchYear" class="form-input form-input-inline">
			<option value="">선택하세요</option>
			<%for(String year : yearList){ %>
				<option value="<%=year %>"><%=year%></option>
			<%} %>
			</select>
			<select name="searchMonth" class="form-input form-input-inline">
			</select>
			
			<input type="submit" value="검색" class="form-btn form-btn-inline form-btn-positive">
		</form>
	</div>
	<div class="row">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th width=20%>지급일</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>제목</th>
					<th>지급액</th>
					
				</tr>
			</thead>
			<%if(salaryDto != null){%>
				<tbody>
					<tr>
						<td><%=salaryDto.getSalaryDate().substring(0,10)%></td>
						<td><%=salaryDto.getEmpNo() %></td>
						<td><%=salaryDto.getEmpName() %></td>
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
					<td><%=salary.getEmpNo() %></td>
					<td><%=salary.getEmpName() %></td>
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
			   	
	<form class="search-form" action="salaryMain.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>
   
   <div class="row">
		<!-- 페이지 네비게이션 자리 -->
		<div class="pagination">
		
			<%if(startBlock > 1){ %>
			<a class="move-link">이전</a>
			<%} %>
			
			<%for(int i = startBlock; i <= endBlock; i++){ %>
				<%if(i == pageNo){ %>
					<a class="on"><%=i%></a>
				<%}else{ %>
					<a><%=i%></a>
				<%} %>
			<%} %>
			
			<%if(endBlock < lastBlock){ %>
			<a class="move-link">다음</a>
			<%} %>
			
		</div>	
	</div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>