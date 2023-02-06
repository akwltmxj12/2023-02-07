package com.sycompany.hsp.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.HspInfoDto;

@Mapper
public interface JoinIDao {

	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
	
	//가입하려는 아이디 중복체크(select)
	public int idCheck(String hspId);
	
	// 가입 시 운영시간 확인(insert)
	public void setHspDayTime(String hspId, String hspName, 
			String hspStMon, String hspClMon, String hspStTue, String hspClTue,
			String hspStWed, String hspClWed, String hspStThu, String hspClThu,
			String hspStFri, String hspClFri, String hspStSat, String hspClSat,
			String hspStSun, String hspClSun);
	
	// 의료기관 가입 정보 저장(insert)
	public int setHspInfo(
		String hspId, String hspPw, String hspEmail, String hspName, String hspKind, String hspAddress, String hspCrntAdd, 
		String hspTel, int hspDrNum, int hspNum, String hspLunchSt, String hspLunchCl, String hspVaccineCk, String rgstDate);
	

	
}
