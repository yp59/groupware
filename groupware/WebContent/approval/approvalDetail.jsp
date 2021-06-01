<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안서</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

</head>
<body>
<div class ="container-700 text-center">
<h2>기안서</h2>
<div class = "text-right">
<form  action="">
<div>
<input type = "button" value = "합의">
<input type = "button" value = "거부"><!-- 합의자 버튼 -->
</div>
<div>
<input type = "button" value = "예결">
<input type = "button" value = "후결">
<input type = "button" value = "기결">
<input type = "button" value = "반려"><!-- 결재자 버튼 -->
</div>
</form>
</div>
</div>



</body>


</html>