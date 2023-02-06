package com.sycompany.hsp.controller;

import java.io.PrintWriter;
import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sycompany.hsp.dao.IDao;
import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;
import com.sycompany.hsp.dto.HspdayappDto;

import oracle.security.crypto.core.Padding.ID;

@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
		

	
	@RequestMapping("/test")
	public String test() {
		
		return "test";
	}
	
	
	@RequestMapping("/btn1")
	
	public String btn1() { // 12월 데이터
		
		//예약일
		//12월
		List<String> date = Arrays.asList(
					"2022-12-01", "2022-12-02", "2022-12-05", "2022-12-06", "2022-12-07", "2022-12-08", 
					"2022-12-09", "2022-12-12", "2022-12-13", "2022-12-14", "2022-12-15", "2022-12-16", 
					"2022-12-19", "2022-12-20", "2022-12-21", "2022-12-22", "2022-12-23", "2022-12-26", 
					"2022-12-27");
		
		String appCheck = "확인완료";
			
		creatDate(appCheck, date);
		
		return "redirect:test";
	}
	
	
	@RequestMapping("/btn2")
	public String btn2() { // 1월 더미데이터
			
		//예약일
		//1월
		List<String> date = Arrays.asList(
					"2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05", "2023-01-06", "2023-01-09",
					"2023-01-10", "2023-01-11", "2023-01-12", "2023-01-13", "2023-01-16", "2023-01-17",
					"2023-01-18", "2023-01-19", "2023-01-20", "2023-01-26", "2023-01-27");
			
			String appCheck = "확인완료";
			
			creatDate(appCheck, date);

		return "redirect:test";
	}
	
	
	@RequestMapping("/btn3")
	public String btn3() {//2월 더미데이터
		
		//예약일
		//2월
		List<String> date = Arrays.asList(
				"2023-02-01", "2023-02-02", "2023-02-03", "2023-02-06", "2023-02-07", "2023-02-08", 
				"2023-02-09", "2023-02-10", "2023-02-13", "2023-02-14", "2023-02-15", "2023-02-16", 
				"2023-02-17", "2023-02-20", "2023-02-21", "2023-02-22", "2023-02-23", "2023-02-24",	
				"2023-02-27");
		
		String appCheck = "미확인";
			 
		creatDate(appCheck, date);
		
		return "redirect:test";
	}
	

	@RequestMapping("/btn4")
	public String btn4() { // 1~2월 더미데이터(독감만)
		
		//예약일
		//2월
		List<String> date = Arrays.asList(
				"2023-01-17","2023-01-18", "2023-01-19", "2023-01-20", "2023-01-26", "2023-01-27",
				"2023-02-01", "2023-02-02", "2023-02-03", "2023-02-06", "2023-02-07", "2023-02-08", 
				"2023-02-09", "2023-02-10", "2023-02-13", "2023-02-14", "2023-02-15", "2023-02-16", 
				"2023-02-17", "2023-02-20", "2023-02-21", "2023-02-22", "2023-02-23", "2023-02-24",	
				"2023-02-27");
		
		List<String> appCk = Arrays.asList("미확인","확인완료");
		Collections.shuffle(appCk);
		String appCheck = appCk.get(0);
			 
		creatVaccine(appCheck, date);
		
		return "redirect:test";
	}	
	


	@RequestMapping("/test2")
	//@PostMapping("/test2")
	public String test2(Model model, HttpSession session) {
		
	
		
		return "test2";
	}

	
	
