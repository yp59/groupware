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
<style>
.container-600{
	position:relative;
	top:30px;
}
</style>  
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">

   <div class="row"  style="border-bottom: 2px solid rgb(52, 152, 219);">
      <h2><%=salaryDto.getEmpName() %>님의 급여</h2>
   </div>
   
   <div class="row" style="margin-top:5%;">
      <table class="table table-border text-center">       
         <tr>
            <th width="40%">사원번호</th>
            <td><%=salaryDto.getEmpNo()%></td>
         </tr>
         <tr>
            <th>직급</th> 
            <td><%=salaryDto.getPosi()%></td>
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
      <a href="salaryDelete.gw?empNo=<%=empNo%>&salaryDate=<%=salaryDate %>" class="link-btn">삭제</a>
   </div>
   
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>