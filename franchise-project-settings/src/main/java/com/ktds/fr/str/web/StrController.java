package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class StrController {

	@Autowired
	private StrService strService;
	
	@GetMapping("/str/list")
	public String viewStrListPage(StrVO strVO) {
		return "str/list";
	}
	
	@GetMapping("/str/create")
	public String viewStrCreatePage() {
		return "str/create";
	}
	
	@GetMapping("/str/detail/{strId}")
	public String viewStrDetailPage(@PathVariable String strId, Model model) {
		StrVO strVO = strService.readOneStrByMaster(strId);
		model.addAttribute("strVO", strVO);
		return "str/detail";
		
	}
}
