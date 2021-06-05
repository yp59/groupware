<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.ScheduleEndDao"%>
<%@page import="groupware.beans.ScheduleEndDto"%>
<%@page import="groupware.beans.ScheduleIngDto"%>
<%@page import="groupware.beans.ScheduleIngDao"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<% 
request.setCharacterEncoding("UTF-8");//
// 1=ing, 2=end를 의미한다.
////////////////////////////////////
///////////////////////////////////
//ing 검색
String type1 = request.getParameter("type1");
String keyword1 = request.getParameter("keyword1");

boolean isSearch1 = type1 != null && keyword1 != null && !keyword1.trim().equals("");
int page_no1; //현재 페이지 번호
try{
	page_no1=Integer.parseInt(request.getParameter("page_no1"));
	if(page_no1<1){ //1미만이면 예외로 보내버림
		throw new Exception();
	}

}catch(Exception e){ //null일때(파라미터 안들어올때)
	page_no1=1; //기본값 설정
}

int pageSize1; //1페이지에 보여줄 글의 개수
try{
	pageSize1=Integer.parseInt(request.getParameter("pageSize1"));
	if(pageSize1<5) throw new Exception(); //강제 예외 처리
}catch(Exception e){
	pageSize1=5; //기본값 설정
}
//2.로우넘을 통한 start_row와 end_row 도출
int startRow1 = page_no1 * pageSize1 - (pageSize1-1); //한 페이지의 시작번호
int endRow1 = page_no1 * pageSize1;	//한 페이지의 끝번호



ScheduleIngDao scheduleIngDao = new ScheduleIngDao();
List<ScheduleIngDto> list_ing;
if(isSearch1){ // 패러미터가 있는 경우 --> 검색호출 한다.
	list_ing = scheduleIngDao.search(type1, keyword1, startRow1, endRow1);
		
}else{
	list_ing = scheduleIngDao.list_ing_pagination(startRow1, endRow1);
}
//페이지네이션 네비게이션 블록 계산
//하단 표시 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정한다.
//하단 네비게이션 숫자는 startBlock부터 endBlock까지 출력한다.

//마지막 주의: 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리한다.


int blockSize1 = 10;
int startBlock1 = (page_no1 - 1) / blockSize1 * blockSize1 + 1;
int endBlock1 = startBlock1 + blockSize1 - 1;

ScheduleDao scheduleDao = new ScheduleDao();

int count1; //검색일때와 아닐 때의 count가 달라짐으로 각각구해야 한다.
if(isSearch1){
	count1= scheduleDao.getCount1(type1,keyword1); //검색일때 count 구하기
}else{
	count1=scheduleDao.getCount1(); //목록일때 count구하기
}

int lastBlock1=(count1+pageSize1-1)/pageSize1;
//int lastBlock=(count-1)/pageSize+1; 위의 식과 결과값이 같다.

if(endBlock1>lastBlock1){ //endBlock이 lastBlock보다 크다면 endBlock을 lastBlock으로 덮어씌운다.
	endBlock1=lastBlock1;
}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//end 검색
String type2 = request.getParameter("type2");
String keyword2 = request.getParameter("keyword2");
boolean isSearch2 = type2 != null && keyword2 != null && !keyword2.trim().equals("");

int page_no2; //현재 페이지 번호
try{
	page_no2=Integer.parseInt(request.getParameter("page_no2"));
	if(page_no2<1){ //1미만이면 예외로 보내버림
		throw new Exception();
	}

}catch(Exception e){ //null일때(파라미터 안들어올때)
	page_no2=1; //기본값 설정
}


int pageSize2; //1페이지에 보여줄 글의 개수

try{
	pageSize2=Integer.parseInt(request.getParameter("pageSize2"));
	if(pageSize2<5) throw new Exception(); //강제 예외 처리
}catch(Exception e){
	pageSize2=5; //기본값 설정
}


