<%@page import="java.util.List"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@page import="groupware.beans.MassageListDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String empNo = (String)request.getSession().getAttribute("id");

MassageListDao massageListDao = new MassageListDao();
List<MassageListDto> list = massageListDao.list_sender(empNo);



%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800">
	<div>
		<h2>메세지 발신함</h2>
	</div>
	<div class="row">
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
					<td>
						<a href ="massageDetail.jsp?m_no=<%=massageListDto.getM_no()%>">
						
						<%=massageListDto.getM_name() %></a>
						
						
					
					</td>
					<td><%=massageListDto.getEmp_name() %></td>
					<td><%=massageListDto.getE2_name()%></td>
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



<jsp:include page="/template/footer.jsp"></jsp:include>