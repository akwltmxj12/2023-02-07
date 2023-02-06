package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;

@Mapper
public interface MainIDao { // select문만 반환타입있고 나머지, Insert, Update, Delete는 반환타입 없음 or int

		// 로그인 시 가입여부 확인(select)
		public int checkIdAndPW(String hspId, String hspPw);

		// 로그인 후 가입정보 확인(select)
		public HspInfoDto getHspInfo(String hspId);
		
		// 예약 건수
		public int getAppCount(String appDate);
		
		//예약확인
		public List<AppointmentInfoDto> getAppCheck(String appCk, String appDate);
		
		// 의료기관이 가진 모든 백신 가져오기
		public List<Hsp_vaccineInfoDto> getHspVaccineAllStock(String hspId);
}
