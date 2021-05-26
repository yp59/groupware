<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   
   String empNo = (String)session.getAttribute("id");
   AttendanceDao attendanceDao = new AttendanceDao();
   List<AttendanceDto> attendanceList = attendanceDao.list(empNo);
   
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

 <div class="row">
      <h2>출퇴근 현황</h2>
   </div>
   
   <div class="row text-right">
      <a href="attend.gw?" class="link-btn">출근</a>
      <a href="leave.gw?" class="link-btn">퇴근</a>
   </div>
   
   <div class="row">
      <table class="table table-striped">
         <thead>
            <tr>
               <th>날짜</th>
               <th>사원 번호</th>
               <th>출근 시간</th>
               <th>퇴근 시간</th>
               <th>총 근무시간</th>
               <th>추가 근무시간</th>
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
               <td><%=attendanceDto.getAttAttend()%></td>
               <td><%=attendanceDto.getAttLeave()%></td>
               <td><%=attendanceDto.getAttTotaltime()%></td>
               <td><%=attendanceDto.getAttOvertime()%></td>
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>



<jsp:include page="/template/footer.jsp"></jsp:include>