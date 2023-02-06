<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접종 후 부작용 환자조회</title>


<style>

   .sticky-head-one {
       position: sticky;
       top: 0px;
   }

   .sticky-head-two {
       position: sticky;
       top: 42px;
   }

</style>



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
		<a class="nav-link active" style="border-color: #e2e3e5; background-color: #e2e3e5;" aria-current="page" href="check">예약접종조회</a>
	</li>
</ul>
<!-- 클릭시 이동 기능 끝 -->

<!-- 조회 검색기능 시작 -->
<table style="width: 100%; background-color: #e2e3e5; width: 1500px; height: 790px">
	
<form action="checkCondition" method="post">
	<!-- 검색기능 제목 시작 -->
	<tr>
		<td colspan="3"><br> &nbsp; 
		<span style="font-weight: bold;">◎</span> 
		접종관리 > 
		<span style="font-weight: bold;">예방접종조회</span>
		</td>
		<td valign="bottom" align="right">
			<div class="btn-group" role="group" aria-label="Basic example">
			  <button type="submit" class="btn btn-primary">조회</button>
			  <button type="reset" class="btn btn-secondary">취소</button>
			</div>
		</td>
		<td style="width: 0.5%;"></td>
	</tr>
	<!-- 검색기능 제목 끝 -->
	
	
	<!-- 검색기능 시작 -->
	<tr>
		<td style="width: 0.5%;">
		<td colspan="3">
			<div class="card border-primary">
				<div class="card-body">
					<!-- 검색기능 테이블 시작 -->
					<table style="width: 100%;" cellpadding="5" >
						<tr>
							<td>
							 	<div>ο 조회기간</div>
							</td>
							<td>
								<input type="date" id="todate" name="todate" required> ~ <input type="date" id="dateApp" name="dateApp" required>
							</td>
							<td>ο 접종시간</td>
							<td>
								<select name="appTime1">
									<option>시간선택</option>
									<option>오전09시</option>
									<option>오전10시</option>
									<option>오전11시</option>
									<option>오후12시</option>
									<option>오후1시</option>
									<option>오후2시</option>
									<option>오후3시</option>
									<option>오후4시</option>
									<option>오후5시</option>
									<option>오후6시</option>
								</select>
								~
								<select name="appTime2">
									<option>시간선택</option>
									<option>오전09시</option>
									<option>오전10시</option>
									<option>오전11시</option>
									<option>오후12시</option>
									<option>오후1시</option>
									<option>오후2시</option>
									<option>오후3시</option>
									<option>오후4시</option>
									<option>오후5시</option>
									<option>오후6시</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<div>ο 접종자명</div>
							</td>
							<td>
								<input type="text" name="injectionName">
							</td>
							<td>
								<div>ο 접종자 주민등록번호</div>
							</td>
							<td>
								<input type="text" name="jumin1"> - <input type="text" name="jumin2">
							</td>
						</tr>
					</table>
					<!-- 검색기능 검색대 끝 -->
				</div>
			</div>
		</td>
		<td style="width: 1%;"></td>
	</tr>
