<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>백신 잔여량</title>
</head>
<body style="background-color: #212529;">

<table align="center" style="background-color: #ffffff;">
	<tr class="table bg-dark" style="height: 20px;">
		<td colspan="3"></td>
	</tr>
	<tr>
		<td></td>
		<td style="width: 1500px; height: 790px">

<!-- 헤더 시작 -->
<%@ include file="include/header.jsp" %>
<!-- 헤더 끝 -->

<!-- 클릭시 이동 기능 시작 -->
<ul class="nav nav-tabs">
	<li class="nav-item">
		<a class="nav-link" href="modify">의료기관 정보수정</a>
	</li>
	<li class="nav-item">
		<a class="nav-link active" style="border-color: #e2e3e5; background-color: #e2e3e5;" aria-current="page" href="vaccine">백신 잔여량</a>
	</li>
</ul>
<!-- 클릭시 이동 기능 끝 -->

<!-- 예약조회 검색기능 시작 -->
<table style="background-color: #e2e3e5; width: 1500px; height: 790px">
		<!-- 제목 시작 -->
		<tr style="height: 20px;">
			<td colspan="5" class="align-top"><br> &nbsp; 
				<span style="font-weight: bold;">◎</span> 
				기관관리 > 
				<span style="font-weight: bold;">백신 잔여량</span>
			</td>
		</tr>
		<!-- 제목 끝 -->
		
		<tr>
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 48%" class="align-top" rowspan="3">
				<div class="card">
					<div class="card-body border border-primary">
						<!-- 백신 종류 검색 조회 시작 -->
						<table style="width: 100%;">
							<form action="vaccineSearch">
								<tr>
									<td>
									 	<div>ο 백신종류:&nbsp; </div>
									</td>
									<td>
										<select name="vaccineName" style="width: 400px;">
											<option>취급백신품목</option>
											<c:forEach items="${hspVaccins }" var="VaccineList">	
												<option>${VaccineList }</option>
											</c:forEach>
										</select>
									</td>
									<td align="right">
										<div style="float: right;" class="btn-group" role="group" aria-label="Basic example">
											<button type="submit" class="btn btn-primary btn-sm">조회</button>
										</div>
									</td>
								</tr>
							</form>	
						</table>
					 </div>
				</div>	 
			    <!-- 백신 종류 검색 조회 끝 -->
						 
				<!-- 검색결과 시작-->
				<div class="card border-dark" style="height: 41.1rem;">
					<div class="card-body">
						▶ 백신잔여량
						<div class="table-responsive" style="max-width: 680px; height: 600px; overflow: auto;">
							<table id="table-vaccine-check" class="table table-striped table-bordered align-top table-hover" style="width: 100%; white-space: nowrap;">
								<thead class="table-primary">
									<tr>
										<th class="table-primary text-center fw-bold sticky-top">
											백신종류
										</th>
										<th class="table-primary text-center fw-bold sticky-top">제조사</th>
										<th class="table-primary text-center fw-bold sticky-top">
											입고날짜
											<a href="vaccineKindRange?storedDate=1&vaccineName=${vaccineName }"> 
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-square-fill" viewBox="0 0 16 16">
												  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm6.5 4.5v5.793l2.146-2.147a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 1 1 .708-.708L7.5 10.293V4.5a.5.5 0 0 1 1 0z"/>
												</svg>
											</a>
										</th>
										<th class="table-primary text-center fw-bold sticky-top">
											폐기날짜
											<a href="vaccineKindRange?releasedDate=1&vaccineName=${vaccineName }"> 
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-square-fill" viewBox="0 0 16 16">
												  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm6.5 4.5v5.793l2.146-2.147a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 1 1 .708-.708L7.5 10.293V4.5a.5.5 0 0 1 1 0z"/>
												</svg>
											</a>
										</th>
										<th class="table-primary text-center fw-bold sticky-top">현재보유량(vial)</th>
										<th class="table-primary text-center fw-bold sticky-top">실제백신사용량(vial)</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${VaccineStock }" var="StockList">
										<tr onclick="javascript:getReserveInfo(this);">
											<td class="text-center">${StockList.vaccineName}</td>
											<td class="text-center">${StockList.vaccineCompany}</td>
											<td class="text-center">${StockList.vaccineRcvDay}</td>
											<td class="text-center">${StockList.vaccineDscDay}</td>
											<td class="text-center">${StockList.vaccineHold}</td>
											<td class="text-center">${StockList.vaccineUse}</td>
										</tr>
									</c:forEach>
								</tbody>	
							</table>
						</div>
					</div>
				</div>	 
			</td>
			<!-- 백신 검색결과 출력 끝-->
			
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 48%" class="align-top">
				<!-- 백신 수정 시작 -->
			   
				<div class="card border-dark" style="height: 22.3rem;">
					<div class="card-body">
						▶ 백신 정보 수정하기
						<!-- 모달 설정 시작 -->
						<div style="float: right;" class="btn-group" role="group" aria-label="Basic example">
							<form action="vaccineStockModify">
							<!-- 수정버튼 모달 시작 -->
							<button  type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineModify">
							  수정
							</button>
								<!-- Modal -->
								<div class="modal fade" id="vaccineModify" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h1 class="modal-title fs-5" id="staticBackdropLabel">수정하기</h1>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									      </div>
									      <div class="modal-body">
									        <table class="table table-bordered border-secondary">
									        	<!-- 변경된 후 값 -->
									        	<input type="hidden" name="vNRs" value="">
												<input type="hidden" name="vCRs" value="">
												<input type="hidden" name="vRDRs" value="">
												<input type="hidden" name="vDDRs" value="">
												<input type="hidden" name="vHRs" value="">
												<input type="hidden" name="vURs" value="">
												<!-- 변경 전 값 -->
												<input type="hidden" name="vaccineNameRs" value="">
												<input type="hidden" name="vaccineCompanyRs" value="">
												<input type="hidden" name="vaccineRcvDayRs" value="">
												<input type="hidden" name="vaccineDscDayRs" value="">
												<input type="hidden" name="vaccineHoldRs" value="">
												<input type="hidden" name="vaccineUseRs" value="">
									        	
									        	<tr>
													<th width="200">백신종류</th>
													<td>
														<div id='RsVaccineName'></div>
													</td>
												</tr>
												<tr>
													<th>제조사</th>
													<td>
														<div id='RsVaccineCompany'></div>
													</td>
												</tr>
												<tr>	
													<th>입고날짜</th>
													<td>
														<div id='RsVaccineRcvDay'></div>
													</td>
												</tr>
												<tr>	
													<th>폐기날짜</th>
													<td>
														<div id='RsVaccineDscDay'></div>
													</td>
												</tr>
												<tr>	
													<th>현재보유량</th>
													<td>
														<div id='RsVaccineHold'></div>
													</td>
												</tr>
												<tr>	
													<th>실제백신사용량</th>
													<td>
														<div id='RsVaccineUse'></div>
													</td>
												</tr>
									        </table>
									        수정 전 다시한번 확인해주세요. 정말로 수정하시겠습니까?
									      </div>
									      <div class="modal-footer">
									        <button type="submit" class="btn btn-primary">수정하기</button>
									        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
									      </div>
								    </div>
								  </div>
								</div>
							</form>
							<!-- 수정모달 끝 -->
							<!-- 삭제모달 시작 -->
							<form action="vaccineStockDel">
								<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDel">
								  삭제
								</button>
								<!-- 삭제모달 -->
								<div class="modal fade" id="vaccineDel" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h1 class="modal-title fs-5" id="staticBackdropLabel">백신 삭제</h1>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        <table class="table table-bordered border-secondary">
								        	<tr>
												<th width="200" class="text-right">백신종류</th>
												<td align="center"><span id="vaccineNameRs"></span>
												<input type="hidden" name="vaccineNameRs" value="">
												</td>
											</tr>
											<tr>
												<th align="right" class="text-right">제조사</th>
												<td align="center"><div id="vaccineCompanyResult"></div>
													<input type="hidden" name="vaccineCompanyRs" value="">
												</td>
											</tr>
											<tr>	
												<th align="right" class="text-right">입고날짜</th>
												<td align="center"><div id="vaccineRcvDayResult"></div>
													<input type="hidden" name="vaccineRcvDayRs" value="">
												</td>
											</tr>
											<tr>	
												<th align="right" class="text-right">폐기날짜</th>
												<td align="center"><div id="vaccineDscDayResult"></div>
													<input type="hidden" name="vaccineDscDayRs" value="">
												</td>
											</tr>
											<tr>	
												<th align="right" class="text-right">현재보유량</th>
												<td align="center"><div id="vaccineHoldResult"></div>
													<input type="hidden" name="vaccineHoldRs" value="">
												</td>
											</tr>
											<tr>	
												<th align="right" class="text-right">실제백신사용량</th>
												<td align="center"><div id="vaccineUseResult"></div>
													<input type="hidden" name="vaccineUseRs" value="" required>
												</td>
											</tr>
								        </table>
								      </div>
								      <div class="modal-footer">
								        <button type="submit" class="btn btn-primary">삭제하기</button>
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								      </div>
								    </div>
								  </div>
								</div>
							</form>
						</div>
						<!-- 삭제 모달 끝-->
						
						
						<table style="width: 100%; height: 250px;" class="table table-bordered">
								<tr>
									<td class="table-primary text-center fw-bold" width="200">백신종류	</td>
									<td>
										<div id="vaccineNameResult"></div>
										<input type="hidden" name="vaccineNameRs" value="">
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">제조사</td>
									<td>
										<input type="text" name="vaccineCompanyRs" id="vC" value="" onkeyup='printName()'>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">입고날짜</td>
									<td><input type="date" name="vaccineRcvDayRs" id="vRD" value="" onkeyup='printName()' required="required"></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">폐기날짜</td>
									<td><input type="date" name="vaccineDscDayRs" id="vDD" value="" onkeyup='printName()' required="required"></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">입고량</td>
									<td>
										<input type="text" name="vaccineHoldRs" id="vH" value="" onkeyup='printName()'> vial
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">실제백신사용량</td>
									<td>
										<input type="text" name="vaccineUseRs" id="vU" value="" onkeyup='printName()'> vial
									</td>
								</tr>
						     
					 	</table>
					</div>
			  	</div>
			  </form>
				<!-- 백신 수정 폼 끝 -->
			</td>
			<td style="width: 1%"></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<!-- 백신 입고량 입력-->
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 48%" class="align-top">
				<!-- 백신 입고 내용 등록 시작 -->
				<div class="card border-dark" style="height: 22.3rem;">
					<div class="card-body">
						<table style="width: 100%; height: 250px;" class="table table-bordered">
						     <form action="vaccineAdd">
								▶ 백신 입고량 입력
								<button style="float: right;" type="submit" class="btn btn-primary btn-sm">등록</button>
								<tr>
									<td class="table-primary text-center fw-bold sticky-top" width="200">백신종류	</td>
									<td>
										<!-- 백신 목록 루프 돌려야 함 -->
										<select name="vaccineName" required="required">
											<option>백신종류 선택</option>
											<c:forEach items="${hspVaccins }" var="VaccineList">	
												<option>${VaccineList }</option>
											</c:forEach>
										</select>
										<!-- 백신 목록 루프 돌려야 함 -->
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">제조사</td>
									<td>
										<input type="text" name="vaccineCompany" required="required">
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">입고날짜</td>
									<td><input type="date" name="vaccineRcvDay" required="required"></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">폐기날짜</td>
									<td><input type="date" name="vaccineDscDay" required="required"></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">입고량</td>
									<td>
										<input type="text" name="vaccineHold" required="required"> vial
									</td>
								</tr>
						     </form>
					 	</table>
					</div>
			  	</div>
				<!-- 백신 입고 등록 폼 끝 -->
			</td>
			<td style="width: 1%"></td>
		</tr>
		<tr>
			<td colspan="5"></td>
		</tr>
		
		
		
