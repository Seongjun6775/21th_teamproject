package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@Controller
public class OdrDtlController {
	
	@Autowired
	public OdrDtlService odrDtlService;
	
	@GetMapping("/odrdtl/list/{odrLstId}")
	public String viewOdrDtlPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								,@PathVariable String odrLstId, OdrDtlVO odrDtlVO, Model model) {
		if (mbrVO.getMbrLvl().equals("001-04")) {
			
			odrDtlVO.setMbrId(mbrVO.getMbrId());
			odrDtlVO.setOdrLstId(odrLstId);
			List<OdrDtlVO> odrDtlList = odrDtlService.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
			
			model.addAttribute("odrDtlList", odrDtlList);
			model.addAttribute("mbrVO", mbrVO);
			
			return "odrdtl/odrdtllist";
		}
		return "redirect:/index";
	}

}