//2.로우넘을 통한 start_row와 end_row 도출
int startRow2 = page_no2 * pageSize2 - (pageSize2-1); //한 페이지의 시작번호
int endRow2 = page_no2 * pageSize2;	//한 페이지의 끝번호

ScheduleEndDao scheduleEndDao = new ScheduleEndDao();
List<ScheduleEndDto> list_end;
if(isSearch2){ // 패러미터가 있는 경우 --> 검색호출 한다.
	list_end = scheduleEndDao.search(type2, keyword2, startRow2, endRow2);
		
}else{
	list_end = scheduleEndDao.list_end_pagination(startRow2, endRow2);
}

//페이지네이션 네비게이션 블록 계산
//하단 표시 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정한다.
//하단 네비게이션 숫자는 startBlock부터 endBlock까지 출력한다.

//마지막 주의: 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리한다.


int blockSize2 = 10;
int startBlock2 = (page_no2 - 1) / blockSize2 * blockSize2 + 1;
int endBlock2 = startBlock2 + blockSize2 - 1;

// ScheduleDao scheduleDao = new ScheduleDao();

int count2; //검색일때와 아닐 때의 count가 달라짐으로 각각구해야 한다.
if(isSearch2){
	count2= scheduleDao.getCount2(type2,keyword2); //검색일때 count 구하기
}else{
	count2=scheduleDao.getCount2(); //목록일때 count구하기
}

int lastBlock2=(count2+pageSize2-1)/pageSize2;
//int lastBlock=(count-1)/pageSize+1; 위의 식과 결과값이 같다.

if(endBlock2>lastBlock2){ //endBlock이 lastBlock보다 크다면 endBlock을 lastBlock으로 덮어씌운다.
	endBlock2=lastBlock2;
}




%>



<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 



<% if(isSearch1) {%>
	<script>
	// 1. ing가 검색일 경우에만 
	
	$(function(){
		$("select[name=type1]").val("<%=type1%>");
		$("input[name=keyword1]").val("<%=keyword1%>");

	});
	
	</script>
<%} %>

<% if(isSearch2) {%>
	<script>
	//2. end가 검색일 경우에만
	
	$(function(){
		$("select[name=type2]").val("<%=type2%>");
		$("input[name=keyword2]").val("<%=keyword2%>");

	
	});
	
</script>
<%} %>

<script>
	//페이지 네비게이션에 있는 a태그를 누르면 전송하는 것이 아니라 form 내부에 값을 설정한 후 form을 전송
	//검색어, 검색분류, 페이지번호, 페이지크기까지 한 번에 전송해야 화면이 유지되기 때문이다.
	$(function(){
		$(".pagination1>a").click(function(){
			
			//a태그의 value를 불러와서 var= page_no에 넣는 코드.
			var page_no1=$(this).text();//.text() 안에 입력값을 안넣으면 불러와서 넣겠다는 의미.
			$("input[name=page_no1]").val(page_no1);
			
			if(page_no1=="이전"){ //이전 링크 눌렀을 때
				var page_no1 = parseInt($(".pagination1>a:not(.move-link1)").first().text())-1;
				//현재 링크중 .move-link를 제외한 첫번째 항목의 pareInt형 에서 -1
				$("input[name=page_no1]").val(page_no1);
				$(".search-form1").submit(); // 강제서브밋 
				
			}else if(page_no1=="다음"){//다음 링크 눌렀을 때
				var page_no1 = parseInt($(".pagination1>a:not(.move-link1)").last().text())+1;
				//현재 링크중 .move-link를 제외한 마지막 항목의 pareInt형 에서 +1
				$("input[name=page_no1]").val(page_no1);
				$(".search-form1").submit(); // 강제서브밋 
				
			}else{//숫자링크 눌렀을 때
				$("input[name=page_no1]").val(page_no1);
				//트리거:강제서브밋 발생
				$(".search-form1").submit(); // 강제서브밋 
			}
		
		});
	});
	
	

