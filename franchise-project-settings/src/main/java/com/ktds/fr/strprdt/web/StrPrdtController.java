package com.ktds.fr.strprdt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.ctycd.service.CtyCdService;
import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.lctcd.service.LctCdService;
import com.ktds.fr.lctcd.vo.LctCdVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;
import com.ktds.fr.strprdt.service.StrPrdtService;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Controller
public class StrPrdtController {
	
	@Autowired
	private StrPrdtService strPrdtService;

	@Autowired
	private StrService strService;
	
	@Autowired
	private PrdtService prdtService;
	
	@Autowired
	private LctCdService lctService;
	
	@Autowired
	private CtyCdService ctyService;
	
	@Autowired
	private CmmnCdService cmmnCdService;
	
	@GetMapping("/strprdt/list")
	public String strPrdtList(StrPrdtVO strPrdtVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, Model model) {
		// 세션>회원의 등급이 상위관리자가 아닐경우
		if (mbrVO.getMbrLvl().equals("001-01")) {
			PrdtVO prdtVO = new PrdtVO();
			
			List<StrPrdtVO> strPrdtList = strPrdtService.readAll(strPrdtVO);
			List<StrVO> strList = strService.readAll();
			List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
			List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
			
			model.addAttribute("strPrdtList", strPrdtList);
			model.addAttribute("strPrdtVO", strPrdtVO);
			model.addAttribute("strList", strList);
			model.addAttribute("prdtList", prdtList);
			model.addAttribute("srtList", srtList);
			
			return "strprdt/strprdt_list";
			
		} else if (mbrVO.getMbrLvl().equals("001-02")) {
			PrdtVO prdtVO = new PrdtVO();
			String strId = mbrVO.getStrId() != null ?  mbrVO.getStrId() : "none" ; 
			strPrdtVO.setStrId(strId);
			
			List<StrPrdtVO> strPrdtList = strPrdtService.readAll(strPrdtVO);
			StrVO strVO = strService.readOneStrByManager(strId);
			List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
			List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
			
			model.addAttribute("strPrdtList", strPrdtList);
			model.addAttribute("strVO", strVO);
			model.addAttribute("strPrdtVO", strPrdtVO);
			model.addAttribute("prdtList", prdtList);
			model.addAttribute("srtList", srtList);
			
			return "strprdt/strprdt_list2";
			
		} else if (mbrVO.getMbrLvl().equals("001-03")) {
			PrdtVO prdtVO = new PrdtVO();
			String strId = mbrVO.getStrId() != null ?  mbrVO.getStrId() : "none" ; 
			strPrdtVO.setStrId(strId);
			
			List<StrPrdtVO> strPrdtList = strPrdtService.readAll(strPrdtVO);
			StrVO strVO = strService.readOneStrByManager(strId);
			List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
			List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
			
			model.addAttribute("strPrdtList", strPrdtList);
			model.addAttribute("strVO", strVO);
			model.addAttribute("strPrdtVO", strPrdtVO);
			model.addAttribute("prdtList", prdtList);
			model.addAttribute("srtList", srtList);
			
			return "strprdt/strprdt_list3";
			
		} else {
			return "prdt/session_error";
		}
	}
	
	@GetMapping("/strprdt/list2")
	public String strPrdtListCustomer(Model model
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		List<LctCdVO> lctList = lctService.read();
		model.addAttribute("lctList",lctList);
		
		return "strprdt/str_select";
	}
	
	/**
	 * 주문용 매장상세
	 */
	@GetMapping("/strprdt/{strId}")
	public String viewStrOne(@PathVariable String strId, Model model) {
		List<StrPrdtVO> strPrdtList = strPrdtService.readAllCustomerByStr(strId);
		StrVO strVO = strService.readOneStrByMaster(strId);
		
		
		model.addAttribute("strPrdtList", strPrdtList);
		model.addAttribute("strVO", strVO);
		
		return "str/str_select_menu";
	}
	
	

}
