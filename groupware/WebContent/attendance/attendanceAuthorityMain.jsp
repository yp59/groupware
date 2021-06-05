<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   // 페이지네이션
   int pageNo; //현재 페이지 번호
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
		pageSize = 5; //기본값 5개
	}
	
	request.setCharacterEncoding("UTF-8");
	String empNo = request.getParameter("employeesChoice");
	
	boolean isSearch = empNo != null;
	boolean notSearch = empNo == "";
   
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	List<AttendanceDto> attendanceList;
	
	AttendanceDao attendanceDao = new AttendanceDao();
	int count;
	
	if(isSearch){
		
		if(notSearch){
			count = attendanceDao.getCount();
			attendanceList = attendanceDao.list(startRow,endRow);
		}
		else{
			count = attendanceDao.getCount(empNo);
			attendanceList = attendanceDao.list(empNo,startRow,endRow);
		}
	}
	else{
		count = attendanceDao.getCount();
		attendanceList = attendanceDao.list(startRow,endRow);
		
	}
	
	// 페이지 네비게이션 영역 계산

	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize; 
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1; 
	int endBlock = startBlock + blockSize - 1; 
	
	if(endBlock > lastBlock){ 
		endBlock = lastBlock;
	}   
%>

<style>

	.container-1100{
		position:relative;
		top:30px;
	}
	.link-btn2 {
		width:65%;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<%
	String pattern = "yyyy-MM-dd"; 
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	String date = simpleDateFormat.format(new Date());
	
%>


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
    
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	employeesDao employeesDao = new employeesDao();
	List<employeesDto> employeesList = employeesDao.list();
%>
<div class="container-1100">
 <div class="text-center"  style="border-bottom: 2px solid rgb(52, 152, 219);">
      <h2>출퇴근 관리</h2>
   </div>

   <div class="row text-center">
	   <form action="attendanceAuthorityMain.jsp" method="get"> 
			<select name="employeesChoice" class="form-input form-input-inline" style="width:20% !important">
				<option value="">사원 선택</option>
				<%for(employeesDto employee : employeesList){%>
					<option value="<%=employee.getEmpNo()%>"><%=employee.getEmpName()%></option>
				<% } %>
			</select>
			<input type="submit" value="검색" class="form-btn form-btn-inline form-btn-positive">
		</form>
	</div>
   
   
   <div class="row">
      <table class="table table-border text-center">
         <thead>
            <tr>
               <th width="20%">날짜</th>
               <th>사원 번호</th>
               <th>사원 이름</th>
               <th>출근 시간</th>
               <th>퇴근 시간</th>
               <th>총 근무시간</th>
               <th>추가 근무시간</th>
               <th>기타</th>
            </tr>
         </thead>
         
         <tbody>
            <%for(AttendanceDto attendanceDto : attendanceList){ %>
            <tr>
               <td>
               <a href="attendanceAuthorityDetail.jsp?empNo=<%=attendanceDto.getEmpNo()%>&attDate=<%=attendanceDto.getAttDate() %>" class="link-btn2">
               <%=attendanceDto.getAttDate()%>
               </a>
               </td>
               <td><%=attendanceDto.getEmpNo()%></td>
               <td><%=attendanceDto.getEmpName()%></td>
               <td><%=attendanceDto.getAttAttend()%></td>
               <td><%if(attendanceDto.getAttLeave() != null){%>
               <%=attendanceDto.getAttLeave()%>
               <%} %>
               </td>
               <td>
               	<!-- 내림하고 소수점자리 자르기 -->
				<%=(int)(attendanceDto.getAttTotaltime()/60) %>시간  <!-- 분단위라서 60으로 나눠준 몫 -->             
				<%=(int)(attendanceDto.getAttTotaltime()%60) %>분   <!-- 60으로 나눠준 나머지 -->     
               </td>
               <td>
				<%=(int)(attendanceDto.getAttOvertime()) %>시간             
               </td>
               <td width="15%" class="text-center">
               <a href="attendanceEdit.jsp?empNo=<%=attendanceDto.getEmpNo()%>&attDate=<%=attendanceDto.getAttDate() %>" class="link-btn">수정</a>
               <a href="attendanceDelete.gw?empNo=<%=attendanceDto.getEmpNo()%>&attDate=<%=attendanceDto.getAttDate() %>" class="link-btn">삭제</a>
               </td>
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>
   
  	<form class="search-form" action="attendanceAuthorityMain.jsp" method="get">
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
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>