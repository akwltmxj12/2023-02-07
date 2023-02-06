<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


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

      margin-top: 200px;
    

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
        <h4 class="mb-3" align="center"><br>로그인</h4>
        <hr class="mb-4">
        
        <form action="loginOk" method="post" class="validation-form" novalidate>
          <div class="mb-3">
            <input type="text" name="hspId" class="form-control" id="email" placeholder="아이디" required>
            <div class="invalid-feedback">
              아이디를 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <input type="password" name="hspPw" class="form-control" id="address" placeholder="비밀번호" required>
            <div class="invalid-feedback">
              비밀번호를 입력해주세요.
            </div>
          </div>
          
        
          <div class="mb-4"></div>
          	
       	  	<div class="d-grid gap-2">
			  <button class="btn btn-primary btn-lg" type="submit">로그인</button>
			</div>
        </form>
        
        <hr class="mb-4">
        <div align="center">
	        <a href="" class="text-decoration-none">아이디 찾기 |</a>
	        <a href="" class="text-decoration-none">비밀번호 찾기 |</a>
	        <a href="join" class="text-decoration-none">회원가입</a>
        </div>
        <br>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 예방접종등록시스템</p>
    </footer>
  </div>
  
  
	
	
</body>
</html>