package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;

@Mapper
public interface CheckIDao { // 예방접종 후 부작용 확인

	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
	
	// 모든 예약 리스트(select) - 당일날짜 후의 값 조회
	public List<AppointmentInfoDto> allAppInfo(String appDate, String rgstDate);
	
	// 부작용 작성
	public int setSideEffect(String mName, String mJumin1, String mJumin2, String vaccineName, String sideEffect);

	//조회조건
	//1.날짜
	public List<AppointmentInfoDto> dateCheckInfo(String appDate1, String appDate2, String rgstDate);
	
	//2.날짜 + 시간
	public List<AppointmentInfoDto> timeCheckInfo(String appDate1, String appDate2, String appTime1, String appTime2, String rgstDate);
	
	//3.날짜 + 이름
	public List<AppointmentInfoDto> nameCheckInfo(String appDate1, String appDate2, String mName, String rgstDate);
	
	//4.날짜 + 이름 + 생년월일 조회
	public List<AppointmentInfoDto> birthdayCheckInfo(String appDate1, String appDate2, String mJumin1, String rgstDate);
		
	
	//5.날짜 + 이름 + 생년월일 조회
	public List<AppointmentInfoDto> birthNameCheckInfo(String appDate1, String appDate2, String mName, String mJumin1, String rgstDate);
	
	
	//6.날짜 + 시간 + 이름 + 주민번호 조회
	public List<AppointmentInfoDto> checkInfo(
								String appDate1, String appDate2,
								String mName, String mJumin1, String mJumin2, String rgstDate);
		
	
	//날짜 + 시간 + 이름 + 주민번호
	public List<AppointmentInfoDto> allCheckInfo(
							String appDate1, String appDate2,
							String appTime1, String appTime2,
							String mName, String mJumin1, String mJumin2, String rgstDate);
	
	
	
	
	
	
}
