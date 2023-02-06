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
import org.springframework.web.bind.annotation.RequestMethod;

import com.sycompany.hsp.dao.IDao;
import com.sycompany.hsp.dao.MainIDao;
import com.sycompany.hsp.dao.SearchIDao;
import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;

@Controller
public class LoginController {

	@Autowired
	private SqlSession sqlSession;

	
	// 로그인 화면
	@RequestMapping("/")
	public String root() {
		return "login";
	}

	
	// 로그인 화면
	@RequestMapping("/login")
	public String login() {
		
		return "login";
	}
	
	// 로그인 버튼 클릭 시 작동
	//@RequestMapping("/loginOk")
	@PostMapping("/loginOk")
	public String loginOk(HttpServletRequest request, Model model, HttpServletResponse response, HttpSession session) {
		
		MainIDao main = sqlSession.getMapper(MainIDao.class); 
		
		String hspId = request.getParameter("hspId");
		String hspPw = request.getParameter("hspPw");
		
		// 아이디와 비밀번호 일치 확인
		int checkIdPwFlag = main.checkIdAndPW(hspId, hspPw);
		
		PrintWriter out;
		
		if(checkIdPwFlag == 0) { // 없는 아이디		 		
			
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('아이디 또는 비밀번호가 다릅니다.');</script>");
				out.flush();
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return "login";
			
		} else { // 있는 아이디
			
			session.setAttribute("hspId", hspId); // 로그인 한 세션에 아이디
			
			Long loginTime = System.currentTimeMillis()/1000;//현재시간(밀리세컨드) 추출해서 / 1000 
	        session.setAttribute("loginTime", loginTime);
	        
			String sessionId = session.getAttribute("hspId").toString();
			HspInfoDto hspInfoDto = main.getHspInfo(sessionId);
			model.addAttribute("hspInfo", hspInfoDto);
			
			return "redirect:main";
		}
	}
	
	
	
		
	// 로그인 후 메인 화면
	@RequestMapping("/main")
	public String main(HttpSession session, Model model) {
		
		String sessionId = session.getAttribute("hspId").toString();
						
		MainIDao main = sqlSession.getMapper(MainIDao.class);
		
		HspInfoDto hspInfoDto = main.getHspInfo(sessionId);
		
		model.addAttribute("hspInfo", hspInfoDto); // 가입의료기관 정보
		
		Date date = new Date();
		String today = String.format("%1$tY-%1$tm-%1$td", date);
		int todayVaccine = main.getAppCount(today);
		model.addAttribute("todayVaccine", todayVaccine); // 오늘 예방접종예약건수
		
		List<AppointmentInfoDto> appCheck = main.getAppCheck("미확인", today); // 예약한 건수 불러오기
		List<Hsp_vaccineInfoDto> VaccineStock = main.getHspVaccineAllStock(sessionId); // 백신정보 모두 불러오기
		
		int appCheckCount= creatApp(sessionId, appCheck).size();
		
		model.addAttribute("appCheck", appCheckCount); // 확인이 필요한 예약건수
		model.addAttribute("VaccineStock", VaccineStock); // 백신 조회
		
		return "main";
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:login";
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
