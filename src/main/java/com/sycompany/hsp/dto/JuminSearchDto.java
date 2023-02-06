package com.sycompany.hsp.dto;


public class JuminSearchDto { // 예약전 예약이 있는시 조회하기

	String mName;  //이름
	
	String mJumin1; //생년월일
	
	String mJumin2; //주민번호 뒷자리
	
	String appCk; // 예약있는지 여부 확인

	public JuminSearchDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public JuminSearchDto(String mName, String mJumin1, String mJumin2, String appCk) {
		super();
		this.mName = mName;
		this.mJumin1 = mJumin1;
		this.mJumin2 = mJumin2;
		this.appCk = appCk;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmJumin1() {
		return mJumin1;
	}

	public void setmJumin1(String mJumin1) {
		this.mJumin1 = mJumin1;
	}

	public String getmJumin2() {
		return mJumin2;
	}

	public void setmJumin2(String mJumin2) {
		this.mJumin2 = mJumin2;
	}

	public String getAppCk() {
		return appCk;
	}

	public void setAppCk(String appCk) {
		this.appCk = appCk;
	}
	
	
	
}
