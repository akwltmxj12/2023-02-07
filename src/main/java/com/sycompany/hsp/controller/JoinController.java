package com.sycompany.hsp.controller;

import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.sycompany.hsp.dao.JoinIDao;

@Controller
public class JoinController {

	@Autowired
	private SqlSession sqlSession;
	
		//가입 화면
		@RequestMapping("/join")
		public String join() {
			
			return "join";
		}
		
		// 아이디 체크
		//@RequestMapping("/checkId")
		@PostMapping("/checkId")
		@ResponseBody
		public int checkId(@RequestParam("hspId") String hspId) {
			
			JoinIDao jn = sqlSession.getMapper(JoinIDao.class);
			int cnt=jn.idCheck(hspId);
				
			return cnt;
		}
		
		
		// 가입정보 확인
		@RequestMapping(value = "/joinInfo", method = RequestMethod.POST)
		public String joinInfo(HttpServletRequest request, Model model) {
			
			String hspId = request.getParameter("hspId");
			String hspPw = request.getParameter("hspPw");
			String hspEmail = request.getParameter("hspEmail");
			
			//다음 페이지에 가입정보를 또 입력해야 해서 값을 미리 날려줌
			model.addAttribute("hspId", hspId);
			model.addAttribute("hspPw", hspPw);
			model.addAttribute("hspEmail",hspEmail);
			
			return "joinInfo";
		}
		
		
		// 가입버튼 클릭 시 작동
		//@RequestMapping("/joinOk")
		@PostMapping("/joinOk")
		public String joinOk(HttpServletRequest request, Model model, HttpServletResponse response) {
			PrintWriter out;
			
			String hspId = request.getParameter("hspId"); //아이디
			String hspPw = request.getParameter("hspPw");//비밀번호
			String hspEmail = request.getParameter("hspEmail"); //이메일
			String hspName = request.getParameter("hspName");// 의료기관이름
			String hspKind = request.getParameter("hspKind"); // 의료기관종류
			String hspAddress = request.getParameter("hspAddress"); //의료기관주소
			String hspCrntAdd = request.getParameter("hspCrntAdd"); //의료기관 상세주소
			String tel = request.getParameter("hspTel").toString(); // 전화번호
			String hspTel = tel.replace("-", "");
			int hspDrNum = Integer.parseInt(request.getParameter("hspDrNum")); //의사수
			int hspNum = Integer.parseInt(request.getParameter("hspNum")); // 1시간당 접종가능수
			String hspLunchSt = request.getParameter("hspLunchSt").toString(); // 점심시작시간
			String hspLunchCl = request.getParameter("hspLunchCl").toString(); //점심 끝시간
			
			//오늘 날짜
			Date date = new Date();
			String today = String.format("%1$tY-%1$tm-%1$td", date);
			String rgstDate = today;
			
			// 옵션태그 시간선택
			String hspStMon= request.getParameter("hspStMon").toString();
			String hspClMon= request.getParameter("hspClMon").toString();
			String hspStTue= request.getParameter("hspStTue").toString();
			String hspClTue= request.getParameter("hspClTue").toString();
			String hspStWed= request.getParameter("hspStWed").toString();
			String hspClWed= request.getParameter("hspClWed").toString();
			String hspStThu= request.getParameter("hspStThu").toString();
			String hspClThu= request.getParameter("hspClThu").toString();
			String hspStFri= request.getParameter("hspStFri").toString();
			String hspClFri= request.getParameter("hspClFri").toString();
			String hspStSat= request.getParameter("hspStSat").toString();
			String hspClSat= request.getParameter("hspClSat").toString();
			String hspStSun= request.getParameter("hspStSun").toString();
			String hspClSun= request.getParameter("hspClSun").toString();
			
			//취급백신종류
			String hspVaccineArr[] = request.getParameterValues("hspVaccineCk"); 
			String hspVaccines = "";
			JoinIDao jn = sqlSession.getMapper(JoinIDao.class);
			
			for(int i = 0; i<hspVaccineArr.length; i++) {
				
				if(i != hspVaccineArr.length - 1)
					hspVaccines += hspVaccineArr[i].toString() + "> "; 
				else {
					hspVaccines += hspVaccineArr[i].toString();
				}
			}
						
			int setHspInfoRs = jn.setHspInfo(
				hspId, hspPw, hspEmail, hspName, hspKind, hspAddress, hspCrntAdd, 
				hspTel, hspDrNum, hspNum, hspLunchSt, hspLunchCl, hspVaccines, rgstDate);
			
			jn.setHspDayTime(hspId, hspName, 
					hspStMon, hspClMon, hspStTue, hspClTue, 
					hspStWed, hspClWed, hspStThu, hspClThu, 
					hspStFri, hspClFri, hspStSat, hspClSat, 
					hspStSun, hspClSun); //운영시간 등록
						
						
			// 가입완료 확인			
			if(setHspInfoRs == 1) { // 1이 반환되면 가입완료	 		
				
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('가입이 완료되었습니다.'); location.href='/login'; </script>");
					out.flush();
				}catch(Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러발생'); location.href='/login'; </script>");
					out.flush();
					return "redirect:login";
				}catch(Exception e) {
					e.printStackTrace();
				}
			  }
				
			
			return "redirect:login";
		}	
	
}