</form>
	<!-- 검색기능 끝 -->
	
	<!-- 검색기능 하단부분 여백 시작 -->	
	<tr style="height: 1px;">
		<td colspan="5" style="height: 1px;"><br></td>
	</tr>
	<!-- 검색기능 하단부분 여백 끝 -->
	
	<tr>
		<!-- 예약조회 왼쪽부분 여백 시작 -->
		<td rowspan="3" style="width: 0.5%;"></td>
		<!-- 예약조회 왼쪽부분 여백 시작 -->
		
		<!-- 예약조회 기능 시작 -->
		<td rowspan="3" class="align-top" style="width: 60%;">
			<div class="card border-dark"  style="height: 34rem;">
				<div class="card-body">
					▶ 예방접종 조회결과
					<div class="table-responsive" style="max-width: 900px; height: 500px; overflow: auto;">
						<table id="table-member-check" style="width: 100%; white-space: nowrap;" class="table table-striped table-bordered align-top table-hover">
								<thead class="table-primary">
									<tr class="text-center sticky-head-one">
										<th  rowspan="2" style="text-align : center; vertical-align : middle;">예약일자</th>
										<th  rowspan="2" style="text-align : center; vertical-align : middle;">예약시간</th>
										<th  colspan="2">예약자 정보</th>
										<th  colspan="7">접종자정보</th>
									</tr>
									
									<tr class="text-center sticky-head-two">
										<th >성명</th>
										<th >연락처</th>
										<th >성명</th>
										<th >연락처</th>
										<th >주민등록번호</th>
										<th >접종차수</th>
										<th >접종백신명</th>
										<th >접종예약 경로</th>
										<th >접종 후 부작용</th>
									</tr>
								</thead>
								<tbody>
								    <!-- 반복분으로 돌려야 함!! -->
									<c:forEach items="${allApp }" var="allAppList">
									   <tr onclick="javascript:getReserveInfo(this);">
											<td>${allAppList.appDate }</td>
											<td>${allAppList.appTime }</td>
											<td>${allAppList.appName }</td>
											<td>${allAppList.appTel }</td>
											<td>${allAppList.mName }</td>
											<td>${allAppList.mTel }</td>
											<td>${allAppList.mJumin1 }-${allAppList.mJumin2 }</td>
											<td>${allAppList.injecNum }</td>
											<td>${allAppList.vaccineName }</td>
											<td>${allAppList.appRoute }</td>
											<td>${allAppList.rsTxt }</td>
										</tr>
									</c:forEach>
								    <!-- 반복분으로 돌려야 함!! -->
								</tbody>
						</table>
					</div>
				</div>
			</div>
		</td>
		<!-- 예약조회 기능 끝 -->
		
		<!-- 중앙부분 여백 시작 -->
		<td rowspan="3" style="width: 1%;"></td>
		<!-- 중앙부분 여백 끝 -->
		
		<!-- 예약내역관리 시작 -->
		<form action="checkOk" method="post">
		<td style="width: 38%;" class="align-top">
			<div class="card max-width: 18rem; border-dark">
				<div class="card-body">
					▶ 내역 관리
						<table style="width: 100%;" class="table table-bordered" cellpadding="2">
							<tr>
								<td style="width: 120px;" class="table-primary text-center fw-bold">등록구분</td>
								<td>
									<span id="appRouteResult"></span>
								</td>
							</tr>
							<tr>
								<td class="table-primary text-center fw-bold" >예약기관명</td>
								<td>${hspInfo.hspName }</td>
							</tr>
							<tr>
								<td class="table-primary text-center fw-bold">피접종자 정보</td>
								<td>
									<div>성명: <span id="mNameResult"></span></div>
									<input type="hidden" name="mNameClick" value="">
									<div>주민등록번호: <span id="mJuminResult"></span></div>
									<input type="hidden" name="mJuminClick" value="">
								</td>
							</tr>
							<tr>
								<td class="table-primary text-center fw-bold">백신명</td>
								<td>
									<div><span id="vaccineNameResult"></span></div>
									<input type="hidden" name="vaccineNameClick" value="">
								</td>
							</tr>
							<tr>
								<td class="table-primary text-center fw-bold">접종차수</td>
								<td><span id="injecNumResult"></span></td>
							</tr>
					 	</table>
					</div>
			  	</div>
		 </td>
		 <!-- 예약내역관리 시작 -->
		 
		 <!-- 오른쪽 여백 시작 -->
		 <td rowspan="3" style="width: 1%;"></td>
		 <!-- 오른쪽 여백 시작 -->
	</tr>
	
	<!-- 내역관리 하단부분 여백 시작 -->
	<tr>
		<td style="width: 1%;"></td>
	</tr>
	<!-- 내역관리 하단부분 여백 시작 -->
	
	<!-- 접종 후 7일이내 이상반응 시작 -->
	<tr>
		<td class="align-top">
			<div class="card border-dark" >
				<div class="card-body" style="height: 13rem;">
					▶ 접종 후 7일이내 이상반응
					<button type="submit" style="float: right;"  class="btn btn-primary btn-sm">저장</button>
					<table style="width: 100%;" class="table table-bordered align-top">
						<thead>	
							<tr>
								<th class="table-primary text-center fw-bold">이상반응 기입</th>
							</tr>
						</thead>	
							<tr>
								<td>
									<textarea rows="3" cols="60" name="memo"></textarea>
								</td>
							</tr>
					 </table>
			  	 </div>
			  </div>
	 	 </td>
	 </tr>
	 </form>
	 <!-- 접종 후 7일이내 이상반응 끝 -->
	 
	<!-- 검색기능 하단부분 여백 시작 -->	
	<tr style="height: 1px;">
		<td colspan="5" style="height: 1px;"><br></td>
	</tr>
	<!-- 검색기능 하단부분 여백 끝 -->
	
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

