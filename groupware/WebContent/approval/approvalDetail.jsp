<%@page import="groupware.beans.indirectAppDto"%>
<%@page import="groupware.beans.indirectAppDao"%>
<%@page import="groupware.beans.directAppDto"%>
<%@page import="groupware.beans.directAppDao"%>
<%@page import="groupware.beans.approvalDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="groupware.beans.approvalDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String id = (String) session.getAttribute("id"); 

int appNo = Integer.parseInt(request.getParameter("appNo"));//결재 리스트에서 어떤 페이지를 눌렀는지 appNo를 가져온다.


///////////////////////////////////////////////////////////기안서 내용을 출력할 저장 객체 선언
approvalDao approvaldao = new approvalDao();
approvalDto draftapp = approvaldao.draftDoc(appNo);//approval table에서 기안서에 출력시킬 데이터 저장

indirectAppDao indirectappdao = new indirectAppDao();
List<indirectAppDto> draftindir = indirectappdao.draftDoc(appNo);//indirectapp table에서 기안서에 출력시킬 데이터 저장

directAppDao directappdao = new directAppDao();
List<directAppDto> draftdir = directappdao.draftDoc(appNo);//directapp table에서 기안서에 출력시킬 데이터 저장

///////////////////////////////////////////////////////////////////////////////////////////


directAppDto mysequence = directappdao.sequence(appNo, id);//내 결재 순서

List<directAppDto> allSequence =directappdao.sequence(appNo);//전체 결재 순서
//list 사이즈로 전체 결재 크기를 알아낸 후 위치를 알아보자

int appSize = allSequence.size();//전체 결재 수
int conSize =0;
String appEndDate ="";
boolean isConsesus;
 String state = "기결";

if(mysequence.getConsesus().equals("0")){//내 결재 유형이 합의자인지 결재자인지에 따라 결재 순서를 잰다.
	
	isConsesus = false;
	
////////////////////////////////예결은 제일 먼저//////////////////////////////////////////
	
	for(directAppDto x : allSequence){
		
		if(x.getConsesus().equals("1")){//합의자는 결재순서와 상관없이 모두 합의하면 결재 넘어간다.
			conSize+=1;//합의자 수당 conSize 증가
			continue;
			}
		
			appSize-=conSize;//결재순서에서 합의자는 뺀다.
			if(mysequence.getRowNo()==appSize){break;}//만약 전체 결재자 수에서 합의자를 뺀 수가
			//현재 내 결재 순서와 같다면 첫 결재자이므로 예결없이 무조건 기결 후결이다.
			
			if(mysequence.getRowNo()-1==x.getRowNo()
			&&x.getAppDate()==null){//내 순서 앞의 결재자가 결재를 하지 않았으면
			state = "예결";
			//예결버튼만 생긴다.
			break;
		}
	}
/////////////////////////////////기결은 내순서가 돼었을 때 앞의 결재자가 결재를 다 했으면///////////////////// 

for(directAppDto x : allSequence){
	if(x.getConsesus().equals("1")){//합의자는 결재순서와 상관없이 모두 합의하면 결재 넘어간다.
		conSize+=1;//합의자 수당 conSize 증가
		continue;
		}
	
		appSize-=conSize;//결재순서에서 합의자는 뺀다.
		if(mysequence.getRowNo()==appSize){break;}//만약 전체 결재자 수에서 합의자를 뺀 수가
		//현재 내 결재 순서와 같다면 첫 결재자이므로 예결없이 무조건 기결 후결이다.

		if(x.getAppDate()!=null){//결재를했고
			if(mysequence.getRowNo()-1==x.getRowNo()){//내 순서 앞의 결재자였을때
				if(x.getType().equals("예결")){//해당 결재타입이 예결이었으면 더 이전 결재자가 결재를 하지 않았던 것이므로 예결
					state = "예결";
					break;
				}
				state = "기결";//위의 구문을 만족하지 않았을 경우에는 내차례가 맞으므로 기결이다.
				break;
			}
		}	
}
////////////////////////후결 라인은 젤 마지막에 넣어서 앞의 조건 무시하고 후결이 우선순위가 되어야 한다/////////////////
		
	for(directAppDto x : allSequence){
		
		if(x.getConsesus().equals("1")){//합의자는 결재순서와 상관없이 모두 합의하면 결재 넘어간다.
			conSize+=1;//합의자 수당 conSize 증가
			continue;
			}
		appSize-=conSize;//결재순서에서 합의자는 뺀다.
		if(mysequence.getRowNo()==appSize){break;}
			
			if(mysequence.getRowNo()<x.getRowNo()){//내 순서가 현재 검사하는 전체 결재 순서보다 값이 작을때
				if(x.getAppDate()!=null){//뒤의 결재자가 결재를 했으면
					 state ="후결"; 
					//후결해야 한다.
					break;
				}
			}
		}
/////////////////////////////////////////////////////////////////////////////////////////////////

for(directAppDto x : allSequence){	//결재자가 모두 결재했을경우 결재일 표시
	 int appCount =0;
			if(x.getAppDate()!=null){//결재한 사람 수를 센다
				appCount++;
			}
	
	if(appCount==appSize){//전체 결재자 수와 결재한 사람 수가 같으면 appEndDate에 최종 결재자 결재일을 저장
		appEndDate = x.getAppDate();
	}
}
	
}

