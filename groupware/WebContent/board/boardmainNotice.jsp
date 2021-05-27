<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.boardDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.boardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	
		
		String boType = request.getParameter("boType");//아래의 검색창에서 입력받은 boType을 String 변수로 저장
		String type = request.getParameter("type");//아래의 검색창에서 입력받은 type(제목,내용,작성자)을 String 변수로 저장
		String keyword = request.getParameter("keyword");//아래의 검색창에서 입력받은 keyword를 String 변수로 저장
		
		boolean isSearch = boType != null && type != null && keyword != null && !keyword.trim().equals("");
		//각 parameter값이 null인지 확인하고 null이 아니면 검색을 실행한다.
	
	
	/////////////////////////////////////////////////////////////////////////////
	//	페이지 번호를 이용한 계산 과정
	/////////////////////////////////////////////////////////////////////////////
	//(1) 페이지 번호는 있을 수도, 없을 수도 있다.
	//	- 있으면 해당 페이지 번호에 맞게 조회, 없으면 1페이지를 조회
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
	
	if(isSearch){
		
		if(boType.equals("전체")){//boType이 '전체' 값이면 botype에 상관없이 제목 글쓴이 내용에 관해서만 keyword로 검색을 한다.
			list=boarddao.boardSearch(type, keyword, startRow, endRow);

		}
		
		else{//boType 값에 따라(질문,공지,자유) 선택된 게시글 중 제목,글쓴이,내용에 대해서 keyword로 검색을 한다.
			list=boarddao.boardSearch(boType,type,keyword,startRow,endRow);	

		}
	}

	else{//검색한 parameter값이 모두 null이면 일반 게시글을 나타낸다.
		list=boarddao.boardList(startRow,endRow,"공지");
	}
	
	
	/////////////////////////////////////////////////////////////////////
	// 페이지 네비게이션 영역 계산
	/////////////////////////////////////////////////////////////////////
	// = 하단에 표시되는 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정
	// = 하단 네비게이션 숫자는 startBlock 부터 endBlock 까지 출력
	// = (주의사항) 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리
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
		count = boarddao.getCount("공지");
	}
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
// 	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/section.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%if(isSearch){ %>
<script>
	//서버에서 수신한 botype과 type과 keyword에 해당하는 값들을 각각의 입력창에 설정하여 유지되는것처럼 보이도록 구현
	$(function(){
		$("select[name=boType]").val("<%=boType%>");
		$("select[name=type]").val("<%=type%>");
		$("input[name=keyword]").val("<%=keyword%>");
	});
</script>
<%} %>

<script>
	//페이지 네비게이션에 있는 a태그를 누르면 전송하는 것이 아니라 form 내부에 값을 설정한 뒤 form을 전송
	//= 검색어, 검색분류, 페이지번호, 페이지크기까지 한 번에 전송해야 화면이 유지되기 때문
	$(function(){
		$(".pagination > a").click(function(){
			//주인공 == a태그
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
		<tbody>
				<%for(boardDto boarddto : list){ 
				if(boarddto.getBoType().equals("공지")){%><!-- 타입이 공지이면 게시글을 나타낸다 -->
				<tr>
					<td><a href="boardDetail.jsp?boardNo=<%=boarddto.getBoardNo()%>">
					<%=boarddto.getBoTitle()%></a></td>
					<td><%=boarddto.getEmpName()%></td>
					<td><%=boarddto.getBoType() %></td>
					<td><%=boarddto.getBoCount()%></td>
					<td><%=boarddto.getBoDate().substring(0, 10)%></td>
				</tr><%}
				}//게시글 타입이 자유가 아닌것도 pageSize로 책정되기 때문에 해결해야함   %>
					
				
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
	
	<form class="search-form" action="boardmainNotice.jsp" method="get"><!-- 검색창 form 태그 -->
	<input type="hidden" name="pageNo">
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