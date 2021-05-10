<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--잘못 입력하면 바로아래에 제약조건 문구 뜨면서 다시 입력하도록 안내 문구 추가해야 한다.
javaScript로 구현-->
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<script>

function confirmId(){//아이디 확인 함수
	
		var regex = /^[0-9a-z]{4,10}$/;
		var inputId = document.querySelector("input[name=empNo]");
		var text = inputId.value;
		var spanId = document.querySelector("input[name=empNo]+ span")
		
			if(regex.test(text)){//정규식으로 확인하고 맞으면 아무것도 안나온다
				spanId.textContent ="";
			}
			else{//정규식으로 확인하고 규격에 맞지않으면 지우고 안내문 나온다.
				spanId.textContent ="아이디는 영소문자,숫자로 4~10자로 입력해주세요."
				inputId.value="";
			}
}
	function confirmPw(){//비밀번호 확인 함수
		
		var regex = /^[a-zA-Z0-9]{8,16}$/;
		var inputPw = document.querySelector("input[name=empPw]");
		var text = inputPw.value;
		var spanPw = document.querySelector("input[name=empPw]+ span");
	
			if(regex.test(text)){//정규식으로 확인하고 맞으면 아무것도 안나온다
				spanPw.textContent = "";
			}
			else{//정규식으로 확인하고 규격에 맞지않으면 지우고 안내문 나온다.
				spanPw.textContent = "비밀번호는 영소대문자,숫자로 8~16자로 입력해주세요";
				inputPw.value ="";
			}
}

function reconfirmPw(){//비밀번호 확인식
	
		var inputPw = document.querySelector("input[name=empPw]");
		var reinputPw = document.querySelector(".rePw");
		var spanPw = document.querySelector(".rePw+ span");
		
		var text = inputPw.value;
		var retext = reinputPw.value;
		
			if(text==retext){//확인 식과 같으면 일치문 나온다.
				spanPw.textContent="비밀번호가 일치합니다.";
				
			}
			else{//확인 식과 다르면 지우고 불일치문 나온다.
				spanPw.textContent="비밀번호가 일치하지 않습니다."
					reinputPw.value ="";
			}
}

function confirmName(){//이름 확인 함수
	
		var regex = /^[가-힣]{2,7}$/;
		var inputName = document.querySelector("input[name=empName]");
		var text = inputName.value;
		var spanName = document.querySelector("input[name=empName]+ span");
		
			if(regex.test(text)){//정규식으로 확인하고 맞으면 아무것도 안나온다
				spanName.textContent="";
			}
			else{//정규식으로 확인하고 규격에 맞지않으면 지우고 안내문 나온다.
				spanName.textContent="한글로 성을 포함하여 2~7자로 작성해 주세요.";
				inputName.value="";
			}
}

function confirmPhone(){//전화번호 확인 함수
	
	var regex = /^\d{4}$/;
	var inputPhone = document.querySelector("input[name=empPhonemid]");
	var text = inputPhone.value;
	var spanPhone = document.querySelector("input[name=empPhonelast]+ span");
	
		if(regex.test(text)){//정규식으로 확인하고 맞으면 아무것도 안나온다
			spanPhone.textContent="";
		}
		else{//정규식으로 확인하고 규격에 맞지않으면 지우고 안내문 나온다.
			spanPhone.textContent="숫자로 4자리씩 입력해주세요";
			inputPhone.value="";
		}
}

function confirmPhone2(){//전화번호 확인 함수
	
	var regex = /^\d{4}$/;
	var inputPhone = document.querySelector("input[name=empPhonelast]");
	var text = inputPhone.value;
	var spanPhone = document.querySelector("input[name=empPhonelast]+ span");
	
		if(regex.test(text)){//정규식으로 확인하고 맞으면 아무것도 안나온다
			spanPhone.textContent="";
		}
		else{//정규식으로 확인하고 규격에 맞지않으면 지우고 안내문 나온다.
			spanPhone.textContent="숫자로 4자리씩 입력해주세요";
			inputPhone.value="";
		}
}


</script>
</head>
<body>
<form action="signUpInsert" method="post">
사원번호 : <input type="text" name="empNo"pattern="[0-9a-z]{4,10}" required onblur="confirmId();">
		<span class="error"></span><br><br>

비밀번호 : <input type="password" name="empPw" pattern="[a-zA-Z0-9]{8,16}" required onblur="confirmPw();">
		<span class="error"></span><br><br>
비밀번호 확인 : <input type ="password" class="rePw" pattern="[a-zA-Z0-9]{8,16}" required onblur="reconfirmPw();">
			<span class="error"></span><br><br>

직급 : <select name="poNo">
		<option value="1">사장</option>
		<option value="2">부장</option>
		<option value="3">차장</option>
		<option value="4">과장</option>
		<option value="5">대리</option>
		<option value="6">사원</option>
	</select><br><br>

이름 : <input type="text" name="empName" pattern="[가-힣]{2,7}" required onblur="confirmName();">
		<span class="error"></span><br><br>

입사일 : <input type="date" name="joinDate" required>
		<span class="error"></span><br><br><!-- date type 스크립트로 정규식 어떻게 줄까 아니면 select로 년월일 바꿔서 구현?-->

전화번호 : 010-<input type="text" name="empPhonemid" pattern="\d{4}" required onblur="confirmPhone();">-<input type="text" name="empPhonelast" pattern="\d{4}" required onblur="confirmPhone2();">
		<span class="error"></span><br><br>

이메일 : <input type="text" name="emailLocal" required>
		@
		<select name="emailDomain">
		<option value="">선택하세요</option>
		<option>gmail.com</option>
		<option>naver.com</option>
		<option>yahoo.co.kr</option>
		<option>empal.com</option>
		<option>nate.com</option>
		<option>dreamwiz.com</option>
		<option>orgio.net</option>
		<option>intizen.com</option>
		<!-- 직접입력 아직 미구현 -->
	</select><span class="error"></span><br><br>

주소 : <input type="text" name="address" required><br><br>

<input type="submit" value="회원가입">
</form>
</body>
</html>
