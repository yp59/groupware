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
   List<HolidayDto> holidayList = holidayDao.list(empNo);
   
   employeesDao employeesDao  = new employeesDao();
   employeesDto employeesDto = employeesDao.loginInfo(empNo);
   
%>

<jsp:include page="/template/header.jsp"></jsp:include>

   <div class="row">
      <h2>휴가 신청 내역</h2>
   </div>
   
   <div class= "row float-container">
   		<div class="left" style="margin-top:5px;margin-left:5px"> 남은 휴가 일수 : <%=employeesDto.getHolidayCount()%> </div>
   		<div class="right">	  
      		<a href="holidayInsert.jsp" class="link-btn">휴가 신청</a>
   		</div>  
   </div>
   
   <div class="row">
      <table class="table table-striped">
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
               <a href="holidayDetail.jsp?holNo=<%=holidayDto.getHolNo()%>">
               <%=holidayDto.getHolNo()%>
               </a>
               </td>
               <td><%=holidayDto.getEmpNo()%></td>
               <td><%=holidayDto.getHolType()%></td>
               <td><%=holidayDto.getHolStart().substring(0,10)%></td>
               <td><%=holidayDto.getHolEnd().substring(0,10)%></td>
               <td><%=holidayDto.getHolWriteDate()%></td>
               <td><%=holidayDao.count(empNo,holidayDto.getHolNo())%></td>
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>

<jsp:include page="/template/footer.jsp"></jsp:include>