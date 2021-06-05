<%@page import="java.util.List"%>
<%@page import="groupware.beans.BoardCommentsDao"%>
<%@page import="groupware.beans.BoardCommentsDto"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int boardNo = Integer.parseInt(request.getParameter("boardNo"));

boardDao boarddao = new boardDao();
boardDto boarddto = boarddao.detail(boardNo);

// 이전글 정보 불러오기
boardDto prevBoardDto = boarddao.getPrevious(boardNo);

// 다음글 정보 불러오기
boardDto nextBoardDto = boarddao.getNext(boardNo);

// 타인의 게시글에만 조회수 증가
String empNo = (String)session.getAttribute("id");
Set<Integer> boardNoSet;
if(session.getAttribute("boardNoSet") != null){
	boardNoSet = (Set<Integer>)session.getAttribute("boardNoSet");
}
else{
	boardNoSet = new HashSet<>();
}
if(boardNoSet.add(boardNo)){
	boarddao.boCount(boardNo, empNo);
}

	String loginId = (String)session.getAttribute("id");
	String writerId = boarddto.getEmpNo();
//--작성자 아이디와 접속한 아이디 비교하기 위한 변수 loginId(접속 아이디) writerId(게시글 작성자 아이디)

int authoritylevel = ((Integer)(session.getAttribute("authorityLevel"))).intValue();

	BoardCommentsDao boardCommentsDao = new BoardCommentsDao();
	List<BoardCommentsDto> boardCommentsList = boardCommentsDao.list1(boardNo);
%>    
    
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>
<style>
.pn > a:link, a:visited {
  color : rgb(52, 152, 219);
text-decoration: none;
}
.form-btn.btn-cancle-js {
	width:auto;
	background-color:gray !important;
	border-color:gray !important;
}
.form-btn.btn-cancle-js:hover {
	background-color:lightgray !important;
	color:gray !important;
	border-color:white;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$(".form-btn.btn-cancle-js").click(function(e){
			var choice = window.confirm("삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});
	
	$(function(){
		
		$(".com-edit-area").hide();
		
		$(".form-btn.form-btn-positive").click(function(){
			$(this).parent().parent().next().hide();
			$(this).parent().parent().next().next().show();
		});
		
		$(".form-btn.btn-cancle").click(function(){
			$(this).parent().parent().prev().show();
			$(this).parent().parent().hide();
		});
	});
</script>
<div style="color:rgb(52, 152, 219); font-size: 16px;">
<<%=boarddto.getBoType() %>>
</div>
<div class= "container-1200" style="border: none;">
<h2><%=boarddto.getBoTitle() %></h2>
</div>
<div class= "container-1200" style="border: none; border-top: 1px solid rgb(52, 152, 219); padding-top: 10px;">
<%-- 게시글 번호 : <%=boarddto.getBoardNo() %><br> --%>
작성자 : <%=boarddto.getEmpName() %><br>
조회수 : <%=boarddto.getBoCount() %><br>
작성일시 : <%=boarddto.getBoDate() %><br>
</div>
<div class ="row text-left" style="border: none; border-top: 1px solid rgb(52, 152, 219); border-bottom:1px solid rgb(52, 152, 219); min-height: 150px; padding-top: 20px;">
<%=boarddto.getBoContent() %>
</div>
<!-- 게시글 작성창 -->

<div class = "row text-right" style="border: none;">
<%if(loginId.equals(writerId)||authoritylevel==1){ %><!-- 접속한 아이디와 작성자 아이디가 같으면 수정과 삭제 가능
														 or 권한레벨이 1이면 게시글 수정 삭제 가능  -->
	<form action="boardDelete.gw" method="post">
	<a href = "boardmain.jsp" class="link-btn">목록보기</a>
	<a href = "boardEdit.jsp?boardNo=<%=boarddto.getBoardNo()%>" class="link-btn">수정하기</a>
		<input type="hidden" name="boardNo" value="<%=boarddto.getBoardNo()%>">
		<input class="link-btn" type="submit" value="삭제하기" style="width: 82px; height: 39px; font-size: 16px;">
	</form>
<%}else{ }%>	

<!-- 이전글 다음글 목록 -->

</div>
<div class="pn" style="border: none; text-align: left;">
다음글 :
<%if(nextBoardDto == null){ %>
다음글이 없습니다.
<%}else{ %>
<a href="boardDetail.jsp?boardNo=<%=nextBoardDto.getBoardNo()%>">
	<%=nextBoardDto.getBoTitle()%>
</a>
<%} %>
</div>

<div class="pn" style="border: none; text-align: left; padding-top: 5px; border-bottom:1px solid rgb(52, 152, 219); padding-bottom: 10px;">
이전글 :
<%if(prevBoardDto == null){ %>
이전글이 없습니다.
<%}else{ %>
<a href="boardDetail.jsp?boardNo=<%=prevBoardDto.getBoardNo()%>">
	<%=prevBoardDto.getBoTitle()%>
</a>
<%} %>
</div>

<!-- 댓글 목록창 -->

<div class="row text-left" style="border: none; border-bottom:1px solid rgb(52, 152, 219);" >
		<h4>댓글 목록</h4>
	</div>
	<%for(BoardCommentsDto boardCommentsDto : boardCommentsList) { %>
	<div class="row text-left" style="border:none; border-bottom:1px solid rgb(52, 152, 219); padding-bottom: 5px;">
		<div class="row" style="border: none; text-align: left;">
			<div class="left"><%=boardCommentsDto.getEmpName()%></div>
		<%if(loginId.equals(boardCommentsDto.getEmpNo())){ %>
			<div class="row" style="border: none; border-bottom:1px dotted rgb(52, 152, 219); text-align: right; padding-bottom: 15px;">
				<a class="form-btn form-btn-positive">수정</a> 
				<a class="form-btn btn-cancle-js" href="comDelete.gw?comNo=<%=boardCommentsDto.getComNo()%>&boardNo=<%=boardNo%>" style="text-decoration: none;">삭제</a>
			</div>
			<%} %>
		</div>
<div class="com-display-area">
			<pre><%=boardCommentsDto.getComContent()%></pre>
		</div>
		
		
		<%if(loginId.equals(boardCommentsDto.getEmpNo())){ %>
		<div class="com-edit-area">
			<form action="comEdit.gw" method="post">
				<input type="hidden" name="comNo" value="<%=boardCommentsDto.getComNo()%>">
				<input type="hidden" name="boardNo" value="<%=boardCommentsDto.getBoardNo()%>">
				
				<textarea name="comContent" style="resize: none; width: 1200px;" required><%=boardCommentsDto.getComContent()%></textarea>
				<input class="form-btn form-btn-positive" type="submit" value="댓글 수정" style="width: 80px;">		
				<input class="form-btn btn-cancle" type="button" value="작성 취소">		
			</form>
		</div> 
		<%} %>
		<div><%=boardCommentsDto.getDate().toLocaleString()%></div>
	</div>
	<%} %>
	
<!-- 댓글 작성 창 -->

<form action="comInsert.gw" method="post"> 
<input type="hidden" name="boardNo" value="<%=boardNo%>">
<input type="hidden" name="empNo" value="<%=empNo%>">
	<div class="container-1200" style="border: none;">
		<textarea rows="3" class="form-input" required name="comContent" placeholder="댓글 입력" style="resize: none;"></textarea>
	</div>
	<div class="row">
		<input type="submit" value="댓글 작성" class="form-btn">
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>
