<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기관정보수정</title>
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
		<a class="nav-link active" href="modify" style="border-color: #e2e3e5; background-color: #e2e3e5;" aria-current="page">의료기관 정보수정</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="vaccine">백신 잔여량</a>
	</li>
</ul>
<!-- 클릭시 이동 기능 끝 -->

<!-- 예약조회 검색기능 시작 -->
<table style="background-color: #e2e3e5; width: 1500px; height: 790px;">
	
		<!-- 제목 시작 -->
		<tr style="height: 20px;">
			<td colspan="5" class="align-top"><br> &nbsp; 
				<span style="font-weight: bold;">◎</span> 
				기관관리 > 
				<span style="font-weight: bold;">의료기관 정보수정</span>
			</td>
		</tr>
		<!-- 제목 끝 -->
		
		<tr>
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 48%" class="align-top">
		          <!-- 의료기관 정보수정 시작 -->
				  <div class="card border-dark" >
		  			<div class="card-body" style="height: 21rem;">
		  				<form action="hspInfoModifySetUp" method="post">
								▶ 의료기관 정보 설정
								<!-- 수정버튼 모달 시작 -->
								<button style="float: right;" type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#hspInfoSetUp">
								  수정
								</button>
								
								<!-- Modal -->
								<div class="modal fade" id="hspInfoSetUp" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog modal-dialog-centered">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h1 class="modal-title fs-5" id="staticBackdropLabel">수정하기</h1>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								      	의료기관 정보를 수정하시겠습니까?
								      </div>
								      <div class="modal-footer">
								        <button type="submit" class="btn btn-primary">수정하기</button>
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								      </div>
								    </div>
								  </div>
								</div>
			  			
							<table class="table align-top">
								  <tr>
									<td class="table-primary text-center fw-bold" width="150">의료기관명</td>
									<td>
										<input type="text" name="hspName" value="${hspInfo.hspName }">
									</td>
									<td class="table-primary text-center fw-bold" width="150">가입일</td>
									<td>
										<font>${hspInfo.rgstDate }</font>
									</td>
								  </tr>
								  <tr>
									<td class="table-primary text-center fw-bold">기관종류</td>
									<td colspan="3">
										<font>${hspInfo.hspKind }</font>
									</td>
								  </tr>
								<tr>
									<td class="table-primary text-center fw-bold">주소</td>
									<td colspan="3">
										<input type="text" name="hspAddress" style="width: 300px;" value="${hspInfo.hspAddress}">
										<input type="text" name="hspCrntAdd" style="width: 200px;" value="${hspInfo.hspCrntAdd}">
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">전화번호</td>
									<td colspan="3">
										<input type="text" name="hspTel" value="${hspInfo.hspTel }">
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">예진의사수</td>
									<td colspan="3">
										<input type="text" name="hspDrNum" value="${hspInfo.hspDrNum }" onkeyup="totalInjection()" id="doctorNum">
										<input type="text" readonly="readonly" value="${hspInfo.hspNum }" name="hspNum" id="totalNum" required>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">점심시간</td>
									<td>
							              <select name="hspLunchSt">
							                <option value="${hspInfo.hspLunchSt }">${hspInfo.hspLunchSt }</option>
							                <option>오전 9시</option>
							                <option>오전 10시</option>
							                <option>오전 11시</option>
							                <option>오후 12시</option>
							                <option>오후 1시</option>
							              </select>
							              ~
							              <select name="hspLunchCl">
							                <option value="${hspInfo.hspLunchCl }">${hspInfo.hspLunchCl }</option>
							                <option>오후 1시</option>
							                <option>오후 2시</option>
							                <option>오후 3시</option>
							                <option>오후 4시</option>
							                <option>오후 5시</option>
							              </select>
						               </td>
									</tr>
								</table>
							</form>	
						</div>
					</div>
					
					<!-- 요일지정 시작 -->
					<div class="card border-dark">
			  			<div class="card-body" style="height: 24rem;">
			  				<form action="hspAppTimeModify" method="post">
			  				▶ 의료기관 요일별 예약시간
								<!-- 수정버튼 모달 시작 -->
								<button style="float: right;" type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#hspAppTime">
								  수정
								</button>
								
								<!-- Modal -->
								<div class="modal fade" id="hspAppTime" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog modal-dialog-centered">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h1 class="modal-title fs-5" id="staticBackdropLabel">수정하기</h1>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								       	예약가능시간을 수정하시겠습니까?
								      </div>
								      <div class="modal-footer">
								        <button type="submit" class="btn btn-primary" value="수정하기">수정하기</button>
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								      </div>
								    </div>
								  </div>
								</div>
			  				<table class="table align-top">
								<thead>
								    <tr>
								      <th class="table-primary text-center fw-bold">구분</th>
								      <th class="table-primary text-center fw-bold">예약시작시간</th>
								      <th class="table-primary text-center fw-bold">~</th>
								      <th class="table-primary text-center fw-bold">예약종료시간</th>
								    </tr>
								  </thead>
								  <tbody>
								    <tr>
								      <th scope="row" class="text-center">월</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStMon" class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStMon }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									                <option selected disabled>${hspRunTime.hspClMon }</option>
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
								      <th scope="row" class="text-center">화</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStTue" class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStTue }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClTue"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClTue }</option>
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
								      <th scope="row" class="text-center">수</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStWed"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStWed }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClWed"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClWed }</option>
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
								      <th scope="row" class="text-center">목</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStThu"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStThu }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClThu"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClThu }</option>
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
								      <th scope="row" class="text-center">금</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStFri"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStFri }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClFri"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClFri }</option>
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
								      <th scope="row" class="text-center">토</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStSat"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStSat }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClSat"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClSat }</option>
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
								      <th scope="row" class="text-center">일</th>
								      <td>
								      	<div class="d-flex justify-content-center">
									      	<select name="hspStSun"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspStSun }</option>
									                <option>오전7시</option>
									                <option>오전8시</option>
									                <option>오전9시</option>
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
									      	<select name="hspClSun"  class="custom-select d-block w-50">
									                <option selected disabled>${hspRunTime.hspClSun }</option>
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
						</form>		
					</div>
				 </div>
				<!-- 요일지정 시작 -->
			</td>
			<!-- 의료기관정보수정 끝 -->
			
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 48%" class="align-top">
				<!-- 운영시간 수정 시작 -->
			<div class="card border-dark">
					<div class="card-body" style="height: 45.2rem;">
						▶ 의료기관 취급 백신종류
						<!-- 의료기관 요일별 예약시간 시작 -->
						<div class="table-responsive" style="max-width: 900px; height: 660px; overflow: auto;">
						<table style="width: 100%; white-space: nowrap;"  class="table table-bordered">
						     
								<thead>
									<tr>
										<th class="table-primary text-center fw-bold sticky-top">백신종류</th>
									</tr>
								</thead>
								
								<tbody>
									<tr>
										<td>
											 <form action="hspVaccineModify" method="post">
									            <label class="custom-control-label" for="aggrement">인플루엔자(독감)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList1 eq 'true'}">
															<!-- Button trigger modal -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete1">
															  삭제
															</button>
															
															<!-- Modal -->
															<div class="modal fade" id="vaccineDelete1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="exampleModalLabel">취급백신 삭제</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															        삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
																        <input type="hidden" name="remove" value="remove">
																        <input type="hidden" name="hspVaccineCk" value="인플루엔자(독감)">
																        <button type="submit" class="btn btn-danger">삭제하기</button>
																        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
																<input type="hidden" name="add" value="add">
																<input type="hidden" name="hspVaccineCk" value="인플루엔자(독감)">
																<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>
												    
												</div>	
											</form>	
							            </td>
						            </tr>
									<tr>
										<td>
											<form action="hspVaccineModify" method="post">	           
								            <label class="custom-control-label" for="aggrement">결핵(BCG, 피내용)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList2 eq 'true'}">
															<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete2">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="결핵(BCG, 피내용)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
																<input type="hidden" name="add" value="add">
																<input type="hidden" name="hspVaccineCk" value="결핵(BCG, 피내용)">
																<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>
												</div>
											</form>	
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	 
									            <label class="custom-control-label" for="aggrement">B형간염(HepB)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList3 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete3">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="B형간염(HepB)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
																<input type="hidden" name="add" value="add">
																<input type="hidden" name="hspVaccineCk" value="B형간염(HepB)">
																<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>
												</div>
											</form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  	 
									            <label class="custom-control-label" for="aggrement">디프테리아/파상풍/백일해(DTaP)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList4 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete4">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete4" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해(DTaP)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
																<input type="hidden" name="add" value="add">
																<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해(DTaP)">
																<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												</div>   
											</form> 
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">디프테리아/파상풍/백일해/폴리오(DTaP-IPV)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList5 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete5">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete5" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오(DTaP-IPV)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오(DTaP-IPV)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												</div>  
											</form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList6 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete6">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete6" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div>   
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">디프테리아/파상풍/백일해(TdaP)</label>
									            <div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList7 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete7">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete7" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해(TdaP)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="디프테리아/파상풍/백일해(TdaP)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">파상풍/디프테리아(Td)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList8 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete8">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete8" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="파상풍/디프테리아(Td)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="파상풍/디프테리아(Td)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">폴리오(IPV)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList9 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete9">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete9" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="폴리오(IPV)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="폴리오(IPV)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	
									            <label class="custom-control-label" for="aggrement">b형헤모필루스인플루엔자</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList10 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete10">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete10" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="b형헤모필루스인플루엔자">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="b형헤모필루스인플루엔자">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">폐렴구균(PCV 10가)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList11 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete11">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete11" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 10가)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 10가)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">폐렴구균(PCV 13가)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList12 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete12">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete12" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 13가)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 13가)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">폐렴구균(PCV 23가)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList13 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete13">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete13" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 23가)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="폐렴구균(PCV 23가)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>		
												 </div> 
											 </form>
						            	</td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" method="post">	  
									            <label class="custom-control-label" for="aggrement">홍역/유행성이하선염/풍진(MMR)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList14 eq 'true'}">
																<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete14">
															  삭제
															</button>
															
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete14" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="홍역/유행성이하선염/풍진(MMR)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="홍역/유행성이하선염/풍진(MMR)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>		
												 </div> 
											 </form>
							            </td>
						            </tr>
						            <tr>
										<td>
											<form action="hspVaccineModify" >	  
									            <label class="custom-control-label" for="aggrement">A형간염(HepA)</label>
												<div style="float: right;">
													<c:choose>
														<c:when test="${dtoList.hspKindList15 eq 'true'}">
															<!-- 삭제 모달 -->
															<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineDelete15">
															  삭제
															</button>
															<!-- 클릭 시 모달이벤트 -->
															<div class="modal fade" id="vaccineDelete15" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
															  <div class="modal-dialog modal-dialog-centered">
															    <div class="modal-content">
															      <div class="modal-header">
															        <h1 class="modal-title fs-5" id="staticBackdropLabel">해당 백신 삭제하기</h1>
															        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
															      </div>
															      <div class="modal-body">
															       	삭제 시 예약불가능 백신이 됩니다.<br> 
															        정말로 삭제하시겠습니까?
															      </div>
															      <div class="modal-footer">
															      	<input type="hidden" name="remove" value="remove">
															      	<input type="hidden" name="hspVaccineCk" value="A형간염(HepA)">
															        <button type="submit" class="btn btn-danger">삭제하기</button>
															        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
															      </div>
															    </div>
															  </div>
															</div>
														</c:when>
														<c:otherwise>
															<input type="hidden" name="add" value="add">
															<input type="hidden" name="hspVaccineCk" value="A형간염(HepA)">
															<button type="submit" class="btn btn-primary btn-sm">추가</button>
												    	</c:otherwise>
												    </c:choose>	
												 </div> 
											 </form>
										</td>
									</tr>
					           	 </tbody>
					 		</table>
					 	<!-- 의료기관 요일별 예약시간 끝 -->
					 	</div>
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



</body>
</html>
