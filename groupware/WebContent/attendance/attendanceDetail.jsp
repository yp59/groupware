<%@page import="java.text.DecimalFormat"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	DecimalFormat df=new DecimalFormat("#"); //근무시간 소수점 첫째자리가 0이면 안나오게
	
	String empNo = (String)session.getAttribute("id");
	String attDate = (String)request.getParameter("attDate");
	
	AttendanceDao attendanceDao = new AttendanceDao();
	AttendanceDto attendanceDto = attendanceDao.get(empNo, attDate);
%>
<style>
	.container-600{
		position:relative;
		top:30px;
	}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">

   <div class="row">
      <h2>근태 내역</h2>
   </div>
   
   <div class="row" style="border-top: 2px solid rgb(52, 152, 219);">
      <table class="table table-border text-center" style="margin-top:5%;">
         <tr>
            <th>날짜</th>
            <td><%=attendanceDto.getAttDate()%></td>
         </tr>
         <tr>
            <th>사원 번호</th> 
            <td><%=attendanceDto.getEmpNo()%></td>
         </tr>
         <tr>
            <th>사원 이름</th> 
            <td><%=attendanceDto.getEmpName()%></td>
         </tr>
         <tr>   
            <th>출근 시간</th>
            <td><%=attendanceDto.getAttAttend()%></td>
         </tr>
         <tr>
            <th>퇴근 시간</th>
            <td><%if(attendanceDto.getAttLeave()!= null) { %>
            <%=attendanceDto.getAttLeave()%>
            <%} %></td>
         </tr>
         <tr>
            <th>총 근무 시간</th>
            <td>
            <!-- 내림하고 소수점자리 자르기 -->
				<%=df.format(attendanceDto.getAttTotaltime()/60) %>시간  <!-- 분단위라서 60으로 나눠준 몫 -->             
				<%=df.format(attendanceDto.getAttTotaltime()%60) %>분   <!-- 60으로 나눠준 나머지 -->
            </td>
         </tr>
         <tr>
            <th>추가 근무시간</th>
            <td>
				<%=df.format(attendanceDto.getAttOvertime()) %>시간             
            </td>
         </tr>
      </table>
   </div>
   
   <div class="row text-right">
      <a href="attendanceMain.jsp" class="link-btn">목록</a>
   </div>
   
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>