</script>
<script>
	//페이지 네비게이션에 있는 a태그를 누르면 전송하는 것이 아니라 form 내부에 값을 설정한 후 form을 전송
	//검색어, 검색분류, 페이지번호, 페이지크기까지 한 번에 전송해야 화면이 유지되기 때문이다.
	$(function(){
		$(".pagination2>a").click(function(){
			
			//a태그의 value를 불러와서 var= page_no에 넣는 코드.
			var page_no2=$(this).text();//.text() 안에 입력값을 안넣으면 불러와서 넣겠다는 의미.
			$("input[name=page_no2]").val(page_no2);
			
			if(page_no2=="이전"){ //이전 링크 눌렀을 때
				var page_no2 = parseInt($(".pagination>a:not(.move-link2)").first().text())-1;
				//현재 링크중 .move-link를 제외한 첫번째 항목의 pareInt형 에서 -1
				$("input[name=page_no2]").val(page_no2);
				$(".search-form2").submit(); // 강제서브밋 
				
			}else if(page_no2=="다음"){//다음 링크 눌렀을 때
				var page_no2 = parseInt($(".pagination2>a:not(.move-link2)").last().text())+1;
				//현재 링크중 .move-link를 제외한 마지막 항목의 pareInt형 에서 +1
				$("input[name=page_no2]").val(page_no2);
				$(".search-form2").submit(); // 강제서브밋 
				
			}else{//숫자링크 눌렀을 때
				$("input[name=page_no2]").val(page_no2);
				//트리거:강제서브밋 발생
				$(".search-form2").submit(); // 강제서브밋 
			}
		
		});
	});

</script>

<style>
	.table>tbody>tr>td{
	font-size:0.8rem;
	}

	
	
	
	
	.form-input {
		width:50%;
		padding:0.2rem;
		outline:none;
	}
	.form-btn{
		width:65%;
		padding:0.2rem;
		outline:none;
	}
	
	
	
	
	.form-select{
		width:15%;
		padding:0.2rem;
		outline:none;
	}
	
	h4{
		margin-left:auto;
		margin-right:auto;
		width:30%;
		background-color: rgb(52, 152, 219);
		color:white;
		border-radius:7px;
	}
	
	
	
</style>



