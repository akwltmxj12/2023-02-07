package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;
import com.sycompany.hsp.dto.HspdayappDto;

@Mapper
public interface IDao { // select문만 반환타입있고 나머지, Insert, Update, Delete는 반환타입 없음 or int
		
	// 로그인 후 가입정보 확인(select)
		public HspInfoDto getHspInfo(String hspId);
	
	// 예방접종정보 등록
	public int setInjectInfo(
			String appDate, String appTime, String appName, String appTel,
			String mName, String mTel, String mJumin1, String mJumin2,
			String injecNum, String vaccineName, String appRoute, 
			String appMemo, String lastInjecDate, String lastInjecName, String lastInjec, 
			String sideEffect, String appCk); 
	
	
	// 백신정보조회
	public List<String> getVaccineName(String hspId);
	
	
	// 모든 예약 리스트(select) - 당일날짜 전의 값 조회
	public List<AppointmentInfoDto> allAppInfo(String appDate);
	
}
