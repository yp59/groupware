<%@page import="groupware.beans.employeesDto"%>
<%@page import="groupware.beans.employeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String empNo = (String)session.getAttribute("id");

%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<jsp:include page="/template/section.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
function postNumSearch() {//참고항목을 제외한 다음 주소 api 함수
    new daum.Postcode({
        oncomplete: function(data) {
          
            var addr = ''; // 주소 변수
      
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.querySelector('input[name=postNumber]').value = data.zonecode;
            document.querySelector("input[name=addressNum]").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.querySelector("input[name=addressDetail]").focus();
        }
    }).open();
}
</script>
<div>
<h2 style="border-bottom: 2px solid rgb(52, 152, 219); padding-bottom: 20px;">회원정보 수정</h2>
</div>
<div>
<form action="loginInfoEdit.gw" method="post"><!-- 회원정보 수정 입력란 -->
		<input type = "hidden" name="empNo" value="<%=empNo%>">
비밀번호 : <input type="password" name="empPw" pattern="[a-zA-Z0-9]{8,16}" required onblur="confirmPw();">
		<span class="error"></span><br><br>
</div>
비밀번호 확인 : <input type ="password" class="rePw" pattern="[a-zA-Z0-9]{8,16}" required onblur="reconfirmPw();">
			<span class="error"></span><br><br>

이름 : <input type="text" name="empName" pattern="[가-힣]{2,7}"
		 required onblur="confirmName();">
		<span class="error"></span><br><br>

전화번호 : 010-<input type="text" name="empPhonemid" pattern="\d{4}"
		 required onblur="confirmPhone();">
		 -<input type="text" name="empPhonelast" pattern="\d{4}" required onblur="confirmPhone2();">
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


<input type="text" name="postNumber" placeholder="우편번호"> <!-- 다음 api를 활용한 주소 넣기 -->
<input type="button" onclick="postNumSearch();" value="우편번호 찾기"><br>
<input type="text" name="addressNum" placeholder="주소">
<input type="text" name="addressDetail" placeholder="상세주소">
<!-- <input type="text" name="addressExtra" placeholder="참고항목">  --><br>
<input type="submit" value="회원정보 수정">
</form>
<a href = "<%=request.getContextPath()%>/login/loginInfo.jsp">취소</a>
<jsp:include page="/template/footer.jsp"></jsp:include>