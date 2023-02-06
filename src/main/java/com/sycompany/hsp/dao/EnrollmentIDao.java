package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;

@Mapper
public interface EnrollmentIDao {

	
	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
	
	// 예방접종정보 등록
	public int setInjectInfo(
			String appDate, String appTime, String appName, String appTel,
			String mName, String mTel, String mJumin1, String mJumin2, 
			String rsTxt, String injecNum, String vaccineName, String appMemo,
			String appRoute, String lastInjecDate, String lastInjec, String sideEffect, 
			String lastInjecName, String appCk); 
	
	// 예약일날 사용 백신명 리스트(select)
	public List<AppointmentInfoDto> setAppInfo(String today);	
	
	// 예방접종예약자의 정보조회
	public int getAppInfo(String mName, String mJumin1, String mJumin2);

}
