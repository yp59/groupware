<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--잘못 입력하면 바로아래에 제약조건 문구 뜨면서 다시 입력하도록 안내 문구 추가해야 한다.
데이터 베이스내에 unique 조건이 걸린 값은 catch문에서 처리해서 화면으로 나타낼 수 있게 처리
(미구현) -->
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form action="signUpInsert" method="post">
사원번호 : <input type="text" name="empNo"pattern="[0-9]{4}" required>숫자4자리<br><br>

비밀번호 : <input type="password" name="empPw" pattern="[a-zA-Z0-9]{8,16}" required>
영어 대,소문자,숫자 8자이상16자 이하<br><br>

직책 : <select name="poNo">
		<option value="">선택하세요</option>
		<option value="1">사장</option>
		<option value="2">부장</option>
		<option value="3">차장</option>
		<option value="4">과장</option>
		<option value="5">대리</option>
		<option value="6">사원</option>
	</select><br><br>

이름 : <input type="text" name="empName" pattern="[가-힣]{2,7}" required><br><br>

입사일 : <input type="date" name="joinDate" required><br><br>

전화번호 : 010-<input type="text" name="empPhonemid" pattern="\d{4}" required>-<input type="text" name="empPhonelast" pattern="\d{4}" required>
		<br><br>

이메일 : <input type="text" name="emailLocal" required>
		@
		<select name="emailDomain">
		<option value="">선택하세요</option>
		<option>gmail.com</option>
		<option>naver.com</option>
		<option>hanmail.net</option>
	</select><br><br>

주소 : <input type="text" name="address" required><br><br>

<input type="submit" value="회원가입">
</form>
</body>
</html>

