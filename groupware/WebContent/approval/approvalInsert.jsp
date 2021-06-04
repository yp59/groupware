<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/referencePopUp.jsp"></jsp:include>
    
<%String id = (String) session.getAttribute("id");

String app = request.getParameter("approval");//부서리스트에서 얻은 데이터값을 파라미터로 저장한다.
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
	
	function getFormatDate(date){//오늘 날짜 받는 함수
		
    var year = date.getFullYear();
    var month = (1 + date.getMonth());
    month = month >= 10 ? month : '0' + month;
    var day = date.getDate();
    day = day >= 10 ? day : '0' + day;
    return year + '-' + month + '-' + day;
	
	}


	var today = getFormatDate(new Date());   
	
	
$(function(){//window.load와 같은의미
	$('input[name=appDateStart]').val(today);//    date로 받은 값 cal을 appDateStart에 넣는다.
	$('input[name=appDateEnd]').val(today);//    date로 받은 값 cal을 appDateEnd에 넣는다.
	
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
		window.opener.name = "approvalMain";//부모창 이름 설정
		document.appForm.target = "approvalMain";//기안서 보낼때 어느 화면으로 갈껀지 선택
		document.appForm.action = "approvalInsert.gw";//실제 데이터가 보내지는 페이지
		document.appForm.submit();
		self.close();//지금 보고있는 창은 종료된다.
	});
	
	
	
});
</script>
	<!-- 가장 바깥 영역 -->
<main>
		
		<!-- 사이드영역 -->
	<aside></aside>
		
		<!-- 컨텐츠영역 -->
	<section>
		<form name = "appForm" method ="post">
			<div>
				<input type="hidden" name ="drafter" value="<%=id%>"><!-- 기안자 hidden으로 전송 -->
					기안일 : <input type = "date" name = "appDateStart" ><br>
			</div>
			
			<div>
					결재자 :<input type = "text" class="appPeople" name = "approvalNo" value="<%=app%>"><br>
					합의자 :<input type = "text" class="appPeople" name = "consesusNo" value="<%=con%>"><br> 
					참조자 :<input type = "text" class="appPeople" name = "refferNo" value="<%=ref%>"><br>
					시행자 :<input type = "text" class="appPeople" name = "implemneterNo" value="<%=imp%>"><br>  
				<!-- 숫자는 servlet에서 처리-->
			</div>
			
			<div>
					제목 : <input type = "text" name = "appTitle"><br> 
			</div>
			
			<div>
				내용 : <textarea rows="16" class="input" name="appContent"></textarea>
			</div>
			
			<div>
				마감일 :<input type = "date" name = "appDateEnd"> 
			</div>
			
			<!-- 첨부 아직 미구현 -->
					<input type ="submit" value = "기안" name ="subb">
		</form>
	</section>	
</main>
</body>
</html>
