package com.ktds.fr.strprdt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
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
	private CmmnCdService cmmnCdService;
	
	@GetMapping("/strprdt/list")
	public String strPrdtList(StrPrdtVO strPrdtVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, Model model) {
		// 세션>회원의 등급이 상위관리자가 아닐경우
		if (!(mbrVO.getMbrLvl().equals("001-01")
				|| mbrVO.getMbrLvl().equals("001-02"))) {
			return "prdt/session_error";
		}
		StrVO strVO = new StrVO();
		PrdtVO prdtVO = new PrdtVO();
		
		List<StrPrdtVO> strPrdtList = strPrdtService.readAll(strPrdtVO);
		List<StrVO> strList = strService.readAllStrMaster(strVO);
		List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("strPrdtList", strPrdtList);
		model.addAttribute("strPrdtVO", strPrdtVO);
		model.addAttribute("strList", strList);
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("srtList", srtList);
		
		return "strprdt/strprdt_list";
	}
	

}
