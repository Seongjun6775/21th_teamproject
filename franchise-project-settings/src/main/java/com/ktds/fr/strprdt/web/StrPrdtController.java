package com.ktds.fr.strprdt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.ctycd.service.CtyCdService;
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
		// 세션>회원의 등급이 이용자일 경우
		if (mbrVO.getMbrLvl().equals("001-04")) {
			return "prdt/session_error";
		} else if (!mbrVO.getMbrLvl().equals("001-01")) {
			if (mbrVO.getStrId() == null) {
				strPrdtVO.setStrId("-");
			} else {
				strPrdtVO.setStrId(mbrVO.getStrId());
			}
		}
		
		PrdtVO prdtVO = new PrdtVO();
		
		List<StrPrdtVO> strPrdtList = strPrdtService.readAll(strPrdtVO);
		List<StrVO> strList = strService.readAll();
		List<PrdtVO> prdtList = prdtService.readAllNoPagenationUseY(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("strPrdtList", strPrdtList);
		model.addAttribute("strPrdtVO", strPrdtVO);
		model.addAttribute("strList", strList);
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("srtList", srtList);
		
		return "strprdt/strprdt_list";
		
	}
			
	@GetMapping("/strprdt/list2")
	public String strPrdtListCustomer(Model model
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		List<LctCdVO> lctList = lctService.read();
		model.addAttribute("lctList",lctList);
		model.addAttribute("mbrVO", mbrVO);
		
		return "strprdt/str_select";
	}
	
	/**
	 * 주문용 매장상세
	 */
	@GetMapping("/strprdt/{strId}")
	public String viewStrOne(StrPrdtVO strPrdtVO, @PathVariable String strId, Model model) {
		
		strPrdtVO.setStrId(strId);
		
		List<StrPrdtVO> strPrdtList = strPrdtService.readAllCustomerByStr(strPrdtVO);
		StrVO strVO = strService.readOneStrByMaster(strId);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("strPrdtVO", strPrdtVO);
		model.addAttribute("strPrdtList", strPrdtList);
		model.addAttribute("strVO", strVO);
		model.addAttribute("srtList", srtList);
		
		return "strprdt/str_select_menu";
	}
	
	/**
	 * 주문용 매장 > 상품선택
	 */
	@GetMapping("/strprdt/detail/{strPrdtId}")
	public String strPrdtDetail(@PathVariable String strPrdtId, Model model) {
		StrPrdtVO strPrdtVO = strPrdtService.readOneCustomerByStr(strPrdtId);
		
		model.addAttribute("strPrdtVO", strPrdtVO);
		
		return "strprdt/strprdt_detail";
	}
	
	

}
