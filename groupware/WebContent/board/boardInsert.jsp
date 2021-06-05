<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%String id = (String)session.getAttribute("id");

%>
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>

<div class="container-900">
<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">게시글 등록</h2>
	<form action="boardInsert.gw" method ="post">
		<input type="hidden" name=empNo value=<%=id%>>
		<div class="row" style="text-align: left;">
		<label>제목</label>
		<input type ="text" name="boTitle" required style="width: 300px;">
		</div>
		<div class="row" style="text-align: left;">
		<label>종류</label>
	<select name="boType">
		<option>자유</option>
		<option>질문</option>
		<option>공지</option>
	</select>
	</div>
	
	<div class="row" style="text-align: left;">
	<label>내용</label>
	<textarea rows="16" class="input" required name="boContent" style="resize: none; margin-top: 10px;"></textarea>
		</div>		
	<div class = "row text-right">
	<input type="submit" value="등록" class="form-btn form-btn-positive">
	</div>	
	</form>
</div>





<jsp:include page="/template/footer.jsp"></jsp:include>