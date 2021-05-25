<%@page import="groupware.beans.MassageDto"%>
<%@page import="groupware.beans.MassageDao"%>
<%@page import="groupware.beans.MassageListDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String empNo = (String)request.getSession().getAttribute("id");
MassageDao massageDao = new MassageDao();//받은사람 이름 가져오기 위한 메소드
MassageDto massageDto =massageDao.detail(empNo);
String receiver = massageDto.getM_receiver();


MassageListDao massageListDao = new MassageListDao();
List<MassageListDto> list = massageListDao.list_receiver(receiver);



%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div>
	<div>
		<h2>메세지 수신함</h2>
	</div>
	
	<div>
		<table class="table table-border">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>보낸사람</th>
					<th>받는사람</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%for(MassageListDto massageListDto : list) {%>
				<tr>
					<td><%=massageListDto.getM_no() %></td>
					<td><%=massageListDto.getM_name() %></td>
					<td><%=massageListDto.getEmp_name() %></td>
					<td><%=massageListDto.getM_receiver() %></td>
					<td><%=massageListDto.getM_date() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<div>
		<h4>로그인상태: <%=request.getSession().getAttribute("id") %></h4>
	</div>


</div>
