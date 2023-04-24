package com.ktds.fr.odrdtl.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@Controller
public class OdrDtlController {
	
	@Autowired
	public OdrDtlService odrDtlService;
	
	@GetMapping("/odrdtl/list")
	public String viewOdrDtlPage(@SessionAttribute("__MBR__") MbrVO mbrVO, Model model) {
		
		OdrDtlVO odrDtlList = odrDtlService.readOneOdrDtlByOdrDtlId(mbrVO.getMbrId());
		model.addAttribute("odrDtlList", odrDtlList);
		
		return "odrdtl/detail";
	}

}
