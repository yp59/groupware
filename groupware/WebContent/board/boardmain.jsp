<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	boardDao boarddao = new boardDao();
	List<boardDto> list = new ArrayList();

	list=boarddao.boardList();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>

<body>


<table border = "1" >
<thead>
	<tr>
		<th>게시글 번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>날짜</th>
	</tr>
</thead>
<tbody><%for(boardDto boarddto : list){ %>
		<tr>
			<td><%=boarddto.getBoardNo()%></td>
			<td><a href="#"><%=boarddto.getBoTitle()%></a></td>
			<td><%=boarddto.getEmpNo()%></td>
			<td><%=boarddto.getBoCount()%></td>
			<td><%=boarddto.getBoDate()%></td>
		</tr>
<%}%></tbody>
</table>

</body>
</html>