/**
 * 
 */
 
 
  function enrollmentCkeck(){
	
	if(document.enroll_frm.mName.value.length == 0) {
		alert("이름은 필수 입력사항입니다!");
		document.enroll_frm.mName.focus();
		return;
	}

	else if(document.enroll_frm.mJumin1.value.length == 0) {
		document.enroll_frm.mJumin1.focus();
		alert("생년월일은 필수 입력사항입니다!");
		return;
	}

	else if(document.enroll_frm.mJumin2.value.length == 0) {
		document.enroll_frm.mJumin2.focus();
		alert("주민등록번호는 필수 입력사항입니다!");
		return;
	}
	
	else if(document.enroll_frm.tel1.value.length == 0) {
		document.enroll_frm.tel1.focus();
		alert("전화번호는 필수 입력사항입니다!");
		return;
	}

	else if(document.enroll_frm.tel2.value.length == 0) {
		document.enroll_frm.tel2.focus();
		alert("전화번호는 필수 입력사항입니다!");
		return;
	}

	else if(document.enroll_frm.tel3.value.length == 0) {
		document.enroll_frm.tel3.focus();
		alert("전화번호는 필수 입력사항입니다!");
		return;
	}
	else if(document.enroll_frm.injecNum.value.length == 0) {
		document.enroll_frm.injecNum.focus();
		alert("접종차수는 필수 입력사항입니다!");
		return;
	}
	
	else if(document.enroll_frm.appDate.value.length == 0) {
		document.enroll_frm.appDate.focus();
		alert("예약일은 필수 입력사항입니다!");
		return;
	}
	
	else if(document.enroll_frm.appTime.value == "시간선택") {
		document.enroll_frm.appTime.focus();
		alert("예약시간은 필수 선택사항입니다!");
		return;
	}
	
	else if(document.enroll_frm.vaccineName.value == "백신선택") {
		document.enroll_frm.vaccineName.focus();
		alert("백신이름은 필수 선택사항입니다!");
		return;
	}
	
	else if(document.enroll_frm.memo.value.length == 0) {
		document.enroll_frm.memo.focus();
		alert("특이사항이 없으면 '없음'이라고 기입해주세요!");
		return;
		
	} else{
		
		document.enroll_frm.submit();
	}
	
		
	
	
}