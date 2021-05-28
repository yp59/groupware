<%@page import="groupware.beans.HolidayDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.HolidayDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String empNo = (String)session.getAttribute("id");
   HolidayDao holidayDao = new HolidayDao();
   List<HolidayDto> holidayList = holidayDao.list(empNo);
   
%>

<jsp:include page="/template/header.jsp"></jsp:include>

   <div class="row">
      <h2>휴가 신청 내역</h2>
   </div>
   
   <div class="row text-right">
      <a href="holidayInsert.jsp" class="link-btn">휴가 신청</a>
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
            </tr>
            <%} %>
         </tbody>
      </table>
   </div>

<jsp:include page="/template/footer.jsp"></jsp:include>