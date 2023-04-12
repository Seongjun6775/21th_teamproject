package com.ktds.fr.mngrbrd.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mbr.web.MbrController;
import com.ktds.fr.mngrbrd.service.MngrBrdService;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

@Controller
public class MngrBrdController {
	
	private static final Logger logger = LoggerFactory.getLogger(MbrController.class);
	
	@Autowired
	private MngrBrdService mngrBrdService;
	
	@GetMapping("/mngrbrds")
	public String viewMngrBrdListPage(Model model, MngrBrdVO mngrBrdVO,MbrVO user) {
		List<MngrBrdVO> mngrBrdList = mngrBrdService.readAllMngrBrds();
		model.addAttribute("mngrBrdList", mngrBrdList);
		model.addAttribute("mngrBrdVO", mngrBrdVO);
		return "mngrbrd/list";
	}

	@GetMapping("mngrbrd/{mngrBrdId}")
	public String viewMngrBrdDetailPage(@PathVariable String mngrBrdId, Model model) {
		
		logger.info("URL id 값 :{}",mngrBrdId);
		MngrBrdVO mngrBrd = mngrBrdService.readOneMngrBrdByMngrBrdId(mngrBrdId);
		model.addAttribute("mngrBrdId", mngrBrd);
		return "mngrbrd/detail";
	}
	@GetMapping("/mngrbrd/write")
	public String viewMngrBrdWritePage() {
		return "mngrbrd/write";
	}

//	
	@GetMapping("mngrbrd/update/{mngrBrdId}")
	public String viewMngrBrdUpdatePage(@PathVariable String mngrBrdId,Model model) {
		
		MngrBrdVO mngrBrd = mngrBrdService.readOneMngrBrdByMngrBrdId(mngrBrdId);
		model.addAttribute("mngrBrd", mngrBrd);
		return "mngrbrd/update";
	}

	
	
	
	
}
