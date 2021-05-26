<%@page import="groupware.beans.MassageListDto"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int  m_no = Integer.parseInt(request.getParameter("m_no"));
MassageListDao massageListDao = new MassageListDao();
MassageListDto massageListDto = massageListDao.detail(m_no);

//수신자인 발신자인지 판단하는 기준 :
//수신자의 경우, 수신자 번호(e2_no) = 내 아이디(세션)
boolean isReceiver = massageListDto.getE2_no().equals(request.getSession().getAttribute("id"));




%>


<jsp:include page ="/template/header.jsp"></jsp:include>
<div>
	<div>
		<h2>메세지 확인</h2>
	</div>
	<div> 
		<%=massageListDto.getE2_no() %>
		<%=request.getSession().getAttribute("id") %>
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
	<div class="row">
		<!-- 답변기능 : 
			1.이 기능의 경우 수신자 목록을 통해 들어온 경우만 가능해야 한다. 
			2.이 경우 파라미터를 통해 작성자 이름을 보내고 그 값을 수신자 이름으로 받아야한다.
				-> 이 때 발신자 이름을 보내야한다.	-->
			 

		 <%if(isReceiver) {%>
		<a href="massageInsert.jsp?sender=<%=massageListDto.getEmp_name() %>&&m_name=<%=massageListDto.getM_name()%>" class="link-btn">답장쓰기</a>
		<%} %>
	</div>

</div>





<jsp:include page="/template/footer.jsp"></jsp:include>