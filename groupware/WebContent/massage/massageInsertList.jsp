<%@page import="groupware.beans.AddressListDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AddressListDao"%>
<%@page import="groupware.beans.MassageListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
AddressListDao addressListDao = new AddressListDao();
List<AddressListDto> list = addressListDao.list();



%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 검색</title>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
	
		/*테스트용 스타일링*/
		div{
			border:1px dotted black;
		}
		
		/* 리셋 스타일 (body의 여백을 없애는 스타일)*/
		html, body{
			margin:0;
			padding:0;
		}
.main{
	width:600px;
	margin:auto;
}
.main::after{
	content:"";
	display:block;
	clear:both;

}
.header{
	min-height:100px;
}
.section{
	min-height:300px;
}
.footer{
	min-heigth:100px;
}

</style>

<script>
	$(function(){
		//window는 현재 창 객체를 말하고, 부모창은 window.parent.opener 라는 이름으로 제어함
		$(".insert-btn").click(function(e){
			e.preventDefault();
			
			//var sender = 현재위치 위에 앞에 있는 text;
			var sender = $(this).parent().prev().text();
			window.parent.opener.document.querySelector("input[name=e2_name]").value = sender;
			
			window.close();
		});
	});
</script>


</head>
<body>

	<div class="main">	
		<div class="header row">
			<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">사원 검색</h2>
		</div>
		<div class="section">
			<div class="row">
				<table class="table table-border">
					<thead>
						<tr>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>선택</th>
						</tr>
					</thead>
					<tbody>
						<%for(AddressListDto addressListDto:list) {%>
						<tr>
							<td><%=addressListDto.getDepartment() %></td>
							<td><%=addressListDto.getPosi() %></td>
							<td><%=addressListDto.getEmp_name() %></td>
							<td>
								<a href="massageInsert.jsp" class="insert-btn">
									<img src="<%=request.getContextPath() %>/massage/massageIcon.jpg" width="30px" height="30px">
								</a>
							</td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		
		</div>
		<div class="footer">
		
		</div>
	
	</div>

</body>
</html>