//--------------------------------------------------------------------------------------------------------------------	
	
	private void creatVaccine(String appCheck, List<String> date) { //더미데이터 만들기 ver2
		
		String appDate;     // 예약일
		String appTime;     // 예약시간
		String appName;   // 예약자 이름 
		String appTel;       // 예약자 전화번호
		String mName;   // 피접종자이름
		String mTel = null;          // 피접종자 전화번호
		String mJumin1;    // 피접종자 생년월일
		String mJumin2;    // 피접종자 주민번호 뒷자리
		String injecNum;      //예약 백신 접종 차수
		String vaccineName;   // 접종받을 백신 이름
		String appRoute;      // 접종예약 경로(해당 의료기관, 모바일, PC)
		String appMemo;       // 접종 예약 시 메모사항
		String lastInjecDate;  // 최근 접종일(= 마지막 접종일)
		String lastInjecName;  // 최근접종명: 마지막으로 받은 접종명
		String lastInjec;      // 최근접종 차수: 1차 또는 매년(인플루엔자만) 접종일자 필요, 없으면 처음이라고 작성
		String sideEffect;   // 이전 접종 시 부작용: 피접종자의 예전 부작용 사례 또는 현재 발생한 부작용 증상
		String appCk;    // 예약확인
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		for(int i=0 ; i<100; i++) {
			//예약일
			Collections.shuffle(date);
			appDate = date.get(0);
			
			// 예약시간
			List<String> time = Arrays.asList("오전09시", "오전10시", "오전11시", "오후12시", "오후1시", "오후2시", "오후3시", "오후4시");
			
			Collections.shuffle(time);
			appTime = time.get(0);
			
			// 예약자명
			List<String> firstName = Arrays.asList("김", "이", "박", "최", "정", "강", "조", "윤", "장", "임", "한", "오", "서", "신", "권", "황", "안",
				        "송", "류", "전", "홍", "고", "문", "배", "조", "유", "남", "심", "정", "하", "성", "주",
				        "우", "구", "신", "임", "나", "전", "민", "원", "공", "강", "도", "신", "마", "표", "구");
		    List<String> lastName = Arrays.asList("가", "강", "건", "경", "고", "광", "구", "규", "근", "기", "길", "나", "남", "노", "누", "다",
			        "달", "담", "대", "덕", "도", "동","라", "로", "마", "명", "무", "문", "미", "민", "바", 
			        "백","별", "보", "사", "산", "상", "새", "서", "석", "선", "설", "성", "세", "솔", "수", "숙", "순",
			        "숭", "슬", "승", "시", "신", "아", "안", "애", "여", "연", "영", "예", "오", "옥", "완", "요", "용", "우", "원", "월", 
			        "유", "윤", "율", "은", "이", "익", "인", "일", "자",  "재", "전", "정", "제", "조", "종", "주", "준",
			        "중", "지", "진", "찬", "창", "채", "천", "철", "초", "태", "택", "하", "한", "해", "현", 
			        "호", "홍", "화", "환", "회", "효", "훈",  "운", "모", "황", "비", "균", "묵", "송", "욱", "휴");
				  
		    		Collections.shuffle(firstName);
				    Collections.shuffle(lastName);
			 mName = firstName.get(0) + lastName.get(0) + lastName.get(1);
			 
			 
			 // 예약자 전화번호
			 List<String> tel = Arrays.asList("1","2","3","4","5","6","7","8","9","0");
			 Collections.shuffle(tel);
			 String ttel = "";
			 for(int h=0; h<8; h++ ) {
				 ttel = ttel + tel.get(h);
			 }
			 mTel = "010" + ttel;
			 
			 
			 // 접종자 생년월일
			 int minNum = 10;
			 int maxNum = 99;

			 int ranYear = new Random().nextInt((maxNum - minNum) + 1) + minNum;
			 int mYear = 0;
			
				for(int ii=22; ii<56; ii++ ) {
					if(ii == ranYear) {
						continue;
					}
					else {
						mYear= ranYear;
						break;
					}
				}
				
				String year = Integer.toString(mYear);
				List<String> month = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12");
				List<String> day = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28");
				Collections.shuffle(month);
				Collections.shuffle(day);
			 
			 mJumin1 = year + month.get(0) + day.get(0);
			 
			 //주민 뒷자리
			 String temp = "";
			 String sum = "";
			 
			 Random random = new Random();
			 
				for (int j = 0; j < 7; j++) {
					temp = Integer.toString(random.nextInt((9-1)+1)+1);
					sum = sum + temp;
				}
			 
			 mJumin2 = sum;
				
				
			 // 접종차수
			 List<String> num = Arrays.asList("매년");
			 Collections.shuffle(num);
					 
			 injecNum = num.get(0);
			 
			 //접종 받는 백신이름
			 vaccineName = "인플루엔자(독감)";
			 
			 
			 // 예약방법
			 List<String> route = Arrays.asList("모바일","PC");
			 appRoute = route.get(0);
			 
			//최근 접종일
			List<String> lastDay = Arrays.asList("2021-12-02", "2021-12-06", "2021-12-07",
											 "2021-12-13", "2021-12-14", "2021-12-15",
											 "2021-12-17", "2021-12-20", "2021-12-27");
			Collections.shuffle(lastDay);
			lastInjecDate = lastDay.get(0);
			 
			 //마지막 접종 백신명
			 lastInjecName = "인플루엔자(독감)";
			 
			 
			 //접종차수
			 lastInjec="매년";
			 
			 
			 // 부작용
			 sideEffect = "없음";
			 
			 
			 //확인
			 appCk = appCheck;
			 
			 //메모
			 appMemo = "";
			
			
			 dao.setInjectInfo(appDate, appTime, mName, mTel, 
					 			mName, mTel, mJumin1, mJumin2, 
					 			injecNum, vaccineName, appRoute, 
					 			appMemo, lastInjecDate, lastInjecName, lastInjec, 
					 			sideEffect, appCk);
		}
	}
	
