<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/referencePopUp.jsp"></jsp:include>
    
<%String id = (String) request.getAttribute("id");

String app = request.getParameter("approval");
String con = request.getParameter("consesus");
String ref = request.getParameter("reffer");
String imp = request.getParameter("implementer");

if(app==null){app="";}//아직 부서 리스트 별 결재자 값을 안받아 왔을 때 해당값을 공백으로 설정한다.
if(con==null){con="";}
if(ref==null){ref="";}
if(imp==null){imp="";}


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
		var _width = '750';
	    var _height = '550';
	 
	    // 팝업을 가운데 위치시키기 위해 아래와 같이 값 구하기
	    var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.height - _height )/2);
	    
	var option ='width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top ;
		//window.open("InsertDepartmentPopUp.jsp","DepartPopUp",option);//이름이 같으면 같은 창에서 열림 주의하자
		window.open("InsertDepartmentPopUp.jsp","departPopUp",option);
	});
	
	$('input[name=subb]').click(function(){//submit을 누르면 부모창으로 값을 보내고 팝업창 종료
		window.opener.name = "approvalMain";//확실하지는 않으나 일단 서블릿에서 한번 구현해 보자.
		document.appForm.target = "approvalMain";
		document.appForm.action = "directIndirectAppInsert.gw";
		document.appForm.submit();
		self.close();
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
		<form name = "appForm" method ="post">
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
window 새 창으로 해서 값 넣어야 함(구현하기 어려워서 해당 팝업에서 넘어가는걸로 변경) -->
결재자 :<input type = "text" class="appPeople" name = "midApprovalNo" value="<%=app%>">
합의자 :<input type = "text" class="appPeople" name = "consesusNo" value="<%=con%>"> 
참조자 :<input type = "text" class="appPeople" name = "refferNo" value="<%=ref%>">
시행자 :<input type = "text" class="appPeople" name = "implemneterNo" value="<%=imp%>">  
<!-- 숫자는 servlet에서 처리-->
</div>
<div>
내용 : <textarea rows="16" class="input" name="appContent">
</textarea>
</div>
<!-- 첨부 아직 미구현 -->
<input type ="submit" value = "기안" name ="subb">
</form>
		</section>
		
	</main>
</body>
</html>
