package com.ktds.fr.nt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.nt.service.NtService;
import com.ktds.fr.nt.vo.NtVO;

@Controller
public class NtController {
	
	@Autowired
	private NtService ntService;
	
	@GetMapping("/nt/mstrlist")
	public String viewMstrNtListPage(@SessionAttribute("__MBR__") MbrVO mbrVO,
									Model model, NtVO ntVO) {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
//		if (mbrVO.getMbrLvl().equals("MEMBER")) {
//			return "/index";
//		}
		ntVO.setSndrId(mbrVO.getMbrId());
		List<NtVO> allNtList = ntService.readAllNt(ntVO);
		
		model.addAttribute("allNtList", allNtList);
		model.addAttribute("ntVO", ntVO);
		
		return "nt/mstrlist";
	}
	
	@GetMapping("/nt/create")
	public String viewNtCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO, Model model) {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
//		if (mbrVO.getMbrLvl().equals("MEMBER")) {
//			return "/index";
//		}
		
		model.addAttribute("mbrVO", mbrVO);
		
		return "nt/create";
	}
	
	
	@GetMapping("/nt/mstrdetail/{ntId}")
	public String viewMstrNtDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO, 
									   @PathVariable String ntId, Model model) {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
//		if (mbrVO.getMbrLvl().equals("MEMBER")) {
//			return "/index";
//		}
		
		NtVO nt = ntService.readOneNtByNtId(ntId);
		model.addAttribute("nt", nt);
		
		return "nt/mstrdetail";
	}
	
	@GetMapping("nt/update/{ntId}")
	public String viewNtUpdatePage(@SessionAttribute("__MBR__") MbrVO mbrVO, 
								   @PathVariable String ntId, Model model) {
		//TODO 세션 받아와서 master 계정 맞는지 확인
//		if (mbrVO.getMbrLvl().equals("MEMBER")) {
//			return "/index";
//		}
		
		NtVO nt = ntService.readOneNtByNtId(ntId);
		model.addAttribute("nt", nt);
		
		return "nt/update";
	}
	
	@GetMapping("/nt/mngrlist")
	public String viewMngrNtListPage(@SessionAttribute("__MBR__") MbrVO mbrVO,
									 Model model, NtVO ntVO){
		//TODO 세션 받아와서 Manager 계정 맞는지 확인
		
		ntVO.setRcvrId(mbrVO.getMbrId());
		List<NtVO> myNtList = ntService.readAllMyNt(ntVO);
		model.addAttribute("myNtList", myNtList);
		
		return "nt/mngrlist";
	}
	
	@GetMapping("/nt/mngrdetail/{ntId}")
	public String viewMngrNtDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO,
									   @PathVariable String ntId,
									   Model model) {
		//TODO 세션 받아와서 Manger 계정 맞는지 확인
		
		
		
		return "nt/mngrdetail";
	}
	
	

}
