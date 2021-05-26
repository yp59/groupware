<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String empNo = (String)session.getAttribute("id");
   String attDate = (String)request.getParameter("attDate");
   
   AttendanceDao attendanceDao = new AttendanceDao();
   AttendanceDto attendanceDto = attendanceDao.get(empNo, attDate);
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">

   <div class="row">
      <h2>근태 내역</h2>
   </div>
   
   <div class="row">
      <table class="table table-border">
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
            <td><%=attendanceDto.getAttLeave()%></td>
         </tr>
         <tr>
            <th>총 근무 시간</th>
            <td><%=attendanceDto.getAttTotaltime()%></td>
         </tr>
         <tr>
            <th>추가 근무시간</th>
            <td><%=attendanceDto.getAttOvertime()%></td>
         </tr>
      </table>
   </div>
   
   <div class="row text-right">
      <a href="attendanceMain.jsp" class="link-btn">목록</a>
      <a href="attendanceEdit.jsp?empNo=<%=empNo%>" class="link-btn">수정</a>
   </div>
   
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>