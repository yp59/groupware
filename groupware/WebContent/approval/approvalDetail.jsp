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

boolean isConsesus;

if(mysequence.getConsesus().equals("0")){//내 결재 유형이 합의자인지 결재자인지에 따라 결재 순서를 잰다.
	
	isConsesus = false;
	for(directAppDto x : allSequence){//여기서 계산된 값에 따라 기안서에 누를 수 있는 버튼이 달라짐 for 문 각각 해야되나????
		if(x.getConsesus().equals("1")){continue;}//합의자는 결재순서와 상관없이 모두 합의하면 결재 넘어간다.
		
		if(mysequence.getRowNo()<x.getRowNo()){//내 순서가 현재 검사하는 전체 결재 순서보다 값이 작을때
			if(x.getAppDate()!=null){//뒤의 결재자가 결재를 했으면
				String state ="후결"; 
				//후결해야 한다.
				break;
			}
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
	//버튼을 없앨까 경고창으로 막을까 고민중
	
	console.log(window.name);
});

</script>
</head>
<body>
<div class ="container-700">
<h2 class = " text-center">기안서</h2>
<div class = "text-right">
<form  action=""><!-- 서블릿으로 결재분류,결재일 값 주고 팝업창 닫아야함 -->
<div class = "isConsesus">
<input type = "button" value = "합의">
<input type = "button" value = "거부"><!-- 합의자 버튼 -->
</div>
<div class = "isApproval">
<input id ="already" type = "button" value = "예결">
<input id ="late" type = "button" value = "후결">
<input id ="fit" type = "button" value = "기결">
<input id ="back" type = "button" value = "반려"><!-- 결재자 버튼 -->
</div>
</form>
</div>
<div>
제목 : <%=draftapp.getAppTitle() %>
<br>
</div>
<div>
내용 : <%=draftapp.getAppContent() %>
<br>
</div>
<div>
상신일 : <%=draftapp.getAppDateStart()%>
<br>
</div>
<div>
결재일<!-- 최종결재자의 결재 허가가 났을경우 최종결재자의 결재일을 입력 -->
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