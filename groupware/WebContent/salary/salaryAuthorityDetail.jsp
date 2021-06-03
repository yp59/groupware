<%@page import="groupware.beans.SalaryAuthorityDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="groupware.beans.SalaryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
   String empNo = (String)request.getParameter("empNo");
   String salaryDate = (String)request.getParameter("salaryDate");
   
   SalaryAuthorityDao salaryAuthorityDao = new SalaryAuthorityDao();
   SalaryDto salaryDto = salaryAuthorityDao.get(empNo, salaryDate);
   
   DecimalFormat df = new DecimalFormat("###,###");
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
            <td><%=df.format(salaryDto.getSalaryPay())%></td>
         </tr>         
         <tr>
            <th>추가 근무수당</th>
            <td><%=df.format(salaryDto.getSalaryOvertime())%></td>
         </tr>
         <tr>
            <th>식대</th>
            <td><%=df.format(salaryDto.getSalaryMeal())%></td>
         </tr>
         <tr>
            <th>교통비</th>
            <td><%=df.format(salaryDto.getSalaryTransportation())%></td>
         </tr>
         <tr>
            <th>지급일</th>
            <td><%=salaryDto.getSalaryDate().substring(0,10)%></td>
         </tr>
         <tr>
            <th>실수령액</th>
            <td><%=df.format(salaryDto.getSalaryTotal())%></td>
         </tr>
      </table>
   </div>
   
   <div class="row text-right">
      <a href="salaryAuthority.jsp" class="link-btn">목록</a>
      <a href="salaryAuthorityEdit.jsp?empNo=<%=empNo%>&salaryDate=<%=salaryDate %>" class="link-btn">수정</a>
      <a href="salaryDelte.gw?empNo=<%=empNo%>&salaryDate=<%=salaryDate %>" class="link-btn">삭제</a>
   </div>
   
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>