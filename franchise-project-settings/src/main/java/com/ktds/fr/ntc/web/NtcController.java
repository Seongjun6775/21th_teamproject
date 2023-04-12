package com.ktds.fr.ntc.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ktds.fr.ntc.service.NtcService;
import com.ktds.fr.ntc.vo.NtcVO;

@Controller
public class NtcController {
	
	@Autowired
	private NtcService ntcService;
	
	@GetMapping("/ntc/create")
	public String viewNtcCreateNotice() {
		return "ntc/create";
	}
	
//	@GetMapping("/ntc/list/")
//	public String viewNtcList(@PathVariable String ntcId, Model model) {
//		NtcVO ntcVO = ntcService.readAllNoticeTitleByNoticeId(ntcId);
//		model.addAttribute("ntcId", ntcId);
//		return "ntc/list";
//	}
//	
//	@GetMapping("/ntc/update/{ntcTtl}")
//	public String 
}
