<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	boardDao boarddao = new boardDao();
	List<boardDto> list ;
	
	String boType = request.getParameter("boType");//아래의 검색창에서 입력받은 boType을 String 변수로 저장
	String type = request.getParameter("type");//아래의 검색창에서 입력받은 type(제목,내용,작성자)을 String 변수로 저장
	String keyword = request.getParameter("keyword");//아래의 검색창에서 입력받은 keyword를 String 변수로 저장
	
	boolean isSearch = boType != null && type != null && keyword != null;
	//각 parameter값이 null인지 확인하고 null이 아니면 검색을 실행한다.
	
	if(isSearch){
	
	if(boType.equals("전체")){//boType이 '전체' 값이면 botype에 상관없이 제목 글쓴이 내용에 관해서만 keyword로 검색을 한다.
		list=boarddao.boardSearch(type,keyword);
	
	}
	
	else{//boType 값에 따라(질문,공지,자유) 선택된 게시글 중 제목,글쓴이,내용에 대해서 keyword로 검색을 한다.
		list=boarddao.boardSearch(boType,type,keyword);	
	
	}
	}
	
	else{//검색한 parameter값이 모두 null이면 일반 게시글을 나타낸다.
	list=boarddao.boardList();
	}

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
				if(boarddto.getBoType().equals("자유")){%><!-- 타입이 자유이면 게시글을 나타낸다 -->
				<tr>
					<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%></a></td>
					<td><%=boarddto.getEmpName()%></td>
					<td><%=boarddto.getBoType() %></td>
					<td><%=boarddto.getBoCount()%></td>
					<td><%=boarddto.getBoDate().substring(0, 10)%></td>
				</tr><%}else{	}
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
	<div class ="container-900 text-center">
	
	<form action="boardmain.jsp" method="get"><!-- 검색창 form 태그 -->
	
		<select name="boType">	<!-- boType의 select 화면으로 공지 질문 자유 전체 중 하나 선택가능하다. -->
			<option>전체</option>
			<option>공지</option>
			<option>질문</option>
			<option>자유</option>
		</select>
		
		<select name="type"> 	<!-- 두번째 type select로 제목 글 작성자 내용 중 하나 선택해서 검색가능 -->
			<option value="bo_title">제목</option>
			<option value="emp_name">글작성자</option>
			<option value="bo_content">내용</option>
		</select>
		
		<input type="text" name="keyword" placeholder="게시글 검색"><!-- 검색 keyword 입력창-->
		<input type="submit" value="검색">
	</form>
	
	</div>

<div class ="container-900 text-right">
	<a href="boardInsert.jsp" class=link-btn>게시글 작성</a>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>

