<%@page import="groupware.beans.SalaryDto"%>
<%@page import="groupware.beans.SalaryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)session.getAttribute("id");
   String salaryDate = (String)request.getParameter("salaryDate");
   
   SalaryDao salaryDao = new SalaryDao();
   SalaryDto salaryDto = salaryDao.get(empNo, salaryDate);
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">

   <div class="row">
      <h2>급여 상세</h2>
   </div>
   
   <div class="row">
      <table class="table table-border">       
         <tr>
            <th>사원번호</th>
            <td><%=salaryDto.getEmpNo()%></td>
         </tr>
         <tr>
            <th>직급 번호</th>
            <td><%=salaryDto.getPoNo()%></td>
         </tr>
         <tr>
            <th>기본급</th>
            <td><%=salaryDto.getSalaryPay()%></td>
         </tr>         
         <tr>
            <th>추가 근무수당</th>
            <td><%=salaryDto.getSalaryOvertime()%></td>
         </tr>
         <tr>
            <th>식대</th>
            <td><%=salaryDto.getSalaryMeal()%></td>
         </tr>
         <tr>
            <th>교통비</th>
            <td><%=salaryDto.getSalaryTransportation()%></td>
         </tr>
         <tr>
            <th>지급일</th>
            <td><%=salaryDto.getSalaryDate()%></td>
         </tr>
         <tr>
            <th>실수령액</th>
            <td><%=salaryDto.getSalaryTotal()%></td>
         </tr>
      </table>
   </div>
   
   <div class="row text-right">
      <a href="salaryMain.jsp" class="link-btn">목록</a>
   </div>
   
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>