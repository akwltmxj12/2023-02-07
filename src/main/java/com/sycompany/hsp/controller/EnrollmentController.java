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

import com.sycompany.hsp.dao.EnrollmentIDao;
import com.sycompany.hsp.dao.IDao;
import com.sycompany.hsp.dao.SearchIDao;
import com.sycompany.hsp.dto.AppointmentInfoDto;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.JuminSearchDto;

@Controller
public class EnrollmentController {

	@Autowired
	private SqlSession sqlSession;
	

	// 예방접종등록
	@RequestMapping("/enrollment")
	public String enrollment(HttpSession session, Model model) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		
		EnrollmentIDao nr = sqlSession.getMapper(EnrollmentIDao.class);
		
		// 로그인한 병원 정보가져오기
		HspInfoDto hspInfoDto = nr.getHspInfo(sessionId);
		String hspVaccin = hspInfoDto.getHspVaccineCk();
		String hspVaccins[] = hspVaccin.split("> ");
		
		//로그인한 병원 정보 뷰에 보내기
		model.addAttribute("hspVaccins", hspVaccins);
		
		
		return "enrollment";
	}
	
	// 예방접종 등록하기 전에 예약내역있는지 조회하기
	@PostMapping("/juminSearch")
	public String juminSearch(HttpServletRequest request, Model model, HttpSession session, HttpServletResponse response) {
		
		String sessionId = session.getAttribute("hspId").toString();
		
		EnrollmentIDao nr = sqlSession.getMapper(EnrollmentIDao.class);
		
		HspInfoDto hspInfoDto = nr.getHspInfo(sessionId);
		String hspVaccin = hspInfoDto.getHspVaccineCk();
		String hspVaccins[] = hspVaccin.split("> ");
		model.addAttribute("hspVaccins", hspVaccins); // 백신목록 불러오기
		
		Date date = new Date();
		String today = String.format("%1$tY-%1$tm-%1$td", date);
		
		String mName = request.getParameter("mName").toString();
		String mJumin1 = request.getParameter("mJumin1").toString();
		String mJumin2 = request.getParameter("mJumin2").toString();

		
		
		if(mName != null && mJumin1 != null && mJumin2 != null) {
		
			int appSearchRs = nr.getAppInfo(mName, mJumin1, mJumin2);
			List<AppointmentInfoDto> appList = nr.setAppInfo(today);
		
			if(appSearchRs == 0) {
				JuminSearchDto rs = new JuminSearchDto(mName, mJumin1, mJumin2, "없음");
				model.addAttribute("rs",rs);
				model.addAttribute("mrs",rs);
				model.addAttribute("appList",creatApp(sessionId,appList)); //예약일마다 백신 건수
					return "enrollment";

			} else {
				JuminSearchDto rs = new JuminSearchDto(mName, mJumin1, mJumin2, "있음");
				model.addAttribute("rs",rs);
				model.addAttribute("appList",creatApp(sessionId,appList)); //예약일마다 백신 건수
					return "enrollment";
			}
		} else {
			PrintWriter out;
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('에러가 발생되었습니다. 다시 시도하세요.'); location.href='/enrollment'; </script>");
				out.flush();
				return "redirect:enrollment";
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return "enrollment";
	}
	
	// 예방접종등록하기
	//@RequestMapping("/appInfo")
	@PostMapping("/appInfo")
	public String appInto(HttpServletRequest request, Model model, HttpServletResponse response) {
		
		//파라미터에서 반드시 가져와야 하는 값
		String mName = request.getParameter("mName").toString();
		String mJumin1 = request.getParameter("mJumin1");
		String mJumin2 = request.getParameter("mJumin2");
		String tel1 = request.getParameter("tel1").toString();
		String tel2 = request.getParameter("tel2").toString();
		String tel3 = request.getParameter("tel3").toString();
		String mtel = tel1 + tel2 + tel3; //임의로 설정해줘야 하는 값
		String appTime = request.getParameter("appTime").toString();
		String rsTxt = request.getParameter("rsTxt").toString();
		String injecNum = request.getParameter("injecNum").toString();
		String vaccineName = request.getParameter("vaccineName").toString();
		String appDate = request.getParameter("appDate").toString();
		String appmemo = request.getParameter("memo").toString();
		
		//임의로 넣어줘야 하는 더미데이터
		String appRoute = "해당기관등록"; // 예약경로
		String lastInjecDate = "2021-12-30";  //마지막 접종일
		String lastInjecName = "인플루엔자(독감)"; //마지막 접종명
		String lastInjec = "매년"; // 마지막 접종 차수
		String sideEffect = "없음"; // 마지막 접종 후 부작용
		String appCk = "확인완료"; // 예약확인
			
		EnrollmentIDao nr = sqlSession.getMapper(EnrollmentIDao.class);
		
		int setInjectInfoRs= nr.setInjectInfo(
					appDate, appTime, mName, mtel,
					mName, mtel, mJumin1, mJumin2, 
					rsTxt, injecNum, vaccineName, appmemo,
					appRoute, lastInjecDate, lastInjec, sideEffect, 
					lastInjecName, appCk);
			
			PrintWriter out;
			if(setInjectInfoRs == 1) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('등록이 완료되었습니다.'); location.href='/enrollment'; </script>");
					out.flush();
					return "redirect:enrollment";
				}catch(Exception e) {
					e.printStackTrace();
				}
	
			} else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.');history.go(-1);</script>");
					out.flush();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}	
		
		return "redirect:enrollment";
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
