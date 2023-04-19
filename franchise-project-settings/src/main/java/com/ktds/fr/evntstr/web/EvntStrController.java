package com.ktds.fr.evntstr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ktds.fr.evntstr.service.EvntStrService;
import com.ktds.fr.evntstr.vo.EvntStrVO;

@Controller
public class EvntStrController {
	
	@Autowired
	private EvntStrService evntStrService;

	@RequestMapping("/evntStr/list/{evntId}")
	public String viewEvntListPage(Model model, EvntStrVO evntStrVO, @PathVariable String evntId) {
		evntStrVO.setEvntId(evntId);
		List<EvntStrVO> evntStrList = evntStrService.readAllEvntStr(evntStrVO);
		model.addAttribute("evntStrList", evntStrList);
		return "evntStr/list";
	}
}
