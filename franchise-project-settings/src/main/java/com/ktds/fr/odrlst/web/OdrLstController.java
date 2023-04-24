package com.ktds.fr.odrlst.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.odrlst.vo.OdrLstVO;

@Controller
public class OdrLstController {
	
	@Autowired
	private OdrLstService odrLstService;
	
	@GetMapping("/odrlst/list")
	public String viewOdrLstPage(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			return "redirect:/odrlst/mngrodrlst";
		}
		else if (mbrVO.getMbrLvl().equals("001-04")) {
			return "redirect:/odrlst/mbrodrlst";
		}
		else {
			return "redirect:/index";
		}
	}
	
	@GetMapping("/odrlst/mngrodrlst")
	public String viewMngrOdrLstPage(@SessionAttribute("__MBR__") MbrVO mbrVO, OdrLstVO odrLstVO
									, Model model) {
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			List<OdrLstVO> allOdrLst = odrLstService.readAllOdrLst(odrLstVO);
			model.addAttribute("allOdrLst", allOdrLst);
			model.addAttribute("mbrVO", mbrVO);
			return "odrlst/mngrodrlst";
		}
		return "redirect:/odrlist/list";
	}
	
	@GetMapping("/odrlst/mbrodrlst")
	public String viewMbrOdrLstPage(@SessionAttribute("__MBR__") MbrVO mbrVO, OdrLstVO odrLstVO
									, Model model) {
		if (mbrVO.getMbrLvl().equals("001-04")) {
			odrLstVO.setMbrId(mbrVO.getMbrId());
			List<OdrLstVO> myOdrLst = odrLstService.readAllMyOdrLst(odrLstVO);
			model.addAttribute("myOdrLst", myOdrLst);
			model.addAttribute("mbrVO", mbrVO);
			return "odrlst/mbrodrlst";
		}
		return "redirect:/odrlst/list";
	}
	
	
	
	
	
	

}
