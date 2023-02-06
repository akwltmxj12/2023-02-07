package com.sycompany.hsp.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.sycompany.hsp.dao.ModifyIDao;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.HspKindListDto;
import com.sycompany.hsp.dto.HspdayappDto;

@Controller
public class ModifyController {
	
	@Autowired
	private SqlSession sqlSession;

	
		//의료기관정보 수정화면
		@RequestMapping("/modify")
		public String modify(HttpServletRequest request, Model model, HttpSession session) {
			
			String sessionId = session.getAttribute("hspId").toString();
			
			ModifyIDao md = sqlSession.getMapper(ModifyIDao.class);
			
			HspInfoDto hspInfo = md.getHspInfo(sessionId); //의료기관 모든 정보
	 		HspdayappDto hspRunTime= md.getHspRunTime(sessionId); //의료기관 운영시간
			
	 		String hspKinds = hspInfo.getHspVaccineCk();
	 		String hspKind[] = hspKinds.split("> ");
	 		List<String> hspKindList = Arrays.asList(hspKind);
	 		model.addAttribute("hspKindList",hspKindList);
	 		
	 		boolean hspKindList1 = hspKindList.contains("인플루엔자(독감)");
			boolean hspKindList2= hspKindList.contains("결핵(BCG, 피내용)");
			boolean hspKindList3= hspKindList.contains("B형간염(HepB)");
			boolean hspKindList4= hspKindList.contains("디프테리아/파상풍/백일해(DTaP)");
			boolean hspKindList5= hspKindList.contains("디프테리아/파상풍/백일해/폴리오(DTaP-IPV)");
			boolean hspKindList6= hspKindList.contains("디프테리아/파상풍/백일해/폴리오/Hib(DTaP-IPV/Hib)");
			boolean hspKindList7= hspKindList.contains("디프테리아/파상풍/백일해(TdaP)");
			boolean hspKindList8= hspKindList.contains("파상풍/디프테리아(Td)");
			boolean hspKindList9= hspKindList.contains("폴리오(IPV)");
			boolean hspKindList10= hspKindList.contains("b형헤모필루스인플루엔자");
			boolean hspKindList11= hspKindList.contains("폐렴구균(PCV 10가)");
			boolean hspKindList12= hspKindList.contains("폐렴구균(PCV 13가)");
			boolean hspKindList13= hspKindList.contains("폐렴구균(PCV 23가)");
			boolean hspKindList14= hspKindList.contains("홍역/유행성이하선염/풍진(MMR)");
			boolean hspKindList15= hspKindList.contains("A형간염(HepA)");
			
			HspKindListDto dto = new HspKindListDto(
					hspKindList1, hspKindList2, hspKindList3, hspKindList4, hspKindList5, hspKindList6,
					hspKindList7, hspKindList8, hspKindList9, hspKindList10, hspKindList11, hspKindList12,
					hspKindList13, hspKindList14, hspKindList15);
			
			
			model.addAttribute("dtoList",dto);//해당의료기관에서 취급하는 예방접종목록
	 		model.addAttribute("hspInfo",hspInfo); // 병원정보
			model.addAttribute("hspRunTime",hspRunTime); //예약가능시간
			
 		
			return "modify";
		}
		
		//의료기관 정보수정
		//@RequestMapping("/hspInfoModifySetUp")
		@PostMapping("/hspInfoModifySetUp")
		public String hspInfoModifySetUp(HttpServletResponse response, HttpServletRequest request, HttpSession session) {
			
			String sessionId = session.getAttribute("hspId").toString(); //로그인한 의료기관 아이디
			
			String hspName = request.getParameter("hspName"); //의료기관명
			String hspAddress = request.getParameter("hspAddress"); //의료기관 주소
			String hspCrntAdd = request.getParameter("hspCrntAdd"); // 의료기관 상세주소
			String hspTel = request.getParameter("hspTel"); // 의료기관 번호
			int hspDrNum = Integer.parseInt(request.getParameter("hspDrNum").toString()); // 의사 수
			int hspNum = Integer.parseInt(request.getParameter("hspNum").toString()); // 시간당 접종가능 수
			String hspLunchSt = request.getParameter("hspLunchSt"); // 점심시작
			String hspLunchCl = request.getParameter("hspLunchCl");  // 점심끝
			
			ModifyIDao md = sqlSession.getMapper(ModifyIDao.class);
			
			int hspInfoM= md.hspInfoModify(sessionId, hspName, hspAddress, hspCrntAdd, 
								hspTel, hspDrNum, hspNum, hspLunchSt, hspLunchCl);
			
			PrintWriter out;
			if(hspInfoM>=1) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('수정이 완료되었습니다.'); location.href='/modify'; </script>");
					out.flush();
					return "redirect:modify";
				}catch(Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/modify'; </script>");
					out.flush();
					return "redirect:modify";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			return "redirect:modify";
		}
		