<div class="container-1200">
	<div class="row">

		<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">일정관리</h2>

	</div>
	<div class="row text-right">
		<a href="scheduleInsert.jsp" class="link-btn">새일정</a>
	</div>
	
	<div class="float-container">
		
		<!-- 완료 일정 영역 -->
		<div class="multi-container">

		<div class="row">
			<h4 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px; border-top: 2px solid rgb(52, 152, 219); padding-top: 20px;">완료된 일정</h4></div>

		<div class="row">
			<table class="table table-border">
				<thead>
					<tr>
						<th>상황</th>
						<th>번호</th>
						<th>부서</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>마감일</th>
					</tr>
				</thead>
				<tbody>
					<%for(ScheduleEndDto scheduleEndDto:list_end) {%>
					<tr>
						<td><%=scheduleEndDto.getSc_state() %></td>
						<td><%=scheduleEndDto.getSc_no() %></td>
						<td><%=scheduleEndDto.getDep_name() %>
						<td>
							<a href="scheduleDetail.jsp?sc_no=<%=scheduleEndDto.getSc_no()%>">
							<%=scheduleEndDto.getSc_name() %>
							</a>
						</td>
						<td><%=scheduleEndDto.getEmpName() %></td>
						<td><%=scheduleEndDto.getSc_made().substring(0,10) %></td>
						<td><%=scheduleEndDto.getSc_deadline().substring(0,10) %></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		
		<!-- 페이지네이션 블록 자리 2 : end -->
		<div class="row text-center">
			<div class="pagination2">
				<% if(startBlock2>1) {%>
				<a class="move-link2">이전</a>
				<%} %>
			
				<%for(int i=startBlock2; i<=endBlock2;i++) {%>
					<%if(i==page_no2) {%>	
						<a class="on"><%=i %></a>
					<%} else {%>
						<a><%=i %></a>
					<%} %>
				<%} %>
				
				<%if(endBlock2<lastBlock2) {%>
					<a class="move-link2">다음</a>
				<%} %>
			</div>
		
		 
		</div>
		
		<!-- 검색화면 2 : end -->
		<div class="row text-center">	
			<form class="search-form2" action="scheduleList.jsp" method="get">
				<input type="hidden" name="page_no2" >
				<select name="type2" class="form-select">
					<option value="dep_name">부서</option>
					<option value="sc_name">제목</option>
					<option value="emp_name">이름</option>
				</select>
				<input type="text" name="keyword2" placeholder="키워드" class="form-input">
				<input type="submit" value="조회하기" class="form-btn" style="margin-top: 10px;">
			</form>
		</div>
		</div>
		<!-- 일정2 끝 -->
		
		
<!-- ---------------------------------------------------------------------------- -->	
		<!-- 진행중 일정 영역 -->
		<div class="multi-container">

		<div class="row">
			<h4 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px; border-top: 2px solid rgb(52, 152, 219); padding-top: 20px;">진행중인 일정</h4>

		</div>
		<div class="row">
			<table class="table table-border">
				<thead>
					<tr>
						<th>상황</th>
						<th>번호</th>
						<th>부서</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>마감일</th>
					</tr>
				</thead>
				<tbody>
					<%for(ScheduleIngDto scheduleIngDto:list_ing) {%>
					<tr>
						<td><%=scheduleIngDto.getSc_state() %></td>
						<td><%=scheduleIngDto.getSc_no() %></td>
						<td><%=scheduleIngDto.getDep_name() %>
						<td>
							<a href="scheduleDetail.jsp?sc_no=<%=scheduleIngDto.getSc_no()%>">
							<%=scheduleIngDto.getSc_name() %>
							</a>
						</td>
						<td><%=scheduleIngDto.getEmpName() %></td>
						<td><%=scheduleIngDto.getSc_made().substring(0,10) %></td>
						<td><%=scheduleIngDto.getSc_deadline().substring(0,10) %></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		
	
		<!-- 페이지네이션 블록 자리 1 : ing -->
		<div class="row text-center">
			<div class="pagination1">
				<%if(startBlock1>1){ %> <!-- startBlock이 1보다 클때만 이전버튼이 보이게 설정 -->
			<a class="move-link1">이전</a> <!--이전구간으로: 누르면 10페이지로 가야한다. -->
			<%} %>
			
			
			<%for(int i=startBlock1;i<=endBlock1;i++){ %>
				<%if(i==page_no1) {%>
				<a class="on"><%=i%></a> 
				<%} else{ %>
				<a><%=i%></a> 
				<%} %>
				
				
			<%} %>
			
			<%if(endBlock1<lastBlock1) {%><!-- endBlock이 lastBlock보다 작을때만 이전버튼이 보이게 설정 -->
			<a class="move-link1">다음</a> <!--이후구간으로: 누르면 21페이지로 가야한다. -->
			<%} %>
			</div>
		
		
		</div>
		
		<!-- 검색화면 1 : ing -->
		<div class="row text-center">
			<form class="search-form1" action="scheduleList.jsp" method="get">
				<input type="hidden" name="page_no1">
				
				<select name="type1" class="form-select">
					<option value="dep_name">부서</option>
					<option value="sc_name">제목</option>
					<option value="emp_name">이름</option>
				</select>
				<input type="text" name="keyword1" placeholder="키워드" class="form-input">
				<input type="submit" value="조회하기" class="form-btn" style="margin-top: 10px;">
			</form>
		</div>
		
		</div>
		<!-- 일정 1 끝 -->
		
	
	
		
	</div>
	



</div>







<jsp:include page="/template/footer.jsp"></jsp:include>

