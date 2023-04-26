package com.ktds.fr.evntstr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.evntstr.service.EvntStrService;
import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Controller
public class EvntStrController {
	
	@Autowired
	private EvntStrService evntStrService;

	
	// 이벤트 참여매장 리스트
	@RequestMapping("/evntStr/list/{evntId}")
	public String viewEvntStrListPage(Model model, EvntStrVO evntStrVO, @PathVariable String evntId) {
		evntStrVO.setEvntId(evntId);
		
		List<EvntStrVO> evntStrList = evntStrService.readAllEvntStr(evntStrVO);
		model.addAttribute("evntStrList", evntStrList);
		return "evntStr/list";
	}
	
	// 우리매장 이벤트 참여매장 리스트
	@RequestMapping("/evntStr/ourList")
	public String viewOurEvntStrListPage(Model model, EvntStrVO evntStrVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		// 세션에서 Store ID를 가져옴
		String strId = mbrVO.getStrId();
		evntStrVO.setStrId(strId);
		
		List<EvntStrVO> evntStrList = evntStrService.readAllEvntStr(evntStrVO);
	
		model.addAttribute("evntStrList", evntStrList);
		return "evntStr/ourList";
	}
	

}