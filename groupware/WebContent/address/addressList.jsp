<%@page import="groupware.beans.employeesDao"%>
<%@page import="groupware.beans.AddressListDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AddressListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

// AddressListDao addressListDao = new AddressListDao();
// List<AddressListDto>list= addressListDao.list();

String empNo = (String)request.getSession().getAttribute("id");
employeesDao empDao = new employeesDao();
String empName = empDao.getName(empNo); //empNo ->empName 호출


//pagination 구현 
String type = request.getParameter("type");
String keyword=request.getParameter("keyword");

boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");

int page_no;
try{
	page_no=Integer.parseInt(request.getParameter("page_no"));
	if(page_no<1) throw new Exception();
}catch(Exception e){
	page_no=1;
}

int page_size;
try{
	page_size=Integer.parseInt(request.getParameter("page_size"));
	if(page_size<10) throw new Exception();
}catch(Exception e){
	page_size=10;
}	

int start_row = page_no * page_size-(page_size-1);
int end_row = page_no * page_size;

AddressListDao addressListDao = new AddressListDao();
List<AddressListDto>list;
if(isSearch){
	list= addressListDao.search(type, keyword, start_row, end_row);
}else{
	list =addressListDao.list(start_row, end_row);
}



int block_size =10;
int start_block=(page_no-1)/block_size* block_size+1;
int end_block= start_block + block_size-1;

int count;
if(isSearch){
	count=addressListDao.getCount(type, keyword);
}else{
	count=addressListDao.getCount();
}

int last_block = (count+page_size-1)/page_size;

if(end_block>last_block) end_block=last_block;


//관리자 기능 추가
int authLev = (int)request.getSession().getAttribute("authorityLevel");
int getParameter;
try{
	 getParameter = Integer.parseInt(request.getParameter("manage"));
}catch(Exception e){
	 getParameter = 0;	
}
boolean isManage = authLev==1 && getParameter==1 ;
%>




<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	h2{
/* 		color:gray; */
		text-align:center;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 

<%if(isSearch) {%>
<script>
	$(function(){
		$("select[name=type]").val("<%=type%>");
		$("input[name=keyword]").val("<%=keyword%>");
	
	});

</script>
<%} %>
<script>
$(function(){
	$(".pagination>a").click(function(){
		

		var page_no=$(this).text();
		$("input[name=page_no]").val(page_no);
		
		if(page_no==="이전"){ 
			var page_no = parseInt($(".pagination>a:not(.move-link)").first().text())-1;
			$("input[name=page_no]").val(page_no);
			$(".search-form").submit();
			
		}else if(page_no==="다음"){
			var page_no = parseInt($(".pagination>a:not(.move-link)").last().text())+1;
			$("input[name=page_no]").val(page_no);
			$(".search-form").submit(); 
			
		}else{
			$("input[name=page_no]").val(page_no);
		
			$(".search-form").submit(); 
		}
	
	});
});
	



</script>



<div class="container-800">
	<div class="row">
		<%if(isManage) {%>
		<h2>사원관리</h2>
		<%} else { %>
		<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">주소록</h2>
		<%} %>
	</div>
	<!-- 관리자일 경우에만 사원등록 기능 이용가능 -->
	<%if(isManage) {%>
	<div class="row">
		<a class="link-btn" href="<%=request.getContextPath()%>/login/signUp.jsp">사원등록</a>
	</div>
	<%} %>
	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>부서</th>
					<th>직급</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<%if(!isManage) {%>
					<th>메세지 보내기</th>
					<%} %>
				</tr>
			</thead>
			<tbody>
				<%for(AddressListDto addressListDto : list) {%>
				<tr>
					<td><%=addressListDto.getDepartment() %></td>
					<td><%=addressListDto.getPosi() %></td>
					<td>
						<a href="addressDetail.jsp?empNo=<%=addressListDto.getEmp_no()%>">
							<%=addressListDto.getEmp_name() %>
						</a>
					
					</td>
					
					<td><%=addressListDto.getEmp_phone() %></td>
					<td><%=addressListDto.getEmail() %></td>
					
				<%if(!isManage) {%>
					<!-- 쪽지기능 넣기 : empNo를 파라미터로 넣어서 보낸다. --> 
					<%if(empName.equals(addressListDto.getEmp_name())) {//나라면%>
					<td>-</td>
					<%} else{ %>
					<td>
						<a class="link-btn" href="<%=request.getContextPath()%>/massage/massageInsert.jsp?empNo=<%=addressListDto.getEmp_no()%>">쪽지</a>
					</td>
					<%} %>
				<%} %>	
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<div class="row text-center">
		<div class="pagination">
			<%if(start_block>1) {%>
			<a class="move-link">이전</a>
			<%} %>
		
		
			<%for(int i=start_block;i<=end_block;i++) {%>
				<%if(i==page_no) {%>
				<a class="on"><%=i%></a> 
				<%} else{ %>
				<a><%=i%></a> 
				<%} %>
			
			
			<%} %>
		
		
			<%if(end_block<last_block) {%>
				<a class="move-link">다음</a>
			<%} %>
		</div>
			
	</div>
	<div class="row text-center">
		<form class="search-form" action="addressList.jsp" method="get">
			<input type="hidden" name="page_no">
			<input type="hidden" name="manage" value="1">
			
			<select name="type">
				<option value="emp_name">이름</option>
				<option value="department">부서</option>
			</select>
			<input type="text" name="keyword" placeholder="키워드">
			<input type="submit" value="조회하기">
		</form>
	</div>
	
	

</div>




<jsp:include page="/template/footer.jsp"></jsp:include>