		//의료기관 예약가능시간 수정
		//@RequestMapping("/hspAppTimeModify")
		@PostMapping("/hspAppTimeModify")
		public String hspAppTimeModify(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
			
			String sessionId = session.getAttribute("hspId").toString(); //로그인한 의료기관 아이디
			
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
			
			ModifyIDao md = sqlSession.getMapper(ModifyIDao.class);
			
			int hspAppTimeM = md.hspAppTimeModify(sessionId,
					hspStMon, hspClMon, hspStTue, hspClTue, 
					hspStWed, hspClWed, hspStThu, hspClThu, 
					hspStFri, hspClFri, hspStSat, hspClSat, 
					hspStSun, hspClSun);
		
			
			PrintWriter out;
			if(hspAppTimeM>=1) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('수정이 완료되었습니다.'); location.href='/modify'; </script>");
					out.flush();
					return "redirect:modify";
				}catch(Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/modify'; </script>");
					out.flush();
					return "redirect:modify";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return "redirect:modify";
		}
		
		
		// 의료기관 취급 백신 수정
		@RequestMapping("/hspVaccineModify")
		//@PostMapping("/hspVaccineModify")
		public String hspVaccineModify(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
			
			String sessionId = session.getAttribute("hspId").toString(); //로그인한 의료기관 아이디
			
			String remove= request.getParameter("remove");
			String add= request.getParameter("add");
			String hspVaccineCk= request.getParameter("hspVaccineCk");
			
			ModifyIDao md = sqlSession.getMapper(ModifyIDao.class);
			
			HspInfoDto hspInfo = md.getHspInfo(sessionId); //의료기관 모든 정보
			String hspKinds = hspInfo.getHspVaccineCk(); // 취급백신 정보
	 		String hspKind[] = hspKinds.split("> "); //배열로 반환
			
			
			String vaccines = ""; //백신 한 줄로 넣을 빈값 만들기
			PrintWriter out;
			if(add != null) { // 백신 추가
				List<String> hspVaccineCkList = new ArrayList<>(Arrays.asList(hspKind)); // 리스트로 전환
				hspVaccineCkList.add(hspVaccineCk);
				String VaccineCk[] = hspVaccineCkList.toArray(new String[0]);

				for(int i = 0; i<VaccineCk.length; i++) {
					if(i != VaccineCk.length - 1) {
						vaccines += VaccineCk[i].toString() + "> "; 
					}else {
						vaccines += VaccineCk[i].toString();
					}
				}
				int addReturn = md.hspVaccineModify(sessionId, vaccines); //더한 내용 수정
					if(addReturn>0){
						try {
							response.setContentType("text/html;charset=utf-8");
							out = response.getWriter();
							out.println("<script>alert('추가되었습니다.'); location.href='/modify'; </script>");
							out.flush();
							return "redirect:modify";
						}catch(Exception e) {
							e.printStackTrace();
						}
					} else {
						try {
							response.setContentType("text/html;charset=utf-8");
							out = response.getWriter();
							out.println("<script>alert('추가 중 문제가 발생하였습니다. 다시 추가해주세요.'); location.href='/modify'; </script>");
							out.flush();
							return "redirect:modify";
						}catch(Exception e) {
							e.printStackTrace();
						}
					}
					
			} 
						
			else if(remove != null) { // 백신 삭제
				
				List<String> hspVaccineCkList = new ArrayList<>(Arrays.asList(hspKind)); // 리스트로 전환
								
				for(int i =0; i< hspVaccineCkList.size(); i++) {
					String item = hspVaccineCkList.get(i);
					if(item.equals(hspVaccineCk)) {
						hspVaccineCkList.remove(item); //삭제
					}
				}
				
				String VaccineCk[] = hspVaccineCkList.toArray(new String[0]);

				for(int i = 0; i<VaccineCk.length; i++) {
					if(i != VaccineCk.length - 1) {
						vaccines += VaccineCk[i].toString() + "> "; 
					}else {
						vaccines += VaccineCk[i].toString();
					}
				}
				
				int addReturn = md.hspVaccineModify(sessionId, vaccines); //삭제 내용 수정
				
					if(addReturn>0) {
						try {
							response.setContentType("text/html;charset=utf-8");
							out = response.getWriter();
							out.println("<script>alert('삭제되었습니다.'); location.href='/modify'; </script>");
							out.flush();
							return "redirect:modify";
						}catch(Exception e) {
							e.printStackTrace();
						}
					}else {
						try {
							response.setContentType("text/html;charset=utf-8");
							out = response.getWriter();
							out.println("<script>alert('삭제 중 문제가 발생하였습니다. 다시 삭제해주세요.'); location.href='/modify'; </script>");
							out.flush();
							return "redirect:modify";
						}catch(Exception e) {
							e.printStackTrace();
						}
					}
				
			} else {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/modify'; </script>");
					out.flush();
					return "redirect:modify";
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return "redirect:modify";
		}
		

}
