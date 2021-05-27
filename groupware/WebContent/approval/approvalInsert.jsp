<%@page import="groupware.beans.approvalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%String id = (String) request.getAttribute("id");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>기안서 작성</title>
<script>
$(function(){
	$(".startDate").on("load",function(){
		
	})
	
});
</script>
</head>
<body>

<div class = "container-700">
<form action="approvalInsert.gw" method ="post">
<div>
	<input type="hidden" name ="drafter" value="<%=id%>">
	
일자 : <input type = "date" class= "startDate" name = "appDateStart"> 
</div>
<div>
제목 : <input type = "text" name = "appTitle"> 
</div>
<div>
<!-- 결재라인은 외래키이기 때문에 서블릿에서 먼저 들어가야함
window 새 창으로 해서 값 넣어야 함 -->
결재라인 : <input type = "text" name = "midApprovalNo">
		<input type = "text" name = "finalApprovalNo"> 
		<input type = "text" name = "consesusNo"> 
		<input type = "text" name = "refferNo">
		<input type = "text" name = "implemneterNo">  
</div>

<div>
 : <input type = "date" name = "appDateStart"> 
</div>
<div>
첨부 : <input type = "date" name = "appDateStart"> 
</div>
<div>
일자 : <input type = "date" name = "appDateStart"> 
</div>
<div>
내용 : <textarea rows="16" class="input" name="appContent">
</textarea>
</div>
</form>
</div>
</body>
</html>