</table>
<!-- 예약조회 검색기능 끝 -->


<!-- 푸터 시작 -->
<%@ include file="include/footer.jsp" %>
<!-- 푸터 끝 -->

		</td>
	</tr>
	<tr>
		<td colspan="3"></td>
	</tr>
</table>

<script type="text/javascript">

//테이블 클릭 시 이벤트 발생

$("#table-vaccine-check tr").click(function(){  // 테이블 id값 불러오기
	
	var vaccineNameStr = ""; // 백신이름 넣을 빈 객체
	var vaccineCompanyStr = "";
	var vaccineRcvDayStr = "";
	var vaccineDscDayStr = "";
	var vaccineHoldStr = "";
	var vaccineUseStr = "";
	
	var tdArr = new Array() // 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	
	// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
	td.each(function(i){
		tdArr.push(td.eq(i).text());
	});
	
	console.log("배열에 담긴 값 : "+tdArr);
	
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	var vaccineName = td.eq(0).text(); // 백신이름
	var vaccineCompany = td.eq(1).text();  // 백신제조사
	var vaccineRcvDay = td.eq(2).text(); // 백신 입고일
	var vaccineDscDay = td.eq(3).text(); //백신폐기일
	var vaccineHold = td.eq(4).text(); // 백신현재보유량
	var vaccineUse = td.eq(5).text();  // 당일 백신사용예정량
	

	vaccineNameStr = "<font>"+ vaccineName +"</font>";
	vaccineCompanyStr = "<font>"+ vaccineCompany +"</font>";
	vaccineRcvDayStr = "<font>"+ vaccineRcvDay +"</font>";
	vaccineDscDayStr = "<font>"+ vaccineDscDay +"</font>";
	vaccineHoldStr = "<font>"+ vaccineHold +"</font>";
	vaccineUseStr = "<font>"+ vaccineUse +"</font>";

	$('#vaccineNameResult').html(vaccineNameStr); //백신이름
	$('#vaccineNameRs').html(vaccineNameStr); //삭제 시 함께 전송해줄 백신이름
	$('#RsVaccineName').html(vaccineNameStr); //수정 시 전송해줄 백신이름
	$('#vaccineCompanyResult').html(vaccineCompanyStr); // 백신제조사
	$('#vaccineRcvDayResult').html(vaccineRcvDayStr);  //백신 입고일
	$('#vaccineDscDayResult').html(vaccineDscDayStr); // 백신폐기일
	$('#vaccineHoldResult').html(vaccineHoldStr); // 백신현재보유량
	$('#vaccineUseResult').html(vaccineUseStr); // 당일 백신사용예정량

	$('input[name=vNRs]').attr('value',vaccineName);  //수정하기 위해 클릭된 값의 백신명
	
	$('input[name=vaccineNameRs]').attr('value',vaccineName);  //백신명
	$('input[name=vaccineCompanyRs]').attr('value',vaccineCompany);  //백신제조사
	$('input[name=vaccineRcvDayRs]').attr('value',vaccineRcvDay); //백신 입고일
	$('input[name=vaccineDscDayRs]').attr('value',vaccineDscDay);  //백신폐기일
	$('input[name=vaccineHoldRs]').attr('value',vaccineHold); //백신현재보유량
	$('input[name=vaccineUseRs]').attr('value',vaccineUse); //당일 백신사용예정량
	
	
	
	
	$('input[name=mNameClick]').attr('value',mName);  //클릭된 값의 파라미터값 날려주기(접종자이름)
	$('input[name=mJuminClick]').attr('value',mJumin); //클릭된 값의 파라미터값 날려주기(접종자 주민번호)
	
	
});


