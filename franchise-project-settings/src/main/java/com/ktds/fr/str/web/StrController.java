package com.ktds.fr.str.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class StrController {

	@Autowired
	private StrService strService;
	
	@GetMapping("/str/list")
	public String viewStrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO, Model model, StrVO strVO) {

	    if (mbrVO.getMbrLvl().equals("001-01")) {
	        List<StrVO> strList = strService.readAllStrMaster(strVO);
	        model.addAttribute("strList", strList);
	        model.addAttribute("StrVO", strVO);
	        return "str/list";
	        
	    } else if (mbrVO.getMbrLvl().equals("001-02")) {
	    	 model.addAttribute("MbrVO", mbrVO);
	        return "redirect:/str/detail/" + mbrVO.getStrId();
	        
	    } else {
	        return "redirect:/index";
	    }
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