//-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-	
	private void creatDate(String appCheck, List<String> date) { //더미데이터 만들기 ver1
		
		String appDate;     // 예약일
		String appTime;     // 예약시간
		String appName;   // 예약자 이름 
		String appTel;       // 예약자 전화번호
		String mName;   // 피접종자이름
		String mTel = null;          // 피접종자 전화번호
		String mJumin1;    // 피접종자 생년월일
		String mJumin2;    // 피접종자 주민번호 뒷자리
		String injecNum;      //예약 백신 접종 차수
		String vaccineName;   // 접종받을 백신 이름
		String appRoute;      // 접종예약 경로(해당 의료기관, 모바일, PC)
		String appMemo;       // 접종 예약 시 메모사항
		String lastInjecDate;  // 최근 접종일(= 마지막 접종일)
		String lastInjecName;  // 최근접종명: 마지막으로 받은 접종명
		String lastInjec;      // 최근접종 차수: 1차 또는 매년(인플루엔자만) 접종일자 필요, 없으면 처음이라고 작성
		String sideEffect;   // 이전 접종 시 부작용: 피접종자의 예전 부작용 사례 또는 현재 발생한 부작용 증상
		String appCk;    // 예약확인
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		for(int i=0 ; i<100; i++) {
			//예약일
			Collections.shuffle(date);
			appDate = date.get(0);
			
			// 예약시간
			List<String> time = Arrays.asList("오전09시", "오전10시", "오전11시", "오후12시", "오후1시", "오후2시", "오후3시", "오후4시");
			
			Collections.shuffle(time);
			appTime = time.get(0);
			
			// 예약자명
			List<String> firstName = Arrays.asList("김", "이", "박", "최", "정", "강", "조", "윤", "장", "임", "한", "오", "서", "신", "권", "황", "안",
			        "송", "류", "전", "홍", "고", "문", "배", "조", "유", "남", "심", "정", "하", "성", "주",
			        "우", "구", "신", "임", "나", "전", "민", "원", "공", "강", "도", "신", "마", "표", "구");
		    List<String> lastName = Arrays.asList("가", "강", "건", "경", "고", "광", "구", "규", "근", "기", "길", "나", "남", "노", "누", "다",
				        "달", "담", "대", "덕", "도", "동","라", "로", "마", "명", "무", "문", "미", "민", "바", 
				        "백","별", "보", "사", "산", "상", "새", "서", "석", "선", "설", "성", "세", "솔", "수", "숙", "순",
				        "숭", "슬", "승", "시", "신", "아", "안", "애", "여", "연", "영", "예", "오", "옥", "완", "요", "용", "우", "원", "월", 
				        "유", "윤", "율", "은", "이", "익", "인", "일", "자",  "재", "전", "정", "제", "조", "종", "주", "준",
				        "중", "지", "진", "찬", "창", "채", "천", "철", "초", "태", "택", "하", "한", "해", "현", 
				        "호", "홍", "화", "환", "회", "효", "훈",  "운", "모", "황", "비", "균", "묵", "송", "욱", "휴");
				  
		    		Collections.shuffle(firstName);
				    Collections.shuffle(lastName);
			 mName = firstName.get(0) + lastName.get(0) + lastName.get(1);
			 
			 
			 // 예약자 전화번호
			 List<String> tel = Arrays.asList("1","2","3","4","5","6","7","8","9","0");
			 Collections.shuffle(tel);
			 
			 String ttel = "";
			 for(int h=0; h<8; h++ ) {
				 ttel = ttel + tel.get(h);
			 }
			 mTel = "010" + ttel;
			 
			 
			 // 접종자 생년월일
			 int minNum = 10;
			 int maxNum = 99;

			 int ranYear = new Random().nextInt((maxNum - minNum) + 1) + minNum;
			 int mYear = 0;
			
				for(int ii=22; ii<56; ii++ ) {
					if(ii == ranYear) {
						continue;
					}
					else {
						mYear= ranYear;
						break;
					}
				}
				
				String year = Integer.toString(mYear);
				List<String> month = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12");
				List<String> day = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28");
				Collections.shuffle(month);
				Collections.shuffle(day);
			 
			 mJumin1 = year + month.get(0) + day.get(0);
			 
			 //주민 뒷자리
			 String temp = "";
			 String sum = "";
			 
			 Random random = new Random();
			 
				for (int j = 0; j < 7; j++) {
					temp = Integer.toString(random.nextInt((9-1)+1)+1);
					sum = sum + temp;
				}
			 
			 mJumin2 = sum;
				
				
			 // 접종차수
			 List<String> num = Arrays.asList("1차", "2차");
			 Collections.shuffle(num);
					 
			 injecNum = num.get(0);
			 
			 //접종 받는 백신이름
			 List<String> vaccine = Arrays.asList(
											 "결핵(BCG, 피내용)",
											 "B형간염(HepB)",
											 "디프테리아/파상풍/백일해(DTaP)",
											 "디프테리아/파상풍/백일해/폴리오(DTaP-IPV)",
											 "디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)",
											 "디프테리아/파상풍/백일해(TdaP)",
											 "파상풍/디프테리아(Td)",
											 "폴리오(IPV)",
											 "b형헤모필루스인플루엔자",
											 "폐렴구균(PCV 10가)",
											 "폐렴구균(PCV 13가)",
											 "폐렴구균(PCV 23가)",
											 "홍역/유행성이하선염/풍진(MMR)",
											 "A형간염(HepA)");
			 Collections.shuffle(vaccine);
			 vaccineName = vaccine.get(0);
			 
			 
			// 예약방법
			List<String> route = Arrays.asList("모바일","PC");
			Collections.shuffle(route);
			appRoute = route.get(0);
			 
			//최근 접종일
			List<String> lastDay = Arrays.asList("2021-12-02", "2021-12-06", "2021-12-07",
											 "2021-12-13", "2021-12-14", "2021-12-15",
											 "2021-12-17", "2021-12-20", "2021-12-27");
			Collections.shuffle(lastDay);
			lastInjecDate = lastDay.get(0);
			 
			 //마지막 접종 백신명
			 lastInjecName ="인플루엔자(독감)";
			 
			 
			 //접종차수
			 lastInjec="매년";
			 
			 
			 // 부작용
			 sideEffect = "없음";
			 
			 
			 //확인
			 appCk = appCheck;
			 
			 //메모
			 appMemo = "";
			
			
			 dao.setInjectInfo(appDate, appTime, mName, mTel, 
					 			mName, mTel, mJumin1, mJumin2, 
					 			injecNum, vaccineName, appRoute, 
					 			appMemo, lastInjecDate, lastInjecName, lastInjec, 
					 			sideEffect, appCk);
		}
	}
	
//-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-ㅁ-		
	private List<AppointmentInfoDto> creatApp(String sessionId, List<AppointmentInfoDto> allApp) {//당일예약건수 출력
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		HspInfoDto hspInfo = dao.getHspInfo(sessionId); //의료기관 모든 정보
		String hspKinds = hspInfo.getHspVaccineCk();
 		String hspKind[] = hspKinds.split("> ");
		
		List<AppointmentInfoDto> combo = new ArrayList<>();
		
		String aName = "";
		String bName ="";
		for(int i=0; i<allApp.size(); i++) {
			aName = allApp.get(i).getVaccineName().toString();
			
			for(int j=0; j<hspKind.length; j++) {
				bName = hspKind[j];
				if(aName.contains(bName)) {
					combo.add(allApp.get(i));
					break;
				}else {
				
				}
			}
		}
		return combo;
		
	}
	
}
