<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   DecimalFormat df=new DecimalFormat("#.#"); //근무시간 소수점 첫째자리가 0이면 안나오게
   String empNo = (String)session.getAttribute("id");
   AttendanceDao attendanceDao = new AttendanceDao();
   
   
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
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 10; //기본값 10개
	}
   
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	List<AttendanceDto> attendanceList = attendanceDao.list(empNo,startRow,endRow);
	
	// 페이지 네비게이션 영역 계산
		int count = attendanceDao.getCount();
	
		int blockSize = 10;
		int lastBlock = (count + pageSize - 1) / pageSize;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > lastBlock){//범위를 벗어나면
			endBlock = lastBlock;//범위를 수정
		}   
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){

		$(".attend-btn").click(function(){
			var date = new Date();
			window.alert(date.getHours()+"시"+date.getMinutes()+"분"+date.getSeconds()+"초"+"\n"+"출근했습니다.");
		});
		
		$(".leave-btn").click(function(){
			var date = new Date();
			window.alert(date.getHours()+"시"+date.getMinutes()+"분"+date.getSeconds()+"초"+"\n"+"퇴근했습니다.");
		});
		
		$(".pagination > a").click(function(){
			//주인공 == a태그
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

 <div class="row">
      <h2>출퇴근 현황</h2>
   </div>
   
   <div class="row text-right">
      <a href="attend.gw?" class="link-btn attend-btn">출근</a>
      <a href="leave.gw?" class="link-btn leave-btn">퇴근</a>
   </div>
   
   <div class="row">
      <table class="table table-striped">
         <thead>
            <tr>
               <th>날짜</th>
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
               <a href="attendanceDetail.jsp?attDate=<%=attendanceDto.getAttDate() %>">
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
				<%=df.format(Math.floor(attendanceDto.getAttTotaltime()))%>시간                
				<%=df.format(attendanceDto.getAttTotaltime()*60 % 60) %>분            
               </td>
               <td>
				<%=df.format(attendanceDto.getAttOvertime()) %>시간             
               </td>
               <td width="15%">
               <a href="#" class="link-btn">수정 요청</a>
               </td>
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>
   
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