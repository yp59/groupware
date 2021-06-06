<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.HolidayDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.HolidayDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String empNo = (String)session.getAttribute("id");
   HolidayDao holidayDao = new HolidayDao();
   
   
   employeesDao employeesDao  = new employeesDao();
   employeesDto employeesDto = employeesDao.loginInfo(empNo);
   
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
   
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	List<HolidayDto> holidayList = holidayDao.list(empNo,startRow,endRow);
	
	// 페이지 네비게이션 영역 계산
	int count = holidayDao.getCount(empNo);

	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize; //(8+5-1)/5=2.4 = 2
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1; //(5-1)/10*10 + 1 = 1
	int endBlock = startBlock + blockSize - 1; // 10
	
	if(endBlock > lastBlock){ // 10>2
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
<jsp:include page="/template/header.jsp"></jsp:include>

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

<script>
	$(function(){
		$(".holiday-btn").click(function(){
			if(<%=employeesDto.getHolidayCount()%> == 0){
				window.alert("남은 휴가 일수가 없습니다!");
				return false;
			}
		});
	});
</script>

<div class="container-1100">
   <div class="text-center" style="border-bottom: 2px solid rgb(52, 152, 219);">
      <h2>휴가 신청 내역</h2>
   </div>
   
   <div class="text-left" style="margin-top:1%;">
   		 <span>남은 휴가 일수 : <%=employeesDto.getHolidayCount()%></span>
      	 <a href="holidayInsert.jsp" class="link-btn holiday-btn"  style="margin-left:1%">휴가 신청</a>  
   </div>
   
   <div class="row">
      <table class="table table-border text-center">
         <thead>
            <tr>
               <th>휴가 번호</th>
               <th>사원 번호</th>
               <th>휴가 종류</th>
               <th>시작 날짜</th>
               <th>끝 날짜</th>
               <th>작성일</th>
               <th width="10%">신청 일수</th>
            </tr>
         </thead>
         
         <tbody>
            <%for(HolidayDto holidayDto : holidayList){ %>
            <tr>
               <td>
               <a href="holidayDetail.jsp?holNo=<%=holidayDto.getHolNo()%>" class="link-btn2">
               <%=holidayDto.getHolNo()%>
               </a>
               </td>
               <td><%=holidayDto.getEmpNo()%></td>
               <td><%if(holidayDto.getHolType() == null){%>
               		기타
               		<%} else{%>               		
				<%=holidayDto.getHolType()%>
				<%} %></td>
               <td><%=holidayDto.getHolStart().substring(0, 10) %></td>
               <td><%=holidayDto.getHolEnd().substring(0,10)%></td>
               <td><%=holidayDto.getHolWriteDate()%></td>
               <td><%=holidayDao.count(empNo,holidayDto.getHolNo())%></td>
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>

	<form class="search-form" action="holidayList.jsp" method="get">
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