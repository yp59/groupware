<%@page import="java.util.List"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.employeesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
employeesDao empDao = new employeesDao();

List<employeesDto> empList =empDao.list();



//답장하기 기능 :
// 1.파라미터로 보낸사람 이름이 들어온다. 이것을 수신자 이름으로 설정해서 보낸다.
// 2. 파라미터로 원본 글 제목이 들어온다. re: 붙여서 내보냄
String answer_name =request.getParameter("sender");
String answer_title = request.getParameter("m_name");

boolean isSender=answer_name!=null;

%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800">
	<%if(isSender) {%>
	<div class="row text-center">
		<h2>답장하기</h2>
	</div>	
	<%} else{%>
	<div class="row text-center">
		<h2>메세지 작성</h2>
	</div>
	<%} %>
	
	<div class="row">
		<form action ="massageInsert.kh" method ="post">
			<!-- 제목 : 1. 답장일 때 2. 새로운 massage일때 -->
			<%if(isSender) {%>
			<div class="row">
				<label for="name">제목</label>
				<input class="form-btn" id="name" type ="text" name="m_name" value="re:<%=answer_title %>"required>		
			</div>
			<%} else{%>
			<div class="row">
				<label for="name">제목</label>
				<input id="name" type ="text" name="m_name" required>		
			</div>
			<%} %>
			
			
			<div class="row">
			<!-- 수신자 명단 : 1. 답장일 때 2. 새로운 massage일때 -->
				<%if(isSender) {%>
					<label>수신자</label>
					<select name="e2_name">
						 <!-- 수신자 이름 보냄 -->
							<option><%=answer_name%></option>
					</select>
				<%} else{ %>
					<label>수신자</label>
					<select name="e2_name">
					 <!-- 수신자 이름 보냄 -->
					<%for(employeesDto empDto : empList) {%>
						<option><%=empDto.getEmpName()%></option>
					<%} %>
					</select>
				<%} %>
			</div>
			
			<div class="row">
				<label for="content">내용</label>
				<textarea class="form-btn" id="content" name="m_content"></textarea>
			</div>
			
			
			
			<div class="row">
				<input type="submit" value ="보내기" class="form-btn">
			</div>
		</form>
	</div>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>