<%@page import="groupware.beans.MassageListDto"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int  m_no = Integer.parseInt(request.getParameter("m_no"));
MassageListDao massageListDao = new MassageListDao();
MassageListDto massageListDto = massageListDao.detail(m_no);

//수신자인 발신자인지 판단하는 기준 :
//수신자의 경우, 수신자 번호 = 내 아이디(세션)
boolean isReceiver = massageListDto.getE2_no() == request.getSession().getAttribute("id");



%>


<jsp:include page ="/template/header.jsp"></jsp:include>
<div>
	<div>
		<h2>메세지 확인</h2>
	</div>
	<div>
		<table class="table table-border">
			<tr>
				<th>번호</th>
				<td><%=massageListDto.getM_no() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=massageListDto.getM_name() %></td>
			</tr>
			<tr>
				<th>발신자</th>
				<td><%=massageListDto.getEmp_name() %></td>
			</tr>
			<tr>
				<th>수신자</th>
				<td><%=massageListDto.getE2_name() %></td>
			</tr>
			<tr>
				<th>보낸시간</th>
				<td><%=massageListDto.getM_date() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=massageListDto.getM_content() %></td>
			</tr>
		</table>
	</div>
	<div>
		<!-- 답변기능 : 
			1.이 경우 파라미터를 통해 작성자를 보내 수신자로 받아야한다.
			2.이 기능의 경우 수신자 목록을 통해 들어온 경우만 가능해야 한다. 
			 
		 -->
		 <%if(isReceiver) {%>
		<a herf="#">답장쓰기</a>
		<%} %>
	</div>

</div>





<jsp:include page="/template/footer.jsp"></jsp:include>