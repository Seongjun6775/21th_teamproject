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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mbr.web.MbrController;
import com.ktds.fr.mngrbrd.service.MngrBrdService;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;
import com.ktds.fr.rpl.vo.RplVO;

@Controller
public class MngrBrdController {
	
	private static final Logger logger = LoggerFactory.getLogger(MbrController.class);
	
	@Autowired
	private MngrBrdService mngrBrdService;
	
	@GetMapping("/mngrbrd/list")
	public String viewMngrBrdListPage(Model model, MngrBrdVO mngrBrd,
								@SessionAttribute("__MBR__") MbrVO mbrVO) {
		List<MngrBrdVO> mngrBrdList = mngrBrdService.readAllMngrBrds(mngrBrd);
		model.addAttribute("mngrBrdList", mngrBrdList);
		model.addAttribute("mngrBrd", mngrBrd);
		model.addAttribute("mbrVO", mbrVO);
		
		
		
		return "mngrbrd/list";
	}
	
	
	@GetMapping("/mngrbrd/{mngrBrdId}")
	public String viewMngrBrdDetailPage(@PathVariable String mngrBrdId, Model model,
									RplVO rplVO,
									@SessionAttribute("__MBR__") MbrVO mbrVO
								) {
		
		MngrBrdVO mngrBrd = mngrBrdService.readOneMngrBrdByMngrBrdId(mngrBrdId);
		
		model.addAttribute("mngrBrd", mngrBrd);
		model.addAttribute("mbrVO", mbrVO);	
		model.addAttribute("rplVO", rplVO);
		return "mngrbrd/detail";
	}
	
	@GetMapping("/mngrbrd/write")
	public String viewMngrBrdWritePage() {
		return "mngrbrd/write";
	}

	@GetMapping("/mngrbrd/update/{mngrBrdId}")
	public String viewMngrBrdUpdatePage(@PathVariable String mngrBrdId,Model model) {
		
		logger.info("URL id 값 :{}",mngrBrdId);
		
		MngrBrdVO mngrBrd = mngrBrdService.readOneMngrBrdByMngrBrdId(mngrBrdId);
		model.addAttribute("mngrBrd", mngrBrd);
		/*
		 * 댓글vo 댓글vo = 댓글서비스.댓글읽기(게시글id); model.addAttribute("댓글목록", 댓글VO);
		 */
		return "mngrbrd/update";
	}
	
	
	

	
	
	
	
}
