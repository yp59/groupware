<%@page import="groupware.beans.boardDao"%>
<%@page import="groupware.beans.boardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%int boardNo =Integer.parseInt(request.getParameter("boardNo")); 

boardDao boarddao = new boardDao();
boardDto boarddto = boarddao.detail(boardNo);

%> 
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>

<div class="container-900">
<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">게시글 수정</h2>
	<form action="boardEdit.gw" method ="post">
		<input type="hidden" name="boardNo" value="<%=boarddto.getBoardNo()%>">
		<div class="row" style="text-align: left;">
		<label>제목</label>
		<input type ="text" name="boTitle" value="<%=boarddto.getBoTitle() %>" required style="width: 300px;">
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
	<textarea rows="16" class="input" name="boContent" required style="resize: none; margin-top: 10px;"> <%=boarddto.getBoContent() %></textarea>
		</div>		
	<div class = "row text-right">
	<input type="submit" value="수정" class="form-btn form-btn-positive">
	</div>	
	</form>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>