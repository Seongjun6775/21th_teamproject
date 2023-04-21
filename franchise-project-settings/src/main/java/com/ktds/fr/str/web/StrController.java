package com.ktds.fr.str.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.exceptions.IllegalRequestException;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class StrController {

	@Autowired
	private StrService strService;
	
	@GetMapping("/str/list")
	public String viewStrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO, String strId, Model model, StrVO strVO) {
	    if (mbrVO.getMbrLvl().equals("001-01")) {
	        List<StrVO> strList = strService.readAllStrMaster(strVO);
	        model.addAttribute("strList", strList);
	        model.addAttribute("MbrVO", mbrVO);
	        return "str/list";
	        
	    } else if (mbrVO.getMbrLvl().equals("001-02")) {
	    	return "redirect:/str/strdetailmgn/" + mbrVO.getStrId();
	    } else {
	        return "redirect:/index";
	    }
	}
	
	@GetMapping("/str/create")
	public String viewStrCreatePage() {
		return "str/create";
	}
	
	@GetMapping("/str/strdetailmst/{strId}")
	public String viewStrDetailMstPage(@SessionAttribute("__MBR__") MbrVO mbrVO, @PathVariable String strId, Model model) {
		StrVO strVO = strService.readOneStrByMaster(strId);
		model.addAttribute("strVO", strVO);
		model.addAttribute("MbrVO", mbrVO);
		return "str/strdetailmst";
		
	}
	@GetMapping("/str/strdetailmgn/{strId}")
	public String viewStrDetailMgnPage(@SessionAttribute("__MBR__") MbrVO mbrVO, @PathVariable String strId, Model model) {
		if(!mbrVO.getStrId().equals(strId)) {
			throw new IllegalRequestException();
		}
		StrVO strVO = strService.readOneStrByManager(strId);
		model.addAttribute("strVO", strVO);
		model.addAttribute("MbrVO", mbrVO);
		return "str/strdetailmgn";
        
	}
}
