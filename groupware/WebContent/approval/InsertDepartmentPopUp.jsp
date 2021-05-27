<%@page import="java.util.List"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/departmentPopUp.jsp"></jsp:include>
<%
employeesDao employeesdao = new employeesDao();//jquery와 jsp 는 연동이 안되기 때문에(jsp-->jquery는 가능)
List<employeesDto> insa = employeesdao.list("인사부");//화면을 미리 만들어두고 event에 따라 보여줄지 안보여줄지 선택
List<employeesDto> chong = employeesdao.list("총무부");
List<employeesDto> hwa = employeesdao.list("회계부");
List<employeesDto> gi = employeesdao.list("기획부");
List<employeesDto> young = employeesdao.list("영업부");
%>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

$(function(){

//////////제이쿼리를 이용하여 부서별 사원 리스트를 display로 on/off 할 수 있게끔 함////////////////////////////////
	
	$('#insa').click(function(){
		if($('#view1').css('display')=='block'){
			$('.view').css('display','none');
			$('#view1').css('display','none');
			
		}
		else{
			$('.view').css('display','none');
			$('#view1').css('display','block');
		}
		
	});
	
	$('#chong').click(function(){
		if($('#view2').css('display')=='block'){
			$('.view').css('display','none');
			$('#view2').css('display','none');
			
		}
		else{
			$('.view').css('display','none');
			$('#view2').css('display','block');
		}
		
	});
	
	$('#hwa').click(function(){
		if($('#view3').css('display')=='block'){
			$('.view').css('display','none');
			$('#view3').css('display','none');
			
		}
		else{
			$('.view').css('display','none');
			$('#view3').css('display','block');
		}
		
	});
	
	$('#gi').click(function(){
		if($('#view4').css('display')=='block'){
			$('.view').css('display','none');
			$('#view4').css('display','none');
			
		}
		else{
			$('.view').css('display','none');
			$('#view4').css('display','block');
		}
		
	});
	
	$('#young').click(function(){
		if($('#view5').css('display')=='block'){
			$('.view').css('display','none');
			$('#view5').css('display','none');
			
		}
		else{
			$('.view').css('display','none');
			$('#view5').css('display','block');
		}
		
	});
	
	////////////////////////////////////////////////////////////////////////
});


</script>
	<main>
		<aside>
		<!-- 조직도 리스트 -->
		<div>
			<ul>
				<li >
				조직도
				</li>
			<ul>
				<li class="depart" id ="insa">
				인사부
				</li>
				<li class="depart" id ="chong">
				총무부
				</li>
				<li class="depart" id ="hwa">
				회계부
				</li>
				<li class="depart" id ="gi">
				기획부
				</li>
				<li class="depart" id ="young">
				영업부
				</li>
			</ul>
			</ul>
		</div>	
		</aside>
		
	
		<section>
		<h2>부서 리스트</h2>
			<header >
			<div class = "view" id="view1">
			<table class="table table-border table-hover">
		<thead>
		
			<tr>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : insa){%>	
				<tr>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPono()%></td>
					<td><%=employeesdto.getEmpName()%></td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	

		<div class = "view" id="view2">
			<table class="table table-border table-hover">
		<thead>
		
			<tr>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : chong){%>	
				<tr>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPono()%></td>
					<td><%=employeesdto.getEmpName()%></td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view3">
			<table class="table table-border table-hover">
		<thead>
		
			<tr>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : hwa){%>	
				<tr>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPono()%></td>
					<td><%=employeesdto.getEmpName()%></td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view4">
			<table class="table table-border table-hover">
		<thead>
		
			<tr>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : gi){%>	
				<tr>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPono()%></td>
					<td><%=employeesdto.getEmpName()%></td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view5">
			<table class="table table-border table-hover">
		<thead>
		
			<tr>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : young){%>	
				<tr>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPono()%></td>
					<td><%=employeesdto.getEmpName()%></td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
			</header>
			<article>
			
			</article>
		</section>
		
	</main>
</body>
</html>