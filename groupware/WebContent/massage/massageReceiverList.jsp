<%@page import="groupware.beans.MassageDto"%>
<%@page import="groupware.beans.MassageDao"%>
<%@page import="groupware.beans.MassageListDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//발신함과 다르게 수신함의 경우 수신자 번호를 별도로 받아야 조회가 가능하다.
String e2_no = (String)request.getSession().getAttribute("id"); //수신자 번호 가져오기
MassageListDao massageListDao = new MassageListDao();
// List<MassageListDto> list = massageListDao.list_receiver(e2_no);


//pagination 구현 : 검색창은 존재하지 않는다.
int page_no; //현재 페이지 번호
try{
	page_no =Integer.parseInt(request.getParameter("page_no"));
	if(page_no<1){
		throw new Exception();
	}
}catch(Exception e){
	page_no=1;
}


int page_size; //한 페이지에 보여줄 목록 갯수
try{
	page_size=Integer.parseInt(request.getParameter("page_size"));
	if(page_size<5) throw new Exception();
}catch(Exception e){
	page_size=5;
}
 
int start_row = page_no*page_size-(page_size-1);
int end_row = page_no*page_size;

List<MassageListDto> list =massageListDao.list_receiver(e2_no, start_row, end_row);




//페이지네이션 네비게이션 블록
int block_size = 10;
int start_block=((page_no-1)/block_size)*block_size+1;
int end_block =start_block + block_size-1;

MassageDao massageDao = new MassageDao();
int count = massageDao.getCount_receiverList(e2_no);

int last_block=(count+page_size-1)/page_size;

if(end_block>last_block){
	end_block=last_block;
}


%>


<jsp:include page="/template/header.jsp"></jsp:include>




<div>
	<div>
		<h2>메세지 수신함</h2>
	</div>
	
	<div>
		<table class="table table-border">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>보낸사람</th>
					<th>받는사람</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%for(MassageListDto massageListDto : list) {%>
				<tr>
					<td><%=massageListDto.getM_no() %></td>
					<td>
						<a href ="massageDetail.jsp?m_no=<%=massageListDto.getM_no()%>">
						
						<%=massageListDto.getM_name() %></a>
				
					</td>
					<td><%=massageListDto.getEmp_name() %></td>
					<td><%=massageListDto.getE2_name() %></td>
					<td><%=massageListDto.getM_date() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<!-- 페이지네이션 블록 -->
	<div class="row text-center">
	
	
			<%for(int i=start_block; i<=end_block; i++) {%>
				<%if(i==page_no) { %>
				<a class="on" href="massageReceiverList.jsp?page_no=<%=i%>"><%=i%></a>
				<%} else{ %>
				<a href="massageReceiverList.jsp?page_no=<%=i%>"><%=i%></a>
				<%} %>
			<%} %>
		
	</div>
	
	<div>
		<h4>로그인상태: <%=request.getSession().getAttribute("id") %></h4>
	</div>


</div>