document.getElementById("dateApp").setAttribute("max", today);
document.getElementById("todate").setAttribute("max", today);

</script>


<script type="text/javascript">

//테이블 클릭 시 이벤트 발생

$("#table-member-check tr").click(function(){  // 테이블 id값 불러오기
	
	var appRouteStr = "";
	
	var mNameStr = "";
	var mTelStr = "";
	var injecNumStr = "";
	
	var lastInjecNameStr = "";
	var lastInjecStr = "";
	var lastInjecDateStr = "";
	
	
	
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
	var appDate = td.eq(0).text(); // 예약일
	var appTime = td.eq(1).text();  //예약시간
	var appName = td.eq(2).text(); // 예약자
	var appTel = td.eq(3).text(); //예약자 전화번호
	
	var mName = td.eq(4).text(); // 접종자 이름
	var mTel = td.eq(5).text();  // 접종자 전화번호
	var mJumin = td.eq(6).text();  // 접종자 주민번호
	var injecNum = td.eq(7).text(); // 접종자 예약 접종 차수
	var vaccineName = td.eq(8).text(); // 접종명
	var appRoute = td.eq(9).text();   //예약경로
	var appMemo = td.eq(10).text();  // 접종 메모사항
	
	var lastInjecDate = td.eq(11).text();  // 마지막 접종일
	var lastInjecName = td.eq(12).text();   // 마지막 접종명
	var lastInjec = td.eq(13).text();  // 마지막 접종 차수
	var sideEffect = td.eq(14).text(); // 이전 접종 부작용
	var mSgck = td.eq(15).text();    // 피접종자 특이사항
	var rsTxt = td.eq(16).text();     // 접종가능 결과

	appRouteStr = "<font>"+ appRoute +"</font>";
	
	vaccineNameStr = "<font>"+ vaccineName +"</font>";
	
	mNameStr = "<font>"+ mName +"</font>";
	mJuminStr = "<font>"+ mJumin +"</font>";
	injecNumStr = "<font>"+ injecNum +"</font>";
	
	lastInjecNameStr = "<font>"+ lastInjecName +"</font>";
	lastInjecStr = "<font>"+ lastInjec +"</font>";
	lastInjecDateStr = "<font>"+ lastInjecDate +"</font>";
	
	$('#appRouteResult').html(appRouteStr); //예약루트(모바일,해당의료기관 )
	
	$('#mNameResult').html(mNameStr); // 피접종자
	$('#mJuminResult').html(mJuminStr); // 피접종자 주민번호
	$('#injecNumResult').html(injecNumStr);

	$('#vaccineNameResult').html(vaccineNameStr); // 백신명

	$('#lastInjecNameResult').html(lastInjecNameStr);
	$('#lastInjecResult').html(lastInjecStr);
	$('#lastInjecDateResult').html(lastInjecDateStr);
	
	$('input[name=mNameClick]').attr('value',mName);  //클릭된 값의 파라미터값 날려주기(접종자이름)
	$('input[name=mJuminClick]').attr('value',mJumin); //클릭된 값의 파라미터값 날려주기(접종자 주민번호)
	$('input[name=vaccineNameClick]').attr('value',vaccineName); //백신명
	
	
});


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
