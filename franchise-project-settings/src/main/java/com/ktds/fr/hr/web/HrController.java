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
	
//	@GetMapping("/hr/list")
//	public String viewHrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
//								, Model model) {
//		if (mbrVO.getMbrLvl().equals("001-01")) {
//			List<HrVO> hrList = hrService.readAllHr();
//			model.addAttribute("hrList", hrList);
//			return "hr/list";
//		}
//		
//	}

}
