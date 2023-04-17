package com.ktds.fr.hr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Controller
public class HrController {
	
	@Autowired
	private HrService hrService;
	
	@GetMapping("/hr/list")
	public String viewHrPage(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01")) {
			return "redirect:/hr/mstrlist";
		}
		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04")){
			return "redirect:/hr/hrlist";
		}
		else {
			return "redirect:/index";
		}
	}
	
	@GetMapping("/hr/mstrlist")
	public String viewHrMstrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			
			List<HrVO> hrList = hrService.readAllHr();
			model.addAttribute("hrList", hrList);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/mstrlist";
			
		}
		
		return "redirect:/hr/list";
		
	}
	
	@GetMapping("/hr/hrlist")
	public String viewMyHrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								  , Model model) {
		if ((mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04"))) {
			
			List<HrVO> myHrList = hrService.readAllMyHr(mbrVO.getMbrId());
			model.addAttribute("myHrList", myHrList);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/hrlist";
		}
		return "redirect:/hr/list";
	}
	
	@GetMapping("/hr/create")
	public String viewCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, Model model) {
		model.addAttribute("mbrVO", mbrVO);
		return "hr/create";
	}
	

}
