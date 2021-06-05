<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <%String empNo = (String)session.getAttribute("id");
 
// 	자신이 작성한 게시글 목록 조회
	boardDao boarddao = new boardDao();
	List<boardDto> myList = boarddao.searchByWriter(empNo, 1, 10);
    %>
    
<style>
	.my-board-list {
		margin: 0;
		padding:0;
		list-style: none;
		border:none;
	}
	.my-board-list > li{
		padding:0.5rem;
		border: none; 
		border-bottom: 0.5px solid gray;
	}
	.my-board-list > li:nth-child(2n) {
	background-color:white;
	}
	.my-board-list > li > a{
		text-decoration: none;
		color:black;
	}
	.my-board-list > li > a:hover{
		color:rgb(52, 152, 219);
	}
	
	.table>tbody>tr>td{
		text-align: center;
	}
	.li-list {
	list-style: none;
	float: none;
	clear: both;
	}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>
<style>
	section {
	float:left;
	width:100%;
	min-height:400px;
	}
	article {
	height:10px;
	min-height: 390px;
	}
	footer {
	min-height:10px;
	}
</style>
<div class="container-1200" style="border: none;">
<div class="row" style="border: none; border-bottom: 2px solid rgb(52, 152, 219);">
		<h2>내가 작성한 게시글</h2>
	</div>
	<div class="row text-left" style="border: none; border-bottom: 2px solid rgb(52, 152, 219);">
		<ul class="my-board-list" style="text-align: center;">
			<%for(boardDto boarddto : myList){ %>
			<li class="li-list" style="margin-bottom: 10px;">
				<a href="<%=request.getContextPath()%>/board/boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%>
				</a>
			</li>
			<%} %>
		</ul>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>