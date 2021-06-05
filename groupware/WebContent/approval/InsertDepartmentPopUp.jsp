<%@page import="java.util.List"%>
<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/departmentPopUp.jsp"></jsp:include>
<%
employeesDao employeesdao = new employeesDao();//jquery와 jsp 는 연동이 안되기 때문에(jsp-->jquery는 가능)
List<employeesDto> insa = employeesdao.list("인사부");//화면을 미리 만들어두고 event에 따라 보여줄지 안보여줄지 선택하는 방식으로 구현
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
	
	$('#insa').click(function(){//id가 insa인 태그를 클릭했을 때
		$('.appSelect').prop('checked',false);//초기화면으로 체크박스를 false로 초기화
		
		if($('#view1').css('display')=='block'){//id가 view1인 태그의 display가 보여질때 view 클래스를 전부 none로 사라지게 함
			$('.view').css('display','none');
			$('#view1').css('display','none');
		
		}
		else{// view1이 안보인다면 보이게 하고 나머지 view 클래스가 중복으로 보이는 걸 방지하기 위해서 none으로 한다.
			$('.view').css('display','none');
			$('#view1').css('display','block');
		}
		
	});
	
	$('#chong').click(function(){
		$('.appSelect').prop('checked',false);//부서 리스트를 닫았을 때 체크를 해제
		
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
		$('.appSelect').prop('checked',false);//부서 리스트를 닫았을 때 체크를 해제
		
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
		$('.appSelect').prop('checked',false);//부서 리스트를 닫았을 때 체크를 해제
		
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
		$('.appSelect').prop('checked',false);//부서 리스트를 닫았을 때 체크를 해제
		
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
	
	
	
///////////////////// 부서별 사원 리스트에서 결재 합의 참조 시행자를 선택해서 부모창으로 값을 보내는 구문/////////////////
		
		$('#approval').click(function(){// 결재자 버튼을 누르면 체크박스 클래스 appSelect에서 체크된 값을 변수 text에 저장한다.
			
			var person = "";//값 초기화 변수
			
			$('.appSelect').each(function(idx){//appselect클래스(체크박스)를 반복문으로
			
			if($(this).is(":checked")){//현재 index의 체크박스가 체크면
			
				person += $(this).val();//person 변수에 체크박스 val() 저장
				person += "&";//후에 서블릿으로 DB에 넣을때 구분짓기 위해서 구분자로 사용  
			}	
			$('input[name=approval]').val(person);//실제로 결재자 정보가 담겨져 넘어가는 input태그
			
			
			});
			console.log($('input[name=approval]').val());//잘 들어갔나 console창 확인용
			$('#approvals').text(person);//선택된 결재자를 화면에 나타내기 위해서 id가 approvals인 태그에 person을 넣어 보여준다.
		});
	
		
		
		
		$('#consesus').click(function(){// 합의자 버튼을 누르면 체크박스 클래스 appSelect에서 체크된 값을 변수 text에 저장한다.
			
			var person = "";
			
			$('.appSelect').each(function(idx){
			
			if($(this).is(":checked")){
			
				person += $(this).val();
				person += "&";
			}	
			$('input[name=consesus]').val(person);
			
			
			});
			console.log($('input[name=consesus]').val());
			$('#consesuses').text(person);
		});
		
		
		
		
		
		$('#reffer').click(function(){// 참조자 버튼을 누르면 체크박스 클래스 appSelect에서 체크된 값을 변수 text에 저장한다.
			
			var person = "";
			
			$('.appSelect').each(function(idx){
			
			if($(this).is(":checked")){
			
				person += $(this).val();
				person += "&";
			}	
			$('input[name=reffer]').val(person);
			
			
			});
			console.log($('input[name=reffer]').val());
			$('#reffers').text(person);
		});
			
		
		
		
		
		$('#implementer').click(function(){// 시행자 버튼을 누르면 체크박스 클래스 appSelect에서 체크된 값을 변수 text에 저장한다.
			
			var person = "";
			
			$('.appSelect').each(function(idx){
			
			if($(this).is(":checked")){
			
				person += $(this).val();
				person += "&";
			}	
			$('input[name=implementer]').val(person);
			
			
			});
			console.log($('input[name=implementer]').val());
			$('#implementers').text(person);
		});
		
		
//////////////////////////////////////////////////////////////////////////////////

		
		
	$('input[name=subb]').click(function(){//submit을 누르면 부모창으로 값을 보내고 팝업창 종료
		window.opener.name = "draftPopUp";//부모 창 이름 설정
		document.appForm.target = "draftPopUp";//어느 창으로 갈건지 target지정
		document.appForm.action = "approvalInsert.jsp";//실제 데이터가 넘어가는 페이지
		document.appForm.submit();
		self.close();//현재 창을 닫는다.
	});
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
		
			<tr><th>√</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : insa){%>	
				<tr>
					<th><input type = "checkbox" class ="appSelect" value = "<%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]"></th>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPoSi()%></td>
					<td><%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]</td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	

		<div class = "view" id="view2">
			<table class="table table-border table-hover">
		<thead>
		
			<tr><th>√</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : chong){%>	
				<tr>
					<th><input type = "checkbox" class ="appSelect" value = "<%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]"></th>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPoSi()%></td>
					<td><%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]</td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view3">
			<table class="table table-border table-hover">
		<thead>
		
			<tr><th>√</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : hwa){%>	
				<tr>
					<th><input type = "checkbox" class ="appSelect" value = "<%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]"></th>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPoSi()%></td>
					<td><%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]</td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view4">
			<table class="table table-border table-hover">
		<thead>
		
			<tr><th>√</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : gi){%>	
				<tr>
					<th><input type = "checkbox" class ="appSelect" value = "<%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]"></th>
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPoSi()%></td>
					<td><%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]</td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>	
		<div class = "view" id="view5">
			<table class="table table-border table-hover">
		<thead>
		
			<tr><th>√</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody><%for(employeesDto employeesdto : young){%>	
				<tr>
					<th><input type = "checkbox" class ="appSelect" value = "<%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]"></th>
					<!-- check박스의 value를  넣어서 값을 넣어준다. empNo뽑아낼때는 subString 사용???-->
					<td><%=employeesdto.getDepartment()%></td>
					<td><%=employeesdto.getPoSi()%></td>
					<td><%=employeesdto.getEmpName()%>[<%=employeesdto.getEmpNo()%>]</td>
				</tr>
		<%}%>
		</tbody>
</table>
</div>

</header>
		<article>
	<div><!-- 결재 파트 사원 클릭하고 버튼 누르면 결재자 지정됨 -->
				<button id = "approval">결재자</button><div id = "approvals"></div><br><br>
				<button id = "consesus">합의자</button><div id = "consesuses"></div><br><br>
				<button id = "reffer">참조자</button><div id = "reffers"></div><br><br>
				<button id = "implementer">시행자</button><div id = "implementers"></div><br><br>
	</div>
	
	<div>
	<form name ="appForm" method = "get"><!-- 부서 리스트에서 결재자를 선택하고 실제로 데이터를 보내는 파트
														post로 보내면 한글 깨진다 -->
	<input type ="hidden" name = "approval">
	<input type ="hidden" name = "consesus">
	<input type ="hidden" name = "reffer">
	<input type ="hidden" name = "implementer">
	<input type = "submit" value ="전송√" name ="subb">
	</form>
	</div>
	
		</article>
	</section>
	</main>
</body>
</html>