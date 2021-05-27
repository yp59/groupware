<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/referencePopUp.jsp"></jsp:include>
    
<%String id = (String) request.getAttribute("id");

%>    

<body>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

var today = new Date();   

var year = today.getFullYear(); // 년도
var month = today.getMonth() + 1;  // 월
var date = today.getDate();  // 날짜
var cal = year+"-0"+month+"-"+date;//appDateStart에 오늘날짜 넣을 변수

$(function(){//window.load와 같은의미
	$('#appDateStart').val(cal);//작은 따옴표만 된다?    date로 받은 값 cal을 appDateStart에 넣는다.
	
	
	$(".appPeople").click(function(){
		var option ="width=750px , height=550px";//창 크기
		window.open("InsertDepartmentPopUp.jsp","DepartPopUp",option);//이름이 같으면 같은 창에서 열림 주의하자
	});	
});
</script>
	<!-- 가장 바깥 영역 -->
	<main>
		
		<!-- 사이드영역 -->
		<aside>
		
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section>
		<form action="approvalInsert.gw" method ="post">
<div>
	<input type="hidden" name ="drafter" value="<%=id%>"><!-- 기안자 hidden으로 전송 -->
	
기안일 : <input type = "date" id= "appDateStart" name = "appDateStart" >
</div>
<div>
마감일 :<input type = "date" name = "appDateStart"> 
</div>
<div>
제목 : <input type = "text" name = "appTitle"> 
</div>
<div>
<!-- 결재라인은 외래키이기 때문에 서블릿에서 먼저 들어가야함
window 새 창으로 해서 값 넣어야 함 -->
중간 결재자 :<input type = "text" class="appPeople" name = "midApprovalNo">
최종 결재자 :<input type = "text" class="appPeople" name = "finalApprovalNo"> 
합의자 :<input type = "text" class="appPeople" name = "consesusNo"> 
참조자 :<input type = "text" class="appPeople" name = "refferNo">
시행자 :<input type = "text" class="appPeople" name = "implemneterNo">  
</div>
<div>
마감일 :<input type = "date" name = "appDateStart"> 
</div>
<div>
내용 : <textarea rows="16" class="input" name="appContent">
</textarea>
</div>
<!-- 첨부 아직 미구현 -->
</form>
		</section>
		
	</main>
</body>
</html>
