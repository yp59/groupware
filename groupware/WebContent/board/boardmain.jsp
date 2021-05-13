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
				<th>종류</th>
				<th>조회수</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody><%for(boardDto boarddto : list){ 
					if(boarddto.getBoType().equals("공지")){%><!-- 공지 게시글을 먼저 if문으로 구별해서 표의 상단에 위치하게 한다. -->
				<tr>
					<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%></a></td>
					<td><%=boarddto.getEmpName()%></td>
					<td><%=boarddto.getBoType() %></td>
					<td><%=boarddto.getBoCount()%></td>
					<td><%=boarddto.getBoDate().substring(0, 10)%></td>
				</tr><%}
				}%>
				
				<%for(boardDto boarddto : list){ 
					if(!boarddto.getBoType().equals("공지")){%><!-- 위에서 공지글을 상단에 나타낸후 나머지 글을 아래에 나타낸다. -->
					<tr>
						<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
						<%=boarddto.getBoTitle()%></a></td>
						<td><%=boarddto.getEmpName()%></td>
						<td><%=boarddto.getBoType() %></td>
						<td><%=boarddto.getBoCount()%></td>
						<td><%=boarddto.getBoDate().substring(0, 10)%></td>
					</tr><%}
					}%>
				
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
<div class ="container-900 text-right">
	<a href="boardInsert.jsp" class=link-btn>게시글 작성</a>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>