else{
	
	isConsesus = true;//getConsesus의 값이 "1"(합의자)이므로 해당 기안서를 열어보는 '나'는 합의자이다.
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안서</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script >
window.name ='appDetail';

$(function(){
	
	if(<%=isConsesus%>){
		$('.isConsesus').css('display','block');
		$('.isApproval').css('display','none');
	}
	else{
		$('.isConsesus').css('display','none');
		$('.isApproval').css('display','block');
	}
	
////////////////////	//버튼을 없앨까 경고창으로 막을까 고민중 --> 버튼을 없애자/////////////////////////////////////	
	if(<%=state.equals("기결")%>){
		$('#already').css('display','none');
		$('#late').css('display','none');//기결일 때는 내 순서이므로 앞선 결재자는 다 결재한 상태이고 후결은 없는 상황
										//기결과 반려만 가능하다.
	}	
	if(<%=state.equals("예결")%>){
		$('#fit').css('display','none');
		$('#late').css('display','none');//예결일 경우는 나보다 앞선 결재자가 결재하지 않았고 내 순서가 아직 오지 않았을 경우
}
	
	if(<%=state.equals("후결")%>){
		$('#fit').css('display','none');
		$('#already').css('display','none');//후결일 경우 나보다 늦은 결재자가 결재를 1명이라도 한 경우 후결로 처리된다.
}
	$('#hapyee').click(function(){
		$('input[name=type]').val('합의');
		
	});
	
	$('#gobu').click(function(){
		$('input[name=type]').val('거부');
		
	});
	console.log($('input[name=type]').val());
});

</script>
</head>
<body>
<div class ="container-700">
<h2 class = " text-center">기안서</h2>
<div class = "text-right">
<form  action="directAppInsert.gw" method = "get"><!-- 서블릿으로 결재분류,결재일 값 주고 팝업창 닫아야함 -->
<div class = "isConsesus">
<input id="hapyee" type = "submit" value = "합의" name = ""><!-- submit에 name을 넣으면 form에서 넘어갈까?? -->
<input id="gobu" type = "submit" value = "거부"><!-- 합의자 버튼 -->
<input type = "hidden" name = "type">
</div>
<div class = "isApproval">
<input class = "appSelec"  id ="already" type = "submit" value = "예결">
<input class = "appSelec" id ="late" type = "submit" value = "후결">
<input class = "appSelec" id ="fit" type = "submit" value = "기결">
<input class = "appSelec" id ="back" type = "submit" value = "반려">
<input type = "hidden" name = "type" value ="<%=state%>"><!-- 결재자 버튼 -->
</div>
</form>
</div>
<div>
제목 : <%=draftapp.getAppTitle() %>
<br>
</div>
<div>
내용 : <%=draftapp.getAppContent()%> 
<br>
</div>
<div>
상신일 : <%=draftapp.getAppDateStart()%>
<br>
</div>
<div>
결재일 : <%=appEndDate%>
<br>
</div>
<div>
마감일 : <%=draftapp.getAppDateEnd() %>
<br>
</div>
<div>
기안자 : <%=draftapp.getEmpName() %>
<br>
</div>
<%for(directAppDto directappdto : draftdir) {%>

	<%if(directappdto.getConsesus().equals("0")){ %>
		<div>
		결재자 :<%=directappdto.getEmpName() %> 
		<br>
		</div>
<%} %>
<%} %>
<%for(directAppDto directappdto : draftdir) {%>	
	
	<%if(directappdto.getConsesus().equals("1")){ %>
		<div>
		합의자 :<%=directappdto.getEmpName() %> 
		<br>
		</div>
<%} %>
<%} %>

<%for(indirectAppDto indirectappdto : draftindir) {%>	
	
	<%if(indirectappdto.getType().equals("참조")){ %>
		<div>
		참조자 :<%=indirectappdto.getEmpName() %> 
		<br>
		</div>
<%} %>
<%} %>
<%for(indirectAppDto indirectappdto : draftindir) {%>	
	
	<%if(indirectappdto.getType().equals("시행")){ %>
		<div>
		시행자 :<%=indirectappdto.getEmpName() %> 
		<br>
		</div>
<%} %>
<%} %>
</div>
</body>


</html>