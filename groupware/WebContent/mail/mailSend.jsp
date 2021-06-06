<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 보내기 화면</title>
<script type="text/javascript">
    function formCheck(){
		var emailRegex = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		var emailInput = document.querySelector("input[name=mailRecipient]");
		if(!emailRegex.test(emailInput.value)){
			var emailSpan = emailInput.nextElementSibling;
			emailSpan.textContent = "올바른 이메일 형식이 아닙니다.";
			emailInput.select();
			return false;
		}
		else{
			window.alert("메일이 정상적으로 전송 되었습니다!", "width=370, height=360, resizable=no, scrollbars=no, status=no");
		}
		
		return true;
}
    
</script>
<style>
	.row-mail{
	width:100%;
	margin-top: 10px;
	margin-bottom: 10px;
	text-align: left;
	
	}
</style>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>
<div class="container-1198">
	<div class="text-center" style="border: none;">
		<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">공지 메일 발송</h2>
	</div>
	<form action="mailSend.gw" method ="post" onsubmit="return formCheck()" enctype="multipart/form-data">
		<div class="row-mail">
		<label>받는사람</label>
		<input type ="text" name="mailRecipient" required placeholder="이메일 주소 입력" oninput="emailCheck()" style="margin-top: 10px; width: 500px;">
		<span style="cursor.hand;color:red;"></span>
		</div>
		
		<div class="row-mail" style="border:none;">
		<label>제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		<input type ="text" name="mailTitle" required style="width: 500px;">
		</div>
	
	<div class="row-mail">
	<label>내용</label>
	<textarea rows="27" class="input" name="mailContent" required style="resize: none;"></textarea>
		</div>
		
		<div class="row-mail-file" style="border: none;">
		<input type ="file" name="mailFile" id="file">
		</div>
				
	<div class = "row text-right" style="border: none;">
	<input type="submit" value="보내기" class="link-btn" style="width: 100%;">
	</div>	
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
</body>
</html>