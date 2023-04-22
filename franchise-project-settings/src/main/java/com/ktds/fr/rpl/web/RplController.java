package com.ktds.fr.rpl.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;
import com.ktds.fr.rpl.service.RplService;
import com.ktds.fr.rpl.vo.RplVO;


@Controller
public class RplController {
	
	@Autowired
	private RplService rplService;
	
	@GetMapping("/rpl/list")
	public String viewRplListPage(Model model, RplVO rplVO, MngrBrdVO mngrBrd,
							@SessionAttribute("__MBR__") MbrVO mbrVO,
							@RequestParam(required = false,defaultValue="")String searchIdx,
							@RequestParam(required = false,defaultValue="")String searchKeyword,
							HttpServletRequest request){
		
	if(!mbrVO.getMbrLvl().equals("001-01")) {
		String referer = request.getHeader("Referer");
		 return "redirect:"+ referer;
	}
	
	if(searchIdx.equals("rplCntnt")){ 
		rplVO.setRplCntnt(searchKeyword);
	}		
	if(searchIdx.equals("Wrtr")) {
		rplVO.setMbrVO(new MbrVO());
		rplVO.getMbrVO().setMbrNm(searchKeyword);
	}
	if(searchIdx.equals("mngrBrdTtl")) {
		rplVO.setMngrbrdVO(new MngrBrdVO());
		rplVO.getMngrbrdVO().setMngrBrdTtl(searchKeyword);
	}
		List<RplVO> rplList = rplService.readAllRpls(rplVO);
		model.addAttribute("rplList", rplList);
		model.addAttribute("mngrBrd", mngrBrd);
		model.addAttribute("mbrVO", mbrVO);
		
		model.addAttribute("searchIdx", searchIdx);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "rpl/list";
	}
	
	

}
