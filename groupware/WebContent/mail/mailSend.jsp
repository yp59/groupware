<%@page import="groupware.beans.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 보내기 화면</title>
<script type="text/javascript">
function sendMail(){
    window.open("./testMail.jsp", "", "width=370, height=360, resizable=no, scrollbars=no, status=no");
}
</script>
<style>

</style>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>
<!-- <div class="container-900"> -->
<!-- 	<form action="mailSend.gw" method ="post"> -->
<%-- 		<input type="hidden" name=empNo value=<%=id%>> --%>
<!-- 		<div class="row"> -->
<!-- 		<label>받는사람</label> -->
<!-- 		<input type ="text" name="boTitle"> -->
<!-- 		</div> -->
<!-- 		<div class="row"> -->
<!-- 		<label>제목</label> -->
<!-- 		<input type ="text" name="boTitle"> -->
<!-- 		</div> -->
	
<!-- 	<div class="row"> -->
<!-- 	<label>내용</label> -->
<!-- 	<textarea rows="16" class="input" name="boContent"></textarea> -->
<!-- 		</div>		 -->
<!-- 	<div class = "row text-right"> -->
<!-- 	<input type="submit" value="보내기x"> -->
<!-- 	</div>	 -->
<!-- 	</form> -->
<!-- </div> -->

<div class="row">
<button type="button" onclick="sendMail()">보내기</button>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
</body>
</html>