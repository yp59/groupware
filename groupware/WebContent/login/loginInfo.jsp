<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%String empNo = (String)session.getAttribute("id");
    
    employeesDao employeesdao = new employeesDao();
    employeesDto employeesdto = employeesdao.loginInfo(empNo);
   
    
// 	자신이 작성한 게시글 목록 조회
	boardDao boarddao = new boardDao();
	List<boardDto> myList = boarddao.searchByWriter(empNo, 1, 5);
    %>
    
<style>
	.my-board-list {
		margin: 0;
		padding:0;
		list-style: none;
		border:1px solid black;
	}
	.my-board-list > li{
		padding:0.5rem;
	}
	.my-board-list > li:nth-child(2n) {
		background-color:rgba(0, 0, 0, 0.1);
	}
	.my-board-list > li > a{
		text-decoration: none;
		color:black;
	}
	.my-board-list > li > a:hover{
		color:red;
	}
	
	.table>tbody>tr>td{
		text-align: center;
	}
	
	
</style>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>
<style>
	section {
			float:left;
			width:100%;
			min-height:370px;
		}
		article {
			min-height:360px;
		}
		footer {
			min-height:10px;
		}
		.pn > a:link, a:visited {
  		color : rgb(52, 152, 219);
		text-decoration: none;
}
</style>
<div class="container-1200" style="border: none;">
<div style="border: none; text-align: center;">
	<h2>마이페이지</h2>

</div>

<div style="text-align: center; border-top: 2px solid rgb(102, 177, 227);">
<table class="table table-border table-striped" style="margin-top: 10px;">
	<tbody>
		<tr>
			<th width="100">사원번호</th>
			<td> <%=employeesdto.getEmpNo()%></td>
		</tr>	
		<tr>
			<th>직급</th>
			<td><%=employeesdao.position(empNo)%></td>
		</tr>	
		<tr>
			<th>이름</th>
			<td><%=employeesdto.getEmpName()%></td>
		</tr>
		<tr>
			<th>입사일</th>
			<td><%=employeesdto.getJoinDate()%></td>
		</tr>
		<tr>
			<th>번호</th>
			<td><%=employeesdto.getEmpPhone()%></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=employeesdto.getEmail()%></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><%=employeesdto.getAddress()%></td>
		</tr>	
	</tbody>
</table>
	</div>
</div>

<!-- <div class="row text-left"> -->
<!-- 		<h4>내가 작성한 게시글</h4> -->
<!-- 	</div> -->
<!-- 	<div class="row text-left"> -->
<!-- 		<ul class="my-board-list"> -->
<%-- 			<%for(boardDto boarddto : myList){ %> --%>
<!-- 			<li> -->
<%-- 				<a href="<%=request.getContextPath()%>/board/boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>"> --%>
<%-- 					<%=boarddto.getBoTitle()%> --%>
<!-- 				</a> -->
<!-- 			</li> -->
<%-- 			<%} %> --%>
<!-- 		</ul> -->
<!-- 	</div> -->

<div class="container-1200 text-right" style="border: none; border-bottom: 2px solid rgb(102, 177, 227); margin-bottom: 10px;">
<a class="pn" href = "<%=request.getContextPath()%>/login/loginInfoEdit.jsp" style="text-decoration: none;">회원정보 수정</a>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>