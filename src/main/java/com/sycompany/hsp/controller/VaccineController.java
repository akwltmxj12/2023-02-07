package com.sycompany.hsp.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
import com.sycompany.hsp.dao.VaccineIDao;
import com.sycompany.hsp.dto.HspInfoDto;
import com.sycompany.hsp.dto.Hsp_vaccineInfoDto;

@Controller
public class VaccineController {

	@Autowired
	private SqlSession sqlSession;
	

	//백신 페이지
	@RequestMapping("/vaccine")
	public String vaccine(HttpServletRequest request, Model model, HttpSession session) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		
		VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);
		
		//백신조회
		List<Hsp_vaccineInfoDto> VaccineStock = vc.getHspVaccineAllStock(sessionId);
		// 로그인한 병원 정보가져오기
		HspInfoDto hspInfoDto = vc.getHspInfo(sessionId);
		String hspVaccin = hspInfoDto.getHspVaccineCk();
		String hspVaccins[] = hspVaccin.split("> ");
		
		model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기
		model.addAttribute("VaccineStock", VaccineStock); // 백신 조회
		
		return "vaccine";
	}
	
	//원하는 백신만 조회
	@RequestMapping("/vaccineSearch")
	public String vaccineSearch(HttpServletRequest request, Model model, HttpSession session) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		String vaccineName = request.getParameter("vaccineName"); // 조회한 백신 이름
		
		VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);

		// 로그인한 병원 정보가져오기
		HspInfoDto hspInfoDto = vc.getHspInfo(sessionId);
		String hspVaccin = hspInfoDto.getHspVaccineCk();
		String hspVaccins[] = hspVaccin.split("> ");
		
		model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기

		if(vaccineName.equals("취급백신품목")) {  // 취급백신품목을 조회하는 경우 처음으로 돌려주기
			return "redirect:vaccine";
		}	
		
		List<Hsp_vaccineInfoDto> vaccineStocks = vc.vaccineStockSearch(sessionId, vaccineName); // 검색한 백신 정보 보내기
		
		model.addAttribute("VaccineStock", vaccineStocks); //로그인한 의료기관 취급백신 종류
		model.addAttribute("vaccineName",vaccineName); // 선택한 백신이름
		
		return "vaccine";
	}
	
	
	//백신 등록
	@RequestMapping("/vaccineAdd")
	public String vaccineAdd(HttpServletRequest request, Model model, HttpSession session, HttpServletResponse response) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		String vaccineName = request.getParameter("vaccineName").toString(); // 백신종류
		String vaccineCompany = request.getParameter("vaccineCompany").toString(); // 제조사
		String vaccineRcvDay = request.getParameter("vaccineRcvDay").toString(); //백신 입고일
		String vaccineDscDay = request.getParameter("vaccineDscDay").toString(); //백신 폐기일
		int vaccineHold = Integer.parseInt(request.getParameter("vaccineHold").toString()); // 백신 입고량
		
		
		String rcvDay = vaccineRcvDay; //입고일
		SimpleDateFormat dateRcvFormat = new SimpleDateFormat("yyyy-mm-dd");
		Date dateRcv = null;
		
		String dscDay = vaccineDscDay; //폐기일
		SimpleDateFormat dateDscFormat = new SimpleDateFormat("yyyy-mm-dd");
		Date dateDsc = null;
		
		PrintWriter out;
		
		//입고일과 폐기일 설정
		try {
			dateRcv = dateRcvFormat.parse(rcvDay); //입고일
			dateDsc = dateDscFormat.parse(dscDay); // 폐기일
			
			int result = dateRcv.compareTo(dateDsc);//입고일이 폐기일보다 뒤면 안 됨

			if(result > 0) {
				try {
					response.setContentType("text/html;charset=utf-8");
					out = response.getWriter();
					out.println("<script>alert('폐기일이 입고일보다 빠를수는 없습니다.'); location.href='/vaccine'; </script>");
					out.flush();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			else {
				VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);
				
				
				 if(!vaccineName.equals("백신종류 선택")) {
					 
				
					int hspvaccineAdd = vc.hspVaccineHold(sessionId, vaccineName, vaccineCompany, vaccineRcvDay, vaccineDscDay, vaccineHold);
				
						if(hspvaccineAdd > 0) {
								try {
									response.setContentType("text/html;charset=utf-8");
									out = response.getWriter();
									out.println("<script>alert('등록되었습니다.'); location.href='/vaccine'; </script>");
									out.flush();
								}catch(Exception e) {
									e.printStackTrace();
								}
						}
				}else {
							try {
								response.setContentType("text/html;charset=utf-8");
								out = response.getWriter();
								out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/vaccine'; </script>");
								out.flush();
							}catch(Exception e) {
								e.printStackTrace();
							}
				}
			}

		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		

		return "redirect:vaccine";
	}
	
	
	
	//백신 이름 순으로 정렬
	@RequestMapping("/vaccineKindRange")
	public String vaccineKindRange(HttpServletRequest request, Model model, HttpSession session) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		
		String vaccineName = request.getParameter("vaccineName").toString(); // 검색중인 값
		String storedDate = request.getParameter("storedDate"); // 입고날짜순으로 나열
		String releasedDate = request.getParameter("releasedDate"); // 폐기일 순으로 나열
		
		
		VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);
		
		HspInfoDto hspInfoDto = vc.getHspInfo(sessionId);
		String hspVaccin = hspInfoDto.getHspVaccineCk();
		String hspVaccins[] = hspVaccin.split("> ");
		
	
		
		
		if(storedDate != null && vaccineName == ""){ // 조회없이 입고날자 순 나열
			List<Hsp_vaccineInfoDto> StockDESC = vc.vaccineStockDESC(sessionId);
			model.addAttribute("VaccineStock",StockDESC);
			model.addAttribute("vaccineName",vaccineName); // 선택한 백신이름
			model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기
			return "vaccine";
			
		}else if(releasedDate != null && vaccineName == ""){ // 조회없이 폐기날짜 순 나열
				
			List<Hsp_vaccineInfoDto> StockASC = vc.vaccineStockASC(sessionId);
			model.addAttribute("VaccineStock",StockASC);
			model.addAttribute("vaccineName",vaccineName); // 선택한 백신이름
			model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기
			return "vaccine";
				
		}else if(storedDate != null) { // 입고날짜 순 나열
			List<Hsp_vaccineInfoDto> StockRangeDESC = vc.vaccineStockRangeDESC(sessionId, vaccineName);
			model.addAttribute("VaccineStock",StockRangeDESC);
			model.addAttribute("vaccineName",vaccineName); // 선택한 백신이름
			model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기
			
			return "vaccine";
		} else if (releasedDate != null) { // 폐기임박 순 나열
			List<Hsp_vaccineInfoDto> StockRangeASC = vc.vaccineStockRangeASC(sessionId, vaccineName);
			model.addAttribute("VaccineStock",StockRangeASC);
			model.addAttribute("vaccineName",vaccineName); // 선택한 백신이름
			model.addAttribute("hspVaccins", hspVaccins);//로그인한 병원 취급하고 있는 백신종류 뷰에 보내기
			return "vaccine";
			
		}else {
	
			return "redirect:vaccine";
		}
	
	}
	
	@RequestMapping("/vaccineStockModify")
	public String vaccineStockModify(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model) {
		
		//로그인한 아이디 가져오기
		String sessionId = session.getAttribute("hspId").toString();
		
		//변경 전 값
		String vaccineNameRs = request.getParameter("vaccineNameRs").toString(); //백신명
		String vaccineCompanyRs = request.getParameter("vaccineCompanyRs").toString(); //백신제조사
		String vaccineRcvDayRs  = request.getParameter("vaccineRcvDayRs"); //  백신 입고일
		String vaccineDscDayRs  = request.getParameter("vaccineDscDayRs"); // 백신 폐기일
		int vaccineHoldRs  = Integer.parseInt(request.getParameter("vaccineHoldRs").toString()); //  백신 입고량
		int vaccineUseRs  = Integer.parseInt(request.getParameter("vaccineUseRs").toString()); // 백신 사용량
		
		//변경 후 값
		String vCRs = request.getParameter("vCRs").toString(); //백신제조사
		String vRDRs  = request.getParameter("vRDRs"); //  백신 입고일
		String vDDRs  = request.getParameter("vDDRs"); // 백신 폐기일
		int vHRs  = Integer.parseInt(request.getParameter("vHRs").toString()); //  백신 입고량
		int vURs  = Integer.parseInt(request.getParameter("vURs").toString()); // 백신 사용량
		
		VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);
	
		int vInfoChange = vc.vaccineInfoChange(vCRs, 
												vRDRs, vDDRs, 
												vHRs, vURs, 
												sessionId, 
												vaccineNameRs, vaccineCompanyRs, 
												vaccineRcvDayRs, vaccineDscDayRs, 
												vaccineHoldRs);

		PrintWriter out;
		if(vInfoChange>0) {
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('수정이 완료되었습니다.'); location.href='/vaccine'; </script>");
				out.flush();
				return "redirect:modify";
			}catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/vaccine'; </script>");
				out.flush();
				return "redirect:modify";
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return "vaccine";
	}
	
	
	
	@RequestMapping("/vaccineStockDel")
	public String vaccineStockDel(HttpServletRequest request, Model model, HttpSession session, HttpServletResponse response) {
		
		
		String sessionId = session.getAttribute("hspId").toString(); //로그인한 아이디 가져오기				
		String vaccineNameRs = request.getParameter("vaccineNameRs").toString(); //백신명
		String vaccineCompanyRs = request.getParameter("vaccineCompanyRs").toString(); //백신제조사
		String vaccineRcvDayRs  = request.getParameter("vaccineRcvDayRs"); //  백신 입고일
		String vaccineDscDayRs  = request.getParameter("vaccineDscDayRs"); // 백신 폐기일
		int vaccineHoldRs  = Integer.parseInt(request.getParameter("vaccineHoldRs").toString()); //  백신 입고량
		int vaccineUseRs  = Integer.parseInt(request.getParameter("vaccineUseRs").toString()); // 백신 사용량
		
		VaccineIDao vc = sqlSession.getMapper(VaccineIDao.class);
		
		int vInfoDelete = vc.vaccineInfoDelete(sessionId, 
												vaccineNameRs, vaccineCompanyRs, 
												vaccineRcvDayRs, vaccineDscDayRs, 
												vaccineHoldRs);
		
		
		PrintWriter out;
		if(vInfoDelete>0) {
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('삭제가 완료되었습니다.'); location.href='/vaccine'; </script>");
				out.flush();
				return "redirect:modify";
			}catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.setContentType("text/html;charset=utf-8");
				out = response.getWriter();
				out.println("<script>alert('에러가 발생하였습니다. 다시 시도해주세요.'); location.href='/vaccine'; </script>");
				out.flush();
				return "redirect:modify";
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return "redirect:vaccine";
	}
}
