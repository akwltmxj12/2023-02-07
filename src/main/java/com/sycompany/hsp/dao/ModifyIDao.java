package com.sycompany.hsp.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.HspdayappDto;

@Mapper
public interface ModifyIDao {
	
	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
			
	//수정하려는 의료기관 운영시간 가져오기
	public HspdayappDto getHspRunTime(String hspId);
	
	// 의료기관 정보 수정
	public int hspInfoModify(String hspId, String hspName, String hspAddress, String hspCrntAdd, 
			String hspTel, int hspDrNum, int hspNum, String hspLunchSt, String hspLunchCl);
	
	//의료기관 예약가능 시간 수정
	public int hspAppTimeModify(String hspId,
			String hspStMon, String hspClMon, String hspStTue, String hspClTue,
			String hspStWed, String hspClWed, String hspStThu, String hspClThu,
			String hspStFri, String hspClFri, String hspStSat, String hspClSat,
			String hspStSun, String hspClSun);
	
	//의료기관 취급백신 수정
	public int hspVaccineModify(String hspId, String hspVaccineCk);
	
	
	
}
