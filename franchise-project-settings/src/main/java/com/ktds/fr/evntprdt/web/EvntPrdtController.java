package com.ktds.fr.evntprdt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.evntprdt.service.EvntPrdtService;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;

@Controller
public class EvntPrdtController {

	@Autowired
	private PrdtService prdtService;
	
	@Autowired
	private EvntPrdtService evntService;
	
	@Autowired
	private CmmnCdService cmmnCdService;
	
	
	//상품불러오기
	@GetMapping("/evntPrdt/create/{evntId}")
	public String createEvntPrdtPage(Model model, EvntPrdtVO evntPrdtVO, PrdtVO prdtVO, @PathVariable String evntId) {
		model.addAttribute("evntId", evntId);
		prdtVO.setPrdtViewCnt(9999);
		List<PrdtVO> prdtVOList = prdtService.readAll(prdtVO);
		
		model.addAttribute("prdtVOList", prdtVOList);
		
		return "evntPrdt/create";
	}
	
	@RequestMapping("/evntPrdt/list/{evntId}")
	public String viewEvntPrdtListPage(Model model, EvntPrdtVO evntPrdtVO, @PathVariable String evntId ) {
		evntPrdtVO.setEvntId(evntId);
		List<EvntPrdtVO> evntPrdtList = evntService.readAllEvntPrdt(evntPrdtVO);
		model.addAttribute("evntPrdtList", evntPrdtList);				
		return "/evntPrdt/list";
	}
	
	@RequestMapping("/evntPrdt/prdtList")
	public String viewPrdtListPage(Model model, EvntPrdtVO evntPrdtVO) {
		List<EvntPrdtVO> evntPrdtList = evntService.readAllPrdt(evntPrdtVO);
		model.addAttribute("evntPrdtList", evntPrdtList);		
		return "/evntPrdt/prdtList";
	}
	
	@GetMapping("/evntPrdt/prdtList2/{evntId}")
	public String viewPrdtListSecondPage(Model model, PrdtVO prdtVO, @PathVariable String evntId) {
		
		prdtVO.setUseYn("Y");
		List<PrdtVO> prdtList = prdtService.readAllNoPagenation(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("srtList", srtList);
		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("evntId", evntId);
		return "/evntPrdt/prdtList2";
	}
}
