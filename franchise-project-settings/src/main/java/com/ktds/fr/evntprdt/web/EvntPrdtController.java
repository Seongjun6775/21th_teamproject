package com.ktds.fr.evntprdt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ktds.fr.evntprdt.service.EvntPrdtService;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;

@Controller
public class EvntPrdtController {

	@Autowired
	private EvntPrdtService evntService;
	
	
	@RequestMapping("/evntPrdt/list/{evntId}")
	public String viewEvntPrdtListPage(Model model, EvntPrdtVO evntPrdtVO, @PathVariable String evntId ) {
		evntPrdtVO.setEvntId(evntId);
		List<EvntPrdtVO> evntPrdtList = evntService.readAllEvntPrdt(evntPrdtVO);
		model.addAttribute("evntPrdtList", evntPrdtList);				
		return "/evntPrdt/list";
	}
}
