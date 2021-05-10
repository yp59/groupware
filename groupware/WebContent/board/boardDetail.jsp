<%@page import="groupware.beans.boardDto"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int boardNo = Integer.parseInt(request.getParameter("boardNo"));

boardDao boarddao = new boardDao();
boardDto boarddto = boarddao.detail(boardNo);
boarddao.BoConunt(boardNo);
%>    
    
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>
<div class ="row text-center">
<%=boarddto.getBoardNo() %><br>
<%=boarddto.getBoTitle() %><br>
<%=boarddto.getBoType() %><br>
<%=boarddto.getBoContent() %><br>
<%=boarddto.getBoCount() %><br>
<%=boarddto.getBoDate() %><br>
<%=boarddto.getEmpName() %><br>
</div>

<div class = "row text-right">
	<a href = "boardEdit.jsp?boardNo=<%=boarddto.getBoardNo()%>">수정하기</a>
	<form action="boardDelete.gw" method="post">
		<input type="hidden" name="boardNo" value="<%=boarddto.getBoardNo()%>">
		<input type="submit" value="삭제하기">
	</form>
</div>

<form action="commentInsert.gw" method="post">
	<div class="row">
		<textarea rows="4" class="form-input" required name="com_content" placeholder="댓글 입력"></textarea>
	</div>
	<div class="row">
		<input type="submit" value="댓글 작성" class="form-btn form-btn-normal">
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>
