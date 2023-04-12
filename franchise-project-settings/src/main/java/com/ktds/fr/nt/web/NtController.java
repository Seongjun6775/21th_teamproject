package com.ktds.fr.nt.web;

import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ktds.fr.nt.service.NtService;
import com.ktds.fr.nt.vo.NtVO;

@Controller
public class NtController {
	
	@Autowired
	private NtService ntService;
	
	@GetMapping("/nt/mstrlist")
	public String viewMstrNtListPage(Model model, NtVO ntVO) {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
		
		List<NtVO> allNtList = ntService.readAllNt(ntVO);
		model.addAttribute("allNtList", allNtList);
		model.addAttribute("ntVO", ntVO);
		
		return "nt/mstrlist";
	}
	
	@GetMapping("/nt/create")
	public String viewNtCreatePage() {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
		
		return "nt/create";
	}
	
	
	@GetMapping("/nt/mstrdetail/{ntId}")
	public String viewMstrNtDetailPage(@PathVariable String ntId,
									   Model model) {
		
		//TODO 세션 받아와서 master 계정 맞는지 확인
		
		
		
		NtVO nt = ntService.readOneNtByNtId(ntId);
		model.addAttribute("nt", nt);
		
		return "nt/mstrdetail";
	}
	
	@GetMapping("nt/update/{ntId}")
	public String viewNtUpdatePage(@PathVariable String ntId,
								   Model model) {
		//TODO 세션 받아와서 master 계정 맞는지 확인
		
		NtVO nt = ntService.readOneNtByNtId(ntId);
		model.addAttribute("nt", nt);
		
		return "nt/update";
	}
	
	

}