</script>

<script type="text/javascript">

function printName()  {
	  const vC = document.getElementById('vC').value;
	  document.getElementById("RsVaccineCompany").innerText = vC;
	  $('input[name=vCRs]').attr('value',vC);  

	  const vRD = document.getElementById('vRD').value;
	  document.getElementById("RsVaccineRcvDay").innerText = vRD;
	  $('input[name=vRDRs]').attr('value',vRD);  
	  
	  const vDD = document.getElementById('vDD').value;
	  document.getElementById("RsVaccineDscDay").innerText = vDD;
	  $('input[name=vDDRs]').attr('value',vDD);  

	  const vH = document.getElementById('vH').value;
	  document.getElementById("RsVaccineHold").innerText = vH;
	  $('input[name=vHRs]').attr('value',vH);  
	  
	  const vU = document.getElementById('vU').value;
	  document.getElementById("RsVaccineUse").innerText = vU;
	  $('input[name=vURs]').attr('value',vU);  
}


</script>



<!-- 클릭 시 색변경 이벤트 -->
<script type="text/javascript">
function getReserveInfo(target) {
    var tbody = target.parentNode;
    var trs = tbody.getElementsByTagName('tr');
 
    var backColor = "#ffffff";
    var textColor = "black";
    var orgBColor = "#FF2E2E";
    var orgTColor = "#ffffff";
 
    var no = "";
    var no1 = "";
 
    for ( var i = 0; i < trs.length; i++ ) {
        if ( trs[i] != target ) {
            trs[i].style.backgroundColor = backColor;
            trs[i].style.color = textColor;
        } else {
            trs[i].style.backgroundColor = orgBColor;
            trs[i].style.color = orgTColor;
            var td = trs[i].getElementsByTagName('td');
            no = td[0].innerText;
            no1 = td[1].innerText;
        }
    }
}


</script>


</body>
</html>
