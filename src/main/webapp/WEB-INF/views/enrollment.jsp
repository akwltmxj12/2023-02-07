<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해당의료기관에서 접종자 예약하기</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/enrollment.js"></script>


</head>
<body style="background-color: #212529;">

<table align="center" style="background-color: #ffffff;">
	<tr class="table bg-dark" style="height: 20px;">
		<td colspan="3"></td>
	</tr>
	<tr>
		<td></td>
		<td style="width: 1500px; height: 790px;">

<!-- 헤더 시작 -->
<%@ include file="include/header.jsp" %>
<!-- 헤더 끝 -->

<!-- 클릭시 이동 기능 시작 -->
<ul class="nav nav-tabs">
	<li class="nav-item">
		<a class="nav-link" href="search">예약조회</a>
	</li>
	<li class="nav-item">
		<a class="nav-link active" style="border-color: #e2e3e5; background-color: #e2e3e5;" aria-current="page" href="#">예방접종등록</a>
	</li>
</ul>
<!-- 클릭시 이동 기능 끝 -->

<!-- 예약조회 검색기능 시작 -->
<table style="background-color: #e2e3e5; width: 1500px; height: 790px;">
		<!-- 제목 시작 -->
		<tr>
			<td colspan="5"><br> &nbsp; 
				<span style="font-weight: bold;">◎</span> 
				예약관리 > 
				<span style="font-weight: bold;">예방접종등록</span>
			</td>
		</tr>
		<!-- 제목 끝 -->
		
		<tr>
			<td style="width: 1%"></td>
			<td style="width: 54%" class="align-top">
				<div class="card" style="height: 3.7rem;">
					<div class="card-body border border-primary">
						<!-- 등록된 이름인지 테이블 조회 시작 -->
						<table style="width: 100%;">
							 <form action="juminSearch" method="post">
								<tr>
									<td>
									 	<div>ο 성명:&nbsp; </div>
									</td>
									<td>
										<input type="text" name="mName" style="width: 100px;" required="required">
									</td>
									<td>ο 주민등록번호:&nbsp; </td>
									<td>
										<input type="text" name="mJumin1" style="width: 100px;" maxlength="6" required="required"> - <input type="text" name="mJumin2" style="width: 100px;" maxlength="7" required="required">
									</td>
									<td align="right">
										<button type="submit" class="btn btn-primary btn-sm">조회</button>
										<button type="reset" class="btn btn-secondary btn-sm">취소</button>
									</td>
								</tr>
							</form>
						</table>
					 </div>
				</div>	 
						 <!-- 등록된 이름인지 테이블 조회  끝 -->
						 
				<!-- 검색결과 시작-->
				<div class="card" style="height: 8.8rem;">
					<div class="card-body border border-secondary">
						▶ 예약내역
						<table class="table table-bordered align-top">
							<thead class="table-primary">
								<tr>
									<th class="text-center">성명</th>
									<th class="text-center">주민등록번호</th>
									<th class="text-center">예약내역</th>
								</tr>
							</thead>
								<tr>
									<td class="text-center">${rs.mName }</td>
									<td class="text-center">${rs.mJumin1 }-${rs.mJumin2 }</td>
									<td class="text-center">${rs.appCk }</td>
								</tr> 
						</table>		
					</div>
				</div>	 
				<!-- 검색결과 출력 끝-->


							
				<!-- 피접종자정보 입력칸 시작 -->
			<form action="appInfo" name="enroll_frm" method="post">	
				<div class="card" style="height: 22rem;">
					<div class="card-body border border-secondary">
						<table style="width: 100%;" class="table table-bordered" cellpadding="2">
								▶ 피접종자정보
								<tr>
									<td class="table-primary text-center fw-bold">피접종자구분</td>
									<td class="text-center">
										<label><input type="radio" name="human" value="내국인" checked="checked">&nbsp;내국인&nbsp;&nbsp;</label>
										<label><input type="radio" name="human" value="외국인" >&nbsp;외국인&nbsp;&nbsp;</label>
										<label><input type="radio" name="human" value="관리번호">&nbsp;관리번호&nbsp;&nbsp;</label>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">성명</td>
									<td><input type="text" name="mName" value="${mrs.mName }" required></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">주민등록번호</td>
									<td><input type="text" name="mJumin1" maxlength="6" value="${mrs.mJumin1 }" required> - <input type="text" name="mJumin2" value="${mrs.mJumin1 }" maxlength="7" required></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">휴대전화번호</td>
									<td>
										<select name="tel1" style="width: 100px;">
											<option>번호선택</option>
											<option>010</option>
											<option>011</option>
											<option>016</option>
											<option>018</option>
										</select>
										-
										<input type="text" name="tel2" maxlength="4" style="width: 100px;" required> - <input type="text" name="tel3" maxlength="4" style="width: 100px;" required>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">문자수신동의</td>
									<td>
										<label><input type="checkbox">이상반응발생관련</label>
									</td>
								</tr>
					 	</table>
					</div>
			  	</div>
				<!-- 피접종자 입력칸 끝 -->
				
				<!-- 피접종자 예진결과 시작 -->
				<div class="card" style="height: 11rem;">
					<div class="card-body border border-secondary" style="height: 11rem;">
						<table style="width: 100%;" class="table table-bordered" cellpadding="2">
								▶ 피접종자정보 예진결과
								<tr>
									<td rowspan="2" class="table-primary text-center fw-bold">예진결과</td>
								</tr>
								<tr>
									<td colspan="2" class="text-center">
										<label><input type="radio" name="rsCk" value="예방접종 가능" checked="checked">&nbsp;예방접종 가능</label>
										<label><input type="radio" name="rsCk" value="예방접종 연기">&nbsp;예방접종 연기</label>
										<label><input type="radio" name="rsCk" value="예방접종 금기">&nbsp;예방접종 금기</label>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">사유</td>
									<td>
										<textarea rows="2" cols="85" name="rsTxt"></textarea>
									</td>
								</tr>
					 	</table>
					</div>
			  	</div>
			  	<!-- 피접종자 예진결과 시작 -->
			</td>
			<td style="width: 1%"></td>
			<td style="width: 43%" class="align-top">
				<!-- 예방접종 등록 폼 시작 -->
				<div class="card">
					<div class="card-body border border-secondary">
						<table style="width: 100%;" class="table table-bordered" cellpadding="2">
								▶ 예방접종 등록
								<tr>
									<td class="table-primary text-center fw-bold">접종차수</td>
									<td>
										<input type="text" name="injecNum" required>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">백신명</td>
									<td>
										<select name="vaccineName" style="width: 400px;"  required>										
												<option>백신선택</option>
											<c:forEach items="${hspVaccins }" var="VaccineList">	
												<option>${VaccineList }</option>
											</c:forEach>	
										</select>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">접종일자</td>
									<td><input type="date" name="appDate" id="injectDate" required></td>
								</tr>
								<tr>
									<td class="table-primary text-center fw-bold">예약시간</td>
									<td>
										<select name="appTime" class="custom-select d-block w-50" required>
							                <option>시간선택</option>
							                <option>오전09시</option>
							                <option>오전10시</option>
							                <option>오전11시</option>
							                <option>오후12시</option>
							                <option>오후1시</option>
							                <option>오후2시</option>
							                <option>오후3시</option>
							                <option>오후4시</option>
				              			</select>
									</td>
								</tr>
								<tr>
									<td class="table-primary text-middle fw-bold" style="text-align : center; vertical-align : middle;">
										특이사항
									</td>
									<td>
										<textarea rows="3" cols="60" name="memo"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button style="float: right;" class="btn btn-primary btn-lg" onclick="enrollmentCkeck(); return false;">접종등록하기</button>
									</td>										
								</tr>
					 	</table>
					</div>
			  	</div>
				<!-- 예방접종 등록 폼 끝 -->
			</form> <!-- 등록하기 끝 -->
				
				
			<!-- 접종기관 일자별 접종현환(최근1주일) 시작 -->
			<div class="card">
			<div class="card-body border border-secondary">
				▶ 접종기관 일자별 접종현황
				<div class="table-responsive" style="max-width: 600px; height: 250px; overflow: auto;">
				<table style="width: 100%; white-space: nowrap;" class="table table-bordered align-top table-hover">
					<thead class="table-primary">
						<tr>
							<th class="text-center">접종일자</th>
							<th class="text-center">백신종류</th>
							<th class="text-center">접종건수</th>
							<th class="text-center">백신 예상사용량</th>
						</tr>
					</thead>
						<!-- 무한 루프 돌려야 함!! -->
						<c:forEach items="${appList }" var="appListRs">
							<tr>
								<td>${appListRs.appDate }</td>
								<td>${appListRs.vaccineName }</td>
								<td>${appListRs.cnt }</td>
								<td>${appListRs.cnt }</td>
							</tr>
						</c:forEach>
						<!-- 무한 루프 돌려야 함!! -->
					</table>
					</div>
			  	  </div>
			  </div>
				<!-- 접종기관 일자별 접종현환(최근1주일) 끝 -->
			
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
		<td></td>
	</tr>
	<tr>
		<td colspan="3"></td>
	</tr>
</table>

<script type="text/javascript">

// 예약날짜 조회 시작일은 현재날	
var now_utc = Date.now() // 지금 날짜를 밀치로로 알려줌
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위로 변환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0]; //'2022-05-11T18:09:38.134Z'를 변환

document.getElementById("injectDate").setAttribute("min", today);

</script>

<script type="text/javascript">

if(!$('input:radio[name=human]').is(':checked')) {   
		  alert("1개 이상 선택해 주세요.");
		   return;
		}
	);


</script>


</body>
</html>
