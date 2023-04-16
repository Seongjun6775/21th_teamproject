package com.ktds.fr.evntstr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ktds.fr.evntstr.service.EvntStrService;
import com.ktds.fr.evntstr.vo.EvntStrVO;

public class EvntStrController {
	@Autowired
	private EvntStrService evntStrService;
	
	@GetMapping("/evntStr/list")
	public String viewEvntListPage(Model model, EvntStrVO evntStrVO) {
		List<EvntStrVO> evntStrList = evntStrService.readAllEvntStr(evntStrVO);
		model.addAttribute("evntStrList", evntStrList);
		return "evnt/list";
	}
}
