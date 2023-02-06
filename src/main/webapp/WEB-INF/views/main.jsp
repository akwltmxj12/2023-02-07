<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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



<!-- 예약조회 검색기능 시작 -->
<table style="background-color: #e2e3e5; width: 1500px; height: 790px;">
	<form>
		<!-- 제목 시작 -->
		<tr style="height: 20px;">
			<td colspan="5" class="align-top"><br> &nbsp; 
				<span style="font-weight: bold;">&nbsp;◎&nbsp;메인화면</span> 
			</td>
		</tr>
		<!-- 제목 끝 -->
		
		<tr>
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 40%">
				<div class="card">
					<div class="card-body" style="height: 45rem;">
						<!-- 백신 종류 조회 시작 -->
						<table style="width: 100%;">
							<tr>
								<td>
									<!-- 의료기관 정보수정 시작 -->
								  <div class="card border-primary" >
						  			<div class="card-body" style="height: 21rem;">
						  				▶ 의료기관 정보 설정
											<table class="table">
												<tr>
													<td style="width: 250px;" class="table-primary text-center fw-bold">의료기관명</td>
													<td>
														<font>${hspInfo.hspName }</font>
													 </td>
												</tr>
												<tr>
													<td class="table-primary text-center fw-bold">기관종류</td>
													<td>
														<font>${hspInfo.hspKind }</font>				
													 </td>
												</tr>
												<tr>
													<td class="table-primary text-center fw-bold">예진의사수</td>
													<td>
														<font>${hspInfo.hspDrNum}</font>
													</td>
												</tr>
												<tr>
													<td class="table-primary text-center fw-bold">시간당 접종가능 수</td>
													<td>
														<font>${hspInfo.hspNum }&nbsp; 명</font>
													</td>
												</tr>
												<tr>
													<td class="table-primary text-center fw-bold">오늘 예약건수</td>
													<td>
												         <font>${todayVaccine }&nbsp; 건 </font> 
												    </td>
												</tr>
												<tr>
													<td colspan="2" align="right">
														<button type="button" class="btn btn-primary position-relative" onclick="script:window.location='search'">
														  	미확인예약
														  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
														    ${appCheck }
														  </span>
														</button>
													</td>
												</tr>
											</table>
										</div>
									</div>	
								</td>
							</tr>
							<tr>
								<td style="height: 1rem;"></td>
							</tr>
							<tr>
								<td>
									<!-- 버튼 시작 -->
									<div class="card" style="height: 19rem;">
										<div class="card-body border border-primary">
											<div class="d-grid gap-2">
											  <button class="btn btn-primary btn-lg" type="button" onclick="script:window.location='search'">예약조회</button>
											  <button class="btn btn-primary btn-lg" type="button" onclick="script:window.location='vaccine'">백신잔여량</button>
											  <button class="btn btn-secondary btn-lg" type="button" onclick="script:window.location='enrollment'">예방접종등록</button>
											  <button class="btn btn-secondary btn-lg" type="button" onclick="script:window.location='modify'">의료기관정보수정</button>
											  <button class="btn btn-secondary btn-lg" type="button" onclick="script:window.location='check'">예방접종 조회</button>
											</div>
										</div>
									</div>
									<!-- 버튼 끝 -->
								</td>
							</tr>
						</table>
					 </div>
				</div>	 
			</td>
			<!-- 백신 검색결과 출력 끝-->			
			<td style="width: 1%" class="align-top"></td>
			<td style="width: 55%" class="align-top">
				
				<div class="card">
					<div class="card-body" style="height: 45rem;">
						<table style="width: 100%">
							<tr>
								<td>
									<!-- 백신종류 출력 시작-->
									<div class="card">
										<div class="card-body border border-primary table-responsive" style="height: 42rem;">
											▶ 백신잔여량
											<div class="table-responsive" style="max-width: 800px; height: 700px; overflow: auto;">
											<table class="table table-bordered align-top table-hover" style="width: 100%; white-space: nowrap;">
												<thead class="table-primary">
													<tr>
														<th class="text-center">백신종류</th>
														<th class="text-center">제조사</th>
														<th class="text-center">입고날짜</th>
														<th class="text-center">폐기날짜</th>
														<th class="text-center">현재보유량</th>
														<th class="text-center">실제백신사용량</th>
													</tr>
												</thead>
												
													<!-- 무한루프 -->
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
													<!-- 무한루프 -->
											</table>
										</div>
									</div>	 
								    <!-- 백신종류 출력 끝-->
			   					</td>
							</tr>
						</table>
					</div>
				</div>
			</td>
			<td style="width: 1%"></td>
		</tr>
		<tr>
			<td colspan="5" style="height: 3rem;"></td>
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
