<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기관 가입정보기입(1/2)</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  


<style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #0d6efd 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #0d6efd 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #0d6efd 100%);
      background: linear-gradient(to top right, #92b5db 0%, #0d6efd 100%);
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>

</head>
<body>
	<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <hr class="mb-4">
        
        <form action="joinInfo" method="post" class="validation-form" novalidate>
          <div class="row">
	         <div class="mb-3">
	            <label for="email" style="font-weight: bold; font-size: 18px;">아이디</label>
	            <input type="text" id="hspId" name="hspId" oninput="IdCheck()" class="form-control" placeholder="아이디" required>
	            <div id="idtext"></div>
	            <div class="invalid-feedback">
	              아이디를 입력해주세요.
	            </div>
	          </div>
          </div>
          
          <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">비밀번호</label>
            <input type="password" id="mpw" name="hspPw" onkeyup="joinpw()" class="form-control" placeholder="비밀번호" required>
          	<div id="pwtext"></div>
            <div class="invalid-feedback">
	            비밀번호를 입력해주세요.
            </div>
          </div>
          
          <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">비밀번호 확인</label>
            <input type="password" id="mpwCheck" onkeyup="joinpw()" class="form-control" placeholder="비밀번호 재입력" required>
          	<div id="pwtextcheck"></div>
          	<div class="invalid-feedback">
	            필수 입력사항입니다.
            </div>
          </div>
          

          <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">이메일</label>
            <input type="email" class="form-control" name="hspEmail" id="email" placeholder="you@example.com" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
          
          <div class="mb-4"></div>
          	<div class="d-grid gap-2">
			  <button class="btn btn-primary" type="submit">다음 →</button>
			</div>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 예방접종등록시스템</p>
    </footer>
  </div>
  
  
  
<!-- 제출 시 빈칸 조회 -->  
<script type="text/javascript">
 
 window.addEventListener('load', () => {
	  const forms = document.getElementsByClassName('validation-form');

	  Array.prototype.filter.call(forms, (form) => {
	    form.addEventListener('submit', function (event) {
	      if (form.checkValidity() === false) {
	        event.preventDefault();
	        event.stopPropagation();
	      }
	      form.classList.add('was-validated');
	    }, false);
	  });
	}, false);
 
</script> 

<!-- 아이디 중복 조회 -->
<script type="text/javascript">

function IdCheck(){
	var x = document.getElementById("hspId").value;
	
	if(x.length == 0){
		document.getElementById("idtext").innerHTML = "아이디는 6자 이상이어야합니다.";
		document.getElementById("idtext").style.color="red";
	}else if(x.length >= 6 && x.length < 20){
			$.ajax({
				url : "checkId",
				type: "post",
				data : {hspId : x},
				success : function(cnt){
					if(cnt==0){
						document.getElementById("idtext").innerHTML = "사용가능합니다.";
						document.getElementById("idtext").style.color="blue";
					} 
					else {
						document.getElementById("idtext").innerHTML = "이미 사용중인 아이디입니다.";
						document.getElementById("idtext").style.color="red";
					}},
				error :function(){
					alert("error");
				}});
	}else{
		document.getElementById("idtext").innerHTML = "아이디는 6자 이상이어야합니다.";
		document.getElementById("idtext").style.color="red";
	}
}

</script>

<!-- 비밀번호 일치여부 --> 
<script type="text/javascript">

var pw = document.getElementById("mpw");
var pwCheck = document.getElementById("mpwCheck");

function joinpw() {
	
	if(pw.value.length == 0 && pwCheck.value.length != 0){	
		document.getElementById("pwtextcheck").innerHTML="비밀번호 확인칸입니다. 비밀번호 먼저 입력하세요";
    	document.getElementById("pwtextcheck").style.color="red";
    	return false;
	}else if(pw.value.length < 6 || pw.value.length > 50){
   		document.getElementById("pwtext").innerHTML="비밀번호는 6자 이상이어야 합니다.";
       	document.getElementById("pwtext").style.color="red";
       	return false;
	}else{	
		document.getElementById("pwtext").innerHTML="";
		
		if(pwCheck.value.length == 0){
			document.getElementById("pwtextcheck").innerHTML="필수 입력정보입니다.";
	    	document.getElementById("pwtextcheck").style.color="red";
	    	return false;
		}else if(pwCheck.value.length != 0 && pw.value != pwCheck.value){	
	    	document.getElementById("pwtextcheck").innerHTML="비밀번호가 불일치합니다.";
	    	document.getElementById("pwtextcheck").style.color="red";
	    	return false;
		}else{
			document.getElementById("pwtextcheck").innerHTML="비밀번호가 일치합니다.";
	    	document.getElementById("pwtextcheck").style.color="blue";
	    	return false;
		}
	}
}

</script>	
	




	
</body>
</html>