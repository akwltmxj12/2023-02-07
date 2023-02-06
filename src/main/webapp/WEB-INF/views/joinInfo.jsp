<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기관 가입정보기입(2/2)</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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
        
        <form action="joinOk" method="post" class="validation-form" name="joinInfo_frm" novalidate>
          <input type="hidden" name="hspId" value="${hspId }">
          <input type="hidden" name="hspPw" value="${hspPw }">
          <input type="hidden" name="hspEmail" value="${hspEmail }">
          
         <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">의료기관명</label>
            <input type="text" name="hspName" class="form-control" id="email" placeholder="의료기관명" required>
            <div class="invalid-feedback">
              의료기관명를 입력해주세요.
            </div>
          </div>
          
          <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">기관종류</label>
            <select name="hspKind" id="hspKind" class="custom-select d-block w-100" id="root" required>
               	<option value="select" selected disabled>기관종류선택</option>
                <option>의원</option>
                <option>종합병원</option>
                <option>보건소</option>
              </select>
            <div class="divInvalid text-danger">
              기관종류를 반드시 선택해주세요.
            </div>
          </div>
          
          <div class="mb-3">
            <label for="address" style="font-weight: bold; font-size: 18px;">주소</label>
            <input type="text" name="hspAddress" class="form-control" id="address" placeholder="서울특별시 강남구" required>
            <div class="invalid-feedback">
              주소를 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="address2" style="font-weight: bold; font-size: 18px;">상세주소<span class="text-muted">&nbsp;(필수 아님)</span></label>
            <input type="text" name="hspCrntAdd" class="form-control" id="address2" placeholder="상세주소를 입력해주세요.">
          </div>
          
          <div class="mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">전화번호</label>
            <input type="tel" name="hspTel" class="form-control" id="email" placeholder="'-'빼고 입력하세요." required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>  
          
          
        <div class="row"> 
          <div class="col-md-7 mb-3">
            <label for="email" style="font-weight: bold; font-size: 18px;">예진의사수</label>
            <input type="number" name="hspDrNum" class="form-control" onkeyup="totalInjection()" id="doctorNum" placeholder="예진의사수 X 20명 = 시간당 예약가능수" required>
            <div class="invalid-feedback">
              예진의사수를 입력해주세요.
            </div>
          </div>
          <div class="col-md-5 mb-3">
          	<label for="email" style="font-weight: bold; font-size: 18px;">시간당 접종 가능 수</label>
            <input type="text" name="hspNum" readonly="readonly" value="시간당접종가능수" id="totalNum" class="form-control" required>
        	<div id="totalNum"></div>
         </div>
         </div>
  
  		<div class="row">
  			<div class="col-md-5 mb-3"> 	
              <label for="root" style="font-weight: bold; font-size: 18px;">점심시간</label>
	              <table>
		              <tr>
			              <td>
				              <select name="hspLunchSt" id="hspLunchSt"  class="custom-select d-block w-300" id="root">
				                <option value="lunchSt" selected disabled>시간선택</option>
				                <option>오전11시</option>
				                <option>오후12시</option>
				                <option>오후1시</option>
				              </select>
			              </td>
			              <td> ~ </td>
			              <td>
				              <select name="hspLunchCl" id="hspLunchCl" class="custom-select d-block w-300" id="root">
				                <option value="lunchCl" selected disabled>시간선택</option>
				                <option>오후12시</option>
				                <option>오후1시</option>
				                <option>오후2시</option>
				                <option>오후3시</option>
				              </select>
			              </td>
		              </tr>
	              </table>
	              <div class="lunchInvalid text-danger">
		              점심시간을 반드시 선택해주세요.
		          </div>
             </div> 
             <div style="color: orange; font-size: 15px">※ 근무시간 설정을 변경하여도 기존예약자에 대한 접종시행은 진행해야 합니다.</div>
             <div style="color: orange; font-size: 15px">※ 예약시작시간부터 예약종료시간까지 예약신청이 가능합니다(단, 점심시간 제외).</div>
        </div>
        
        <br>
        
         <div class="mb-3">
            <label style="font-weight: bold; font-size: 18px;">요일별 예약시간</label>
        
        <div class="card border-dark">
  			<div class="card-body">
			        <table class="table">
						  <thead>
						    <tr>
						      <th scope="col" class="text-center">구분</th>
						      <th scope="col" class="text-center">예약시작시간</th>
						      <th scope="col" class="text-center">~</th>
						      <th scope="col" class="text-center">예약종료시간</th>
						    </tr>
						  </thead>
						  
					  	<tbody>
						    <tr>
						      <th scope="row" class="text-center">
						      	월
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStMon" id="hspStMon" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClMon" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	화 <input type="hidden" value="화">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStTue" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClTue" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	수<input type="hidden" value="수">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStWed" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClWed" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	목<input type="hidden" value="목">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStThu" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClThu" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	금<input type="hidden" value="금">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStFri" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClFri" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	토<input type="hidden" value="토">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStSat" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						      <td class="text-center">~</td>
						      <td>
						     	 <div class="d-flex justify-content-center">
							      	<select name="hspClSat" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
					              </div>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="text-center">
						      	일<input type="hidden" value="일">
						      </th>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspStSun" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오전08시</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>휴진</option>
					              	</select>
					              </div>	
						      </td>
						      <td class="text-center">~</td>
						      <td>
						      	<div class="d-flex justify-content-center">
							      	<select name="hspClSun" class="custom-select d-block w-50">
							                <option selected disabled>시간선택</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
					              			<option>오후5시</option>
					              			<option>오후6시</option>
					              			<option>오후7시</option>
					              			<option>휴진</option>
					              	</select>
				              	</div>
						      </td>
						    </tr>
						</tbody>
					</table>
					<div class="invalid-feedback">
              			요일별 예약시간을 모두 입력해주세요.
        			</div>
				</div>
			</div>	
        </div>
     	
     	<br>
     	<div class="mb-3">
            <label for="address" style="font-weight: bold; font-size: 18px;">접종가능 백신 선택</label>
            <div class="card border-dark">
  				<div class="card-body">
			     	<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">백신 종류 선택 (중복선택가능)</th>
						    </tr>
						  </thead>
						 
						  <tbody>
							<tr>
								<td>	           
					            <div class="custom-control custom-checkbox">
						            <label>
							            <input type="checkbox" name="hspVaccineCk" value="인플루엔자(독감)">
							            인플루엔자(독감)
						            </label>
					            </div>
					            </td>
				            </tr>
							<tr>
								<td>	           
					            <div class="custom-control custom-checkbox">
						            <label>
							            <input type="checkbox" name="hspVaccineCk" value="결핵(BCG, 피내용)"  >
							            결핵(BCG, 피내용)
						            </label>
					            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="B형간염(HepB)"  >
								            B형간염(HepB)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="디프테리아/파상풍/백일해(DTaP)"  >
								           	디프테리아/파상풍/백일해(DTaP)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오(DTaP-IPV)"  >
								            디프테리아/파상풍/백일해/폴리오(DTaP-IPV)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)"  >
								            디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="디프테리아/파상풍/백일해(TdaP)"  >
								            디프테리아/파상풍/백일해(TdaP)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="파상풍/디프테리아(Td)"  >
								            파상풍/디프테리아(Td)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
								        <label>
								            <input type="checkbox" name="hspVaccineCk" value="폴리오(IPV)"  >
								            폴리오(IPV)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							           	<label>
								           	<input type="checkbox" name="hspVaccineCk" value="b형헤모필루스인플루엔자"  >
								            b형헤모필루스인플루엔자
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="폐렴구균(PCV 10가)"  >
								            폐렴구균(PCV 10가)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="폐렴구균(PCV 13가)"  >
								            폐렴구균(PCV 13가)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="폐렴구균(PCV 23가)"  >
								            폐렴구균(PCV 23가)
							            </label>
						            </div>
				            	</td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="홍역/유행성이하선염/풍진(MMR)"  >
								            홍역/유행성이하선염/풍진(MMR)
							            </label>
						            </div>
					            </td>
				            </tr>
				            <tr>
								<td>
						            <div class="custom-control custom-checkbox">
							            <label>
								            <input type="checkbox" name="hspVaccineCk" value="A형간염(HepA)"  >
								            A형간염(HepA)
							            </label>
									</div>
								</td>
							</tr>
			           </tbody>
			         </table>
			       </div>
			    </div>   
	         <div class="invalid-feedback">
	              백신을 선택해주세요.
	         </div>
          </div>
          <div style="color: orange; font-size: 15px">※ 접종가능백신종류는 '기관관리>의료기관 정보수정>의료기관 취급백신종류' 에서 변경가능합니다.</div>
          <br>

          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <label class="custom-control-label" for="aggrement">
	        <input type="checkbox" class="custom-control-input" id="aggrement" required>
	        개인정보 수집 및 이용에 동의합니다.
            </label>
          </div>
          <div class="mb-4"></div>
          <div class="d-grid gap-2">
		  	<button class="btn btn-primary" type="submit">가입완료</button>
		  </div>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 예방접종등록시스템</p>
    </footer>
  </div>
	
	
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
	
	
<script type="text/javascript">
function totalInjection() {
	var doctorNum = document.getElementById("doctorNum").value;
	var dctNum = Number(doctorNum);
	var result = 0;
	if(doctorNum != null){	
		result = dctNum * 20;
		document.querySelector("#totalNum").value = result;
	}
}
</script>	

<script type="text/javascript">

$(document).ready(function() {
	  $('#hspKind').change(function() {
	    var result = $('#hspKind option:selected').val();
	    if (result == 'select') {
	      $('.divInvalid').show();
	    } else {
	      $('.divInvalid').hide();
	    }
	  }); 
	}); 

</script>

<script type="text/javascript">

$(document).ready(function() {
	  $('#hspLunchCl').change(function() {
		    var result = $('#hspLunchCl option:selected').val();
		    if (result == 'lunchCl') {
		      $('.lunchInvalid').show();
		    } else {
		      $('.lunchInvalid').hide();
		    }
		  }
	  
	  ); 
	}); 

</script>
	
</body>
</html>