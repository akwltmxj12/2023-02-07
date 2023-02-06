package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;

@Mapper
public interface SearchIDao {
	
	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
	
	// 모든 예약 리스트(select) - 당일날짜 후의 값 조회
	public List<AppointmentInfoDto> allAppInfo(String appDate);	
	
	//예약취소
	public int appDelete(String mName, String mJumin1, String mJumin2);
	
	//예약확인 후 확정
	public int appCheckOk(String mName, String mJumin1, String mJumin2, String appCk);

	
	//검색기능 시작
	//검색기능 구현하기(날짜 조회)
	public List<AppointmentInfoDto> searchDate(String startDate, String lastDate);
	
	//검색기능 날짜 + 생년월일
	public List<AppointmentInfoDto> searchDateBirth(String todate, String dateApp, String jumin1);
	
	//검색기능 접종자명
	public List<AppointmentInfoDto> searchInjecN(String injectionName);
	
	//검색기능 예약자명 + 생년월일
	public List<AppointmentInfoDto> searchInjecNameBrith(String injectionName, String jumin1);
	
	//검색기능 예약자명 + 주민번호
	public List<AppointmentInfoDto> searchAppName(String appName, String jumin1,  String jumin2);
	
	//검색기능 피접종자 + 주민번호
	public List<AppointmentInfoDto> searchInjecName(String injectionName, String jumin1,  String jumin2);
	
	//검색기능 날짜 + 예약자명 + 주민번호
	public List<AppointmentInfoDto> searchAppDateName(String startDate, String lastDate, String appName, String jumin1,  String jumin2);
	
	//검색기능 날짜 + 접종자명 + 주민번호
	public List<AppointmentInfoDto> searchDateInjecName(String startDate, String lastDate, String injectionName, String jumin1,  String jumin2);
	
	//검색기능 날짜 + 예약자명 + 접종자명 + 주민번호
	public List<AppointmentInfoDto> searchAppDateInjecName(String startDate, String lastDate, String appName, String injectionName, String jumin1,  String jumin2);
		
}
