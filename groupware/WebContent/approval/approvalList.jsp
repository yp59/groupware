<%@page import="java.util.List"%>
<%@page import="groupware.beans.approvalDto"%>
<%@page import="groupware.beans.approvalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");

	String keyword = request.getParameter("keyword");
	
	boolean isSearch = keyword!=null&&!keyword.trim().equals("");
	
	//////////////////////////페이지네이션/////////////////////////
	
	int pageNo;
	
	try{
		pageNo =Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo<1){
			throw new Exception();
		}
		
		
	}catch(Exception e){
		pageNo = 1;//기본 페이지
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
	//rownum의 시작번호와 종료번호를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	///////////////////////////페이지네이션///////////////////////////
	
	
	approvalDao approvaldao = new approvalDao();
	List<approvalDto> list ;

	if(isSearch){//검색 시 기안서 리스트 출력
		list = approvaldao.approvalMainSearch(id, keyword, startRow, endRow);
		
	}
	else{//일반 기안서 출력
		list = approvaldao.approvalMainList(id, startRow, endRow);
	}
	/////////////////////////////////////////////////////////////////////
	// 페이지 네비게이션 영역 계산
	/////////////////////////////////////////////////////////////////////
	// = 하단에 표시되는 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정
	// = 하단 네비게이션 숫자는 startBlock 부터 endBlock 까지 출력
	// = (주의사항) 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리
	int count;
	if(isSearch){
	
	count = approvaldao.getMainCount(id, keyword);
	}
	else{
	count = approvaldao.getMainCount(id);
	}
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//int lastBlock = (count - 1) / pageSize + 1;
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
	//검색어 저장값
	$(function(){
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

<script>

$(function(){
	
/*
	////////////////////////////////////////////////////////////////////////
	var _width = '700';
    var _height = '700';
 
    // 팝업을 가운데 위치시키기 위해 아래와 같이 값 구하기
    var _left = Math.ceil(( window.screen.width - _width )/2);
    var _top = Math.ceil(( window.screen.height - _height )/2);
    
var option ='width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top ;
	$("#approvalDetail").click(function(){
		
		   var pop_title = "appDetail" ;//팝업 이름 설정
		   window.open("approvalDetail.jsp",pop_title,option);//어느 jsp를 열고 팝업의 이름은 무엇이며 어떤 옵션을 줄것인지 설정 
		    
		   document.popUpDetail.target = pop_title;//popUPname과 target의 이름은 동일해야한다?
		    document.popUpDetail.action = "approvalDetail.jsp" ;//어떤 페이지로 데이터를 보낼지 설정  
		    popUpDetail.submit() ;     //form의 submit을 선언해줌
		    
		    
	});
///////////////////////////////////////////////////////////////////////////////
*/
		
	
	
});
</script>
<div class = "container-1200">
<div style="text-align: center; border-bottom: 2px solid rgb(102, 177, 227); margin-bottom: 10px;">
<h2>나의 결재 목록</h2>
</div>

<form class = "search-form" action="approvalList.jsp">
<input type="hidden" name="pageNo">

<div class = "text-right">
<input type="text" name="keyword" placeholder="기안서 검색"><!-- 검색 keyword 입력창-->
<input class = "link-btn" type ="submit" value = "검색">
</div>

</form>
<!-- appNo가 한번에 들어감 why? -->
<table class="table table-border table-hover" >
		<thead>
			<tr>
				<th>결재 서류 번호</th>
				<th>결재 분류</th><!-- (미결예결후결합의반려거부참조시행) 들어오는 자리 결재일은 detail에서만 표시하자.
				insert에서 결재순서에따라 type을 넣어주는 값도 수정해야된다.-->
				<th>제목</th>
				<th>기안자</th>
				<th>기안일</th>
				<th>마감일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody><%for(approvalDto approvaldto : list){%>
				<tr>
					<td><%=approvaldto.getAppNo()%></td>
					<td><%=approvaldto.getDirType() %></td>
					<td >
					<a href="<%=request.getContextPath()%>
					/approval/approvalDetail.jsp?appNo=
					<%=approvaldto.getAppNo()%>&DirType=<%=approvaldto.getDirType()%>&appState=<%=approvaldto.getAppState()%>" 
					onclick="window.name = 'appList'; window.open(this.href, '_blank', 'width=750, height=750'); return false;">
					<!-- 기안서에 현재 선택한 appNo을 보내는 구문 -->	
					<%=approvaldto.getAppTitle()%>
					</a>	
					
					</td>
					<td><%=approvaldto.getEmpName()%>
					</td>
					<td><%=approvaldto.getAppDateStart().substring(0, 10)%></td>
					<td><%=approvaldto.getAppDateEnd().substring(0, 10)%></td>
					<td><%=approvaldto.getAppState()%></td>
			
				</tr>
				
				
		<%}%>
		</tbody>
</table>
<!-- 일단 appNo만 보내고 필요시 다른 것도 보내주도록 설정 -->
</div>
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


<jsp:include page="/template/footer.jsp"></jsp:include>