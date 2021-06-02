<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		String boType = request.getParameter("boType");
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
		
		boolean isSearch = boType != null && type != null && keyword != null && !keyword.trim().equals("");
	
	//	페이지 번호를 이용한 계산 과정
	int pageNo;//현재 페이지 번호
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 5;//페이지당 게시글 수 설정
	}
	
	//(2) rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	
	boardDao boarddao = new boardDao();
	List<boardDto> list ;	
	
	List<boardDto> noticeList = boarddao.boardList();//공지 상단 띄우기 위한 리스트 저장
	
	if(isSearch){
		
		if(boType.equals("전체")){
			list=boarddao.boardSearch(type, keyword, startRow, endRow);

		}
		
		else{
			list=boarddao.boardSearch(boType,type,keyword,startRow,endRow);	

		}
	}

	else{
		list=boarddao.boardList(startRow,endRow);
	}
	// 페이지 네비게이션 영역 계산
	int count;
	if(isSearch){
		if(boType.equals("전체")){
			count = boarddao.getCount(type, keyword);	
		}
		else{
			count = boarddao.getCount(boType,type,keyword); 
				
		}
	}
	else{
		count = boarddao.getCount();
	}
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){
		endBlock = lastBlock;
	}
	
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%if(isSearch){ %>
<script>
	$(function(){
		$("select[name=boType]").val("<%=boType%>");
		$("select[name=type]").val("<%=type%>");
		$("input[name=keyword]").val("<%=keyword%>");
	});
</script>
<%} %>

<script>
	$(function(){
		$(".pagination > a").click(function(){
			var pageNo = $(this).text();
			if(pageNo == "이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}	
			else if(pageNo == "다음"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
			else{//숫자 링크
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
		});
	});
</script>

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
		<tbody><%for(boardDto boarddto : noticeList){
				if(pageNo==1){// 1페이지인 경우에만 상단 공지 띄움
					if(boarddto.getBoType().equals("공지")){%><!-- 공지 게시글을 먼저 if문으로 구별해서 표의 상단에 위치하게 한다. -->
				<tr>
					<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%>
					<!-- 댓글 개수 출력 -->
					<%if(boarddto.getComComments() > 0){ %>
						[<%=boarddto.getComComments()%>]
						<%} %></a></td>
					<td><%=boarddto.getEmpName()%></td>
					<td><%=boarddto.getBoType() %></td>
					<td><%=boarddto.getBoCount()%></td>
					<td><%=boarddto.getBoDate().substring(0, 10)%></td>
				</tr><%}
				}
			}%>
				
				<%for(boardDto boarddto : list){ %>
					<tr>
						<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
						<%=boarddto.getBoTitle()%>
						<!-- 댓글 개수 출력 -->
						<%if(boarddto.getComComments() > 0){ %>
						[<%=boarddto.getComComments()%>]
						<%} %></a></td>
						<td><%=boarddto.getEmpName()%></td>
						<td><%=boarddto.getBoType() %></td>
						<td><%=boarddto.getBoCount()%></td>
						<td><%=boarddto.getBoDate().substring(0, 10)%></td>
					</tr><%}%>
					
				
		</tbody>
	</table>
	<div class="row">
		<!-- 페이지 네비게이션 자리 -->
		<div class="pagination">
		
			<%if(startBlock > 1){ %>
			<a class="move-link">이전</a>
			<%} %>
			
			<%for(int i = startBlock; i <= endBlock; i++){ %>
				<%if(i == pageNo){ %>
					<a class="on"><%=i%></a>
				<%}else{ %>
					<a><%=i%></a>
				<%} %>
			<%} %>
			
			<%if(endBlock < lastBlock){ %>
			<a class="move-link">다음</a>
			<%} %>
			
		</div>	
	</div>
</div>

	<div class ="container-900 text-center">
	
	<form class="search-form" action="boardmain.jsp" method="get"><!-- 검색창 form 태그 -->
	<input type="hidden" name="pageNo">
		<select name="boType">	<!-- boType의 select 화면으로 공지 질문 자유 전체 중 하나 선택 가능 -->
			<option>전체</option>
			<option>공지</option>
			<option>질문</option>
			<option>자유</option>
		</select>
		
		<select name="type"> 	<!-- 두번째 type select로 제목 글 작성자 내용 중 하나 선택해서 검색 가능 -->
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