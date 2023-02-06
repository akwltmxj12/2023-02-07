package com.sycompany.hsp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;

@Mapper
public interface VaccineIDao { // select문만 반환타입있고 나머지, Insert, Update, Delete는 반환타입 없음 or int

	// 로그인 후 가입정보 확인(select)
	public HspInfoDto getHspInfo(String hspId);
	
	// 백신 입고량 입력
	public int hspVaccineHold(String hspId,  String vaccineName, String vaccineCompany, String vaccineRcvDay, String vaccineDscDay, int vaccineHold);
	
	// 의료기관이 가진 모든 백신 가져오기
	public List<Hsp_vaccineInfoDto> getHspVaccineAllStock(String hspId);
	
	
	// 원하는 백신만 조회
	public List<Hsp_vaccineInfoDto> vaccineStockSearch(String hspId, String vaccineName);
	
	
	// 조회없이 입고날짜 순 나열
	public List<Hsp_vaccineInfoDto> vaccineStockDESC(String hspId);
	
	// 조회없이 폐기날짜 순 나열
	public List<Hsp_vaccineInfoDto> vaccineStockASC(String hspId); 
	
	// 입고날짜 순 나열
	public List<Hsp_vaccineInfoDto> vaccineStockRangeDESC(String hspId, String vaccineName); 
	
	// 폐기날짜 순 나열
	public List<Hsp_vaccineInfoDto> vaccineStockRangeASC(String hspId, String vaccineName); 
		
	
	// 백신 정보 수정하기
	public int vaccineInfoChange(String vaccineCompany1, 
								 String vaccineRcvDay1, String vaccineDscDay1,
								 int vaccineHold1, int vaccineUse1,
								 String hspId, 
								 String vaccineName, String vaccineCompany2, 
								 String vaccineRcvDay2, String vaccineDscDay2,
								 int vaccineHold2);
	
	// 백신 정보 삭제하기
	public int vaccineInfoDelete(
								 String hspId, 
								 String vaccineName, String vaccineCompany, 
								 String vaccineRcvDay, String vaccineDscDay,
								 int vaccineHold);
	
	
	
}
