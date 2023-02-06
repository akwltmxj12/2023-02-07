package com.sycompany.hsp.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sycompany.hsp.dao.IDao;
import com.sycompany.hsp.dao.SearchIDao;
import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;

@Controller
public class SearchController {

	@Autowired
	private SqlSession sqlSession;

		// 예약조회 화면
		@RequestMapping("/search")
		public String search(HttpSession session, Model model) {
			
			String sessionId = session.getAttribute("hspId").toString();
			
			Date date = new Date();
			String today = String.format("%1$tY-%1$tm-%1$td", date);
			
			SearchIDao sc = sqlSession.getMapper(SearchIDao.class);
			
			HspInfoDto hspInfo = sc.getHspInfo(sessionId); // 로그인한 병원 정보 모두가져오기
			 		
			List<AppointmentInfoDto> allApp = sc.allAppInfo(today);
									
			model.addAttribute("allApp", creatApp(sessionId, allApp)); // 병원에서 취급하는 백신 예약만 보이기
			model.addAttribute("hspInfo", hspInfo); // 가입의료기관 정보
			
			return "search";
		}
		
		

		//예약 검색한 결과 출력
		//@RequestMapping("/searchCondition")
		@PostMapping("/searchCondition")
		public String searchCondition(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
			
			String sessionId = session.getAttribute("hspId").toString(); //로그인 중이 아이디
			
			String todate = request.getParameter("todate"); // 예약날짜 조회 마지막날
			String dateApp = request.getParameter("dateApp"); // 예약날짜 조회 마지막날
			String appName = request.getParameter("appName"); // 예약자 이름
			String injectionName = request.getParameter("injectionName"); // 접종자 이름
			String jumin1 = request.getParameter("jumin1"); // 예약자 생년월일
			String jumin2 = request.getParameter("jumin2"); // 예약자 뒷번호
			
			SearchIDao sc = sqlSession.getMapper(SearchIDao.class);
			
			HspInfoDto hspInfoDto = sc.getHspInfo(sessionId); // 로그인한 병원 정보 모두가져오기
			
			PrintWriter out;
			
					
			
			// 예약자명 조회 시 값을 경고문 발송
			if(todate == "" && dateApp  == "" && appName != null && injectionName == "" && jumin1 == "" && jumin2 == "") {				
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('접종자의 주민등록번호를 반드시 기입하셔야 합니다.'); location.href='/search'; </script>");
					out.flush();
					return "redirect:search";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			//주민번호만 조회 시 경고문 발송
			else if((todate == "" && dateApp  == "" && appName== "" && injectionName == "" && jumin1 != null && jumin2 != null)
					|| (todate == "" && dateApp  == "" && appName== "" && injectionName == "" && jumin1 != null && jumin2 == "")) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('예약자명 또는 피접종자명을 기입하셔야 합니다.'); location.href='/search'; </script>");
					out.flush();
					return "redirect:search";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			//주민번호만 조회 시 경고문 발송
			else if((todate == "" && dateApp  == "" && appName== "" && injectionName == "" && jumin1 == "" && jumin2 != null)) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('피접종자명과 생년월일을 기입하셔야 합니다.'); location.href='/search'; </script>");
					out.flush();
					return "redirect:search";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			
			// 기간 조회
			 else if(todate != null && dateApp != null && appName== "" && injectionName == "" && jumin1 == "" && jumin2 == "") { 
				List<AppointmentInfoDto> dateSearch	= sc.searchDate(todate, dateApp);
				model.addAttribute("allApp", creatApp(sessionId, dateSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			}
			
			// 기간 + 생년월일 조회
			else if(todate != null && dateApp != null && appName== "" && injectionName == "" && jumin1 != null && jumin2 == "") { 
				List<AppointmentInfoDto> dateBirthSearch = sc.searchDateBirth(todate, dateApp, jumin1);
				model.addAttribute("allApp", creatApp(sessionId, dateBirthSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			}
			
			// 접종자명 조회
			else if(todate == "" && dateApp == "" && appName== "" && injectionName != null && jumin1 == "" && jumin2 == "") { 
				List<AppointmentInfoDto> InjecNsearch = sc.searchInjecN(injectionName);
				model.addAttribute("allApp", creatApp(sessionId, InjecNsearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			}
			
			// 접종자명 + 주민번호 조회
			else if(todate == "" && dateApp == "" && appName != null && injectionName == "" && jumin1 != null && jumin2 == "") { 
				List<AppointmentInfoDto> injecNameBrithSearch	= sc.searchInjecNameBrith(injectionName, jumin1);
				model.addAttribute("allApp", creatApp(sessionId, injecNameBrithSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			}
			
			// 예약자명 + 주민번호 조회
			else if(todate == "" && dateApp == "" && appName != null && injectionName == "" && (jumin1 != null && jumin2 != null)) { 
				List<AppointmentInfoDto> nameSearch	= sc.searchAppName(appName, jumin1, jumin2);
				model.addAttribute("allApp", creatApp(sessionId, nameSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			}
						
			
			//접종자명 + 주민번호 조회
			else if(todate == "" && dateApp == "" && appName == "" && injectionName != null && (jumin1 != null && jumin2 != null)) { 
				List<AppointmentInfoDto> injecNameSearch = sc.searchInjecName(injectionName, jumin1, jumin2);
				model.addAttribute("allApp", creatApp(sessionId, injecNameSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
				
			}
			// 날짜 + 예약자명 + 주민번호 조회 
			else if(todate != null && dateApp != null && appName != null && injectionName == "" && (jumin1 != null && jumin2 != null)) { 
				List<AppointmentInfoDto> appNameDateSearch = sc.searchAppDateName(todate, dateApp, appName, jumin1, jumin2);
				model.addAttribute("allApp", creatApp(sessionId, appNameDateSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
				
			}
			// 날짜 + 접종자명 + 주민번호 조회
			else if(todate != null && dateApp != null && appName == "" && injectionName != null && (jumin1 != null && jumin2 != null)) { 
				List<AppointmentInfoDto> injecNameDateSearch = sc.searchDateInjecName(todate, dateApp, injectionName, jumin1, jumin2);
				model.addAttribute("allApp", creatApp(sessionId, injecNameDateSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
				
			}
			// 날짜 + 접종자명 + 예약자명 + 주민번호 조회
			else if(todate != null && dateApp != null && appName != null && injectionName != null && (jumin1 != null && jumin2 != null)) { 
				List<AppointmentInfoDto> allSearch = sc.searchAppDateInjecName(todate, dateApp, appName, injectionName, jumin1, jumin2);
				model.addAttribute("allApp", creatApp(sessionId, allSearch));
				model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
			} 
			
			
			
			else if(todate == "" && dateApp  == "" && appName== "" && injectionName == "" && jumin1 == "" && jumin2 == "") {
				return "redirect:search";
				
				} 
			
			else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/search'; </script>");
					out.flush();
					return "redirect:search";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return "search";
		}
		
		
		
		//예약취소
		@PostMapping("/searchDelete")
		public String searchDelete(HttpServletRequest request, Model model, HttpServletResponse response, HttpSession session) {
			
			String sessionId = session.getAttribute("hspId").toString(); //로그인 중인 아이디
			
			//오늘 날짜
			Date date = new Date();
			String today = String.format("%1$tY-%1$tm-%1$td", date);
			
			//예약삭제 파라미터
			String mName = request.getParameter("mName").toString();
			String mJumin = request.getParameter("mJumin").toString();
			String mJumins[] = mJumin.split("-",2);
			String mJumin1 = mJumins[0]; //생년월일
			String mJumin2 = mJumins[1]; //주민번호 뒷자리
			
			SearchIDao sc = sqlSession.getMapper(SearchIDao.class);
			
			//삭제쿼리실행
			int Delete = sc.appDelete(mName, mJumin1, mJumin2);
			PrintWriter out;
			if(Delete > 0) {
					try {
						response.setContentType("text/html;charset=utf-8");
						out = response.getWriter();
						out.println("<script>alert('예약이 취소 되었습니다.'); location.href='/search'; </script>");
						out.flush();
						return "redirect:search";
					}catch(Exception e) {
						e.printStackTrace();
					}
			}
			
			List<AppointmentInfoDto> allApp = sc.allAppInfo(today);
			
			model.addAttribute("allApp", creatApp(sessionId, allApp)); //모든 예약 정보 불러오기
			
			return "redirect:search";
		}
		
		//예약확인 후 확정
		//@RequestMapping("/appOk")
		@PostMapping("/appOk")
		public String appOk(HttpServletRequest request, Model model, HttpServletResponse response) {
			
						
			String mName = request.getParameter("mNameClick").toString();
			String mJumin = request.getParameter("mJuminClick").toString();
			String mJumins[] = mJumin.split("-");
			String mJumin1 = mJumins[0]; //생년월일
			String mJumin2 = mJumins[1]; //주민번호 뒷자리
			
			SearchIDao sc = sqlSession.getMapper(SearchIDao.class);
			String appCk = "확인완료";
			
			int CheckOk = sc.appCheckOk(mName, mJumin1, mJumin2, appCk);
			PrintWriter out;
			if(CheckOk > 0) {
					try {
						response.setContentType("text/html;charset=utf-8");
						out = response.getWriter();
						out.println("<script>alert('예약이 확인 되었습니다.'); location.href='/search'; </script>");
						out.flush();
						return "redirect:search";
					}catch(Exception e) {
						e.printStackTrace();
					}
			}
			
			
			return "redirect:search";
		}
		
		
		
		private List<AppointmentInfoDto> creatApp(String sessionId, List<AppointmentInfoDto> allApp) {
			
			SearchIDao sc = sqlSession.getMapper(SearchIDao.class);
			
			HspInfoDto hspInfo = sc.getHspInfo(sessionId); // 로그인한 병원 정보 모두가져오기
			String hspKinds = hspInfo.getHspVaccineCk();
	 		String hspKind[] = hspKinds.split("> "); // 취급백신 배열로 만들기
			
			List<AppointmentInfoDto> handleApp = new ArrayList<>(); //빈 리스트 만들기
			
			String firstVaccineName = "";
			String stockVaccineName ="";
			for(int i=0; i<allApp.size(); i++) {
				firstVaccineName = allApp.get(i).getVaccineName().toString();
				
				for(int j=0; j<hspKind.length; j++) {
					stockVaccineName = hspKind[j];
					if(firstVaccineName.contains(stockVaccineName)) {
						handleApp.add(allApp.get(i));
						break;
					}else {
					
					}
				}
			}
			
			
			return handleApp;
			
		}
	
}
