package com.sycompany.hsp.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HspInfoDto {

	private String hspId;  //의료기관 아이디
	private String hspPw;  // 의료기관 비밀번호
	private String hspEmail; // 의료기관 이메일
	private String hspName; // 의료기관명
    private String hspKind;  // 의료기관종류(종합병원, 보건소, 의원)
	private String hspAddress; // 의료기관 주소
	private String hspCrntAdd; // 의료기관 상세주소
	private String hspTel;  // 의료기관 전화번호
	private int hspDrNum; // 의료기관 예진의사수
	private int hspNum;  // 의료기관 시간당 접종가능 수
	private String hspLunchSt;  // 점심시간 시작
	private String hspLunchCl; // 점심시간 끝
	private String hspVaccineCk; //취급백신종류 
	private HspdayappDto hspdayapp; // 예약가능시간
	private String rgstDate; // 가입한 날

}
