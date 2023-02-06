package com.sycompany.hsp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Hsp_vaccineInfoDto {

	private String hspId;  // 의료기관 아이디
	private String vaccineName;   // 백신이름
	private String vaccineCompany;   // 백신 제조사
	private String vaccineRcvDay;  // 백신 입고일
	private String vaccineDscDay;  // 백신 폐기일
	private int vaccineHold;   // 백신보유량
	private int vaccineUse;    // 당일 백신 사용예정량

	private int cnt; // 백신보유량 - 당일 사용량 = 남은 재고
	
}
