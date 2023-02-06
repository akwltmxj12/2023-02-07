package com.sycompany.hsp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class AppointmentInfoDto {

	private String appDate;     // 예약일
	private String appTime;     // 예약시간
	private String appName;   // 예약자 이름 
	private String appTel;       // 예약자 전화번호
	
	private String mName;   // 피접종자이름
	private String mTel;          // 피접종자 전화번호
	private String mJumin1;    // 피접종자 생년월일
	private String mJumin2;    // 피접종자 주민번호 뒷자리
	private String injecNum;      //예약 백신 접종 차수
	private String vaccineName;   // 접종받을 백신 이름
	private String appRoute;      // 접종예약 경로(해당 의료기관, 모바일, PC)
	private String appMemo;       // 접종 예약 시 메모사항
	
	private String lastInjecDate;  // 최근 접종일(= 마지막 접종일)
	private String lastInjecName;  // 최근접종명: 마지막으로 받은 접종명
	private String lastInjec;      // 최근접종 차수: 1차 또는 매년(인플루엔자만) 접종일자 필요, 없으면 처음이라고 작성
	private String sideEffect;   // 이전 접종 시 부작용: 피접종자의 예전 부작용 사례 또는 현재 발생한 부작용 증상
	private String mSgck;      // 피접종자 특이사항
	private String rsCk;       // 접종가능 결과
	
	private String rsTxt;       //  접종 안될 시 특이사항 작성
	
	private String appCk;    // 예약확인
	
	private int cnt;  // 임의로 만든 접종건수(접종등록 시 사용)

	public AppointmentInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AppointmentInfoDto(String appDate, String appTime, String appName, String appTel, String mName, String mTel,
			String mJumin1, String mJumin2, String injecNum, String vaccineName, String appRoute, String appMemo,
			String lastInjecDate, String lastInjecName, String lastInjec, String sideEffect, String mSgck, String rsCk,
			String rsTxt, String appCk, int cnt) {
		super();
		this.appDate = appDate;
		this.appTime = appTime;
		this.appName = appName;
		this.appTel = appTel;
		this.mName = mName;
		this.mTel = mTel;
		this.mJumin1 = mJumin1;
		this.mJumin2 = mJumin2;
		this.injecNum = injecNum;
		this.vaccineName = vaccineName;
		this.appRoute = appRoute;
		this.appMemo = appMemo;
		this.lastInjecDate = lastInjecDate;
		this.lastInjecName = lastInjecName;
		this.lastInjec = lastInjec;
		this.sideEffect = sideEffect;
		this.mSgck = mSgck;
		this.rsCk = rsCk;
		this.rsTxt = rsTxt;
		this.appCk = appCk;
		this.cnt = cnt;
	}

	public String getAppDate() {
		return appDate;
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}

	public String getAppTime() {
		return appTime;
	}

	public void setAppTime(String appTime) {
		this.appTime = appTime;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppTel() {
		return appTel;
	}

	public void setAppTel(String appTel) {
		this.appTel = appTel;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmTel() {
		return mTel;
	}

	public void setmTel(String mTel) {
		this.mTel = mTel;
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

	public String getInjecNum() {
		return injecNum;
	}

	public void setInjecNum(String injecNum) {
		this.injecNum = injecNum;
	}

	public String getVaccineName() {
		return vaccineName;
	}

	public void setVaccineName(String vaccineName) {
		this.vaccineName = vaccineName;
	}

	public String getAppRoute() {
		return appRoute;
	}

	public void setAppRoute(String appRoute) {
		this.appRoute = appRoute;
	}

	public String getAppMemo() {
		return appMemo;
	}

	public void setAppMemo(String appMemo) {
		this.appMemo = appMemo;
	}

	public String getLastInjecDate() {
		return lastInjecDate;
	}

	public void setLastInjecDate(String lastInjecDate) {
		this.lastInjecDate = lastInjecDate;
	}

	public String getLastInjecName() {
		return lastInjecName;
	}

	public void setLastInjecName(String lastInjecName) {
		this.lastInjecName = lastInjecName;
	}

	public String getLastInjec() {
		return lastInjec;
	}

	public void setLastInjec(String lastInjec) {
		this.lastInjec = lastInjec;
	}

	public String getSideEffect() {
		return sideEffect;
	}

	public void setSideEffect(String sideEffect) {
		this.sideEffect = sideEffect;
	}

	public String getmSgck() {
		return mSgck;
	}

	public void setmSgck(String mSgck) {
		this.mSgck = mSgck;
	}

	public String getRsCk() {
		return rsCk;
	}

	public void setRsCk(String rsCk) {
		this.rsCk = rsCk;
	}

	public String getRsTxt() {
		return rsTxt;
	}

	public void setRsTxt(String rsTxt) {
		this.rsTxt = rsTxt;
	}

	public String getAppCk() {
		return appCk;
	}

	public void setAppCk(String appCk) {
		this.appCk = appCk;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	
	
}
