<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	boardDao boarddao = new boardDao();
	List<boardDto> list = boarddao.boardList();
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>
<div class= "container-900 text-center">
	<table class="table table-border table-hover" >
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody><%for(boardDto boarddto : list){ %>
				<tr>
					<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%></a></td>
					<td><%=boarddto.getEmpName()%></td>
					<td><%=boarddto.getBoCount()%></td>
					<td><%=boarddto.getBoDate().substring(0, 10)%></td>
				</tr><%}%>
		</tbody>
	</table>
	<div class="row">
		<div class="pagination">
			<a href="#">&lt;</a>
			<a href="#">1</a>
			<a href="#">2</a>
			<a href="#">3</a>
			<a href="#">4</a>
			<a href="#">5</a>
			<a href="#">6</a>
			<a href="#">7</a>
			<a href="#">8</a>
			<a href="#">9</a>
			<a href="#">10</a>
			<a href="#">&gt;</a>
		</div>
	</div>
</div>
<div class ="container-700 text-right">
	<a href="boardInsert.jsp" class=link-btn>게시글 작성</a>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>

