<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>

<div class="container-700">
	<form action="boardInsert.gw" method ="post">
		<div class="row">
		<label>제목</label>
		<input type ="text" name="boTitle" required>
		</div>
		<div class="row">
		<label>종류</label>
	<select name="boType">
		<option>자유</option>
		<option>질문</option>
		<option>공지</option>
	</select>
	</div>
	
	<div class="row">
	<label>내용</label>
	<textarea rows="16" class="input" required name="boContent"></textarea>
		</div>		
	<div class = "row text-right">
	<input type="submit" value="등록">
	</div>	
	</form>
</div>





<jsp:include page="/template/footer.jsp"></jsp:include>