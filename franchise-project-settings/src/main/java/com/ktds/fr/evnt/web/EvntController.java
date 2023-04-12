package com.ktds.fr.evnt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;


@Controller
public class EvntController {  
	
	@Autowired
	private EvntService evntService;
	
	private EvntVO evntVO;
	
	
	//이벤트 생성 페이지
	@GetMapping("/evnt/create")
	public String createEvntPage(Model model) {
		return "evnt/create";
	}
	
	
	//이벤트 목록 조회 페이지
	@GetMapping("/evnt/list3")
	public String viewEvntListPage(Model model, EvntVO evntVO ) {
		List<EvntVO> evntList = evntService.readAllEvnt(evntVO);
		model.addAttribute("evntList", evntList);
		return "evnt/list3";
	}
	
	
	//이벤트 상세 조회페이지
	@GetMapping("/evnt/readOne")
	public String viewEvntOnePage(Model model, EvntVO evntVO) {
		return "evnt/readOne";
	}
	

	//이벤트 수정 페이지  
	@GetMapping("/evnt/update")
	public String updateEvntPage(Model model, EvntVO evntVO) {
		model.addAttribute("evntVO", evntVO);
		return "evnt/update";
	}
	
	//이벤트 수정 post
	@GetMapping("/evnt/detail")
	public String postEvntUpdate(Model model, EvntVO evntVO) {
		model.addAttribute("evntVO", evntVO);
		return "redirect:list3"; // 리스트로 리다이렉트
	}
	
	
	//이벤트 삭제 페이지
	@GetMapping("/evnt/updateDelete")
	public String updatedeleteEvntPage(@PathVariable Model model, EvntVO evntVO) {
		model.addAttribute("envtVO", evntVO);
		return "evnt/updateDelete";
	}
	
	
}