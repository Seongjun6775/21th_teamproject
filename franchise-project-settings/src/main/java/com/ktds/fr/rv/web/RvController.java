package com.ktds.fr.rv.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ktds.fr.rv.service.RvService;
import com.ktds.fr.rv.vo.RvVO;

@Controller
public class RvController {
		
	@Autowired
	private RvService rvService;
	
	@GetMapping("/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO) {
		List<RvVO> rvList = rvService.readAllRvList(rvVO);
		
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		
		return "rv/list";
	}
	
	@GetMapping("/rv/create")
	public String viewCreateNewRvPage() {		
		return "rv/create";
	}
	
}


	

