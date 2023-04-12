package com.ktds.fr.evnt.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;


@Controller
public class EvntController {  
	@Autowired
	private EvntService evntService;
	
	private EvntVO evntVO;
	
	
	//이벤트 생성 페이지
	@RequestMapping(value = "/evnt/create", method = { RequestMethod.GET, RequestMethod.POST })
	public String createEvntPage(Model model, HttpServletRequest httpServletRequest) {
		return "evnt/create";
	}
	
	
	//이벤트 목록 조회 페이지
	@RequestMapping(value = "/evnt/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewEvntListPage(Model model, HttpServletRequest httpServletRequest) {
		List<EvntVO> evntList = evntService.readAllEvnt(evntVO);
		model.addAttribute("evntList", evntList);
		return "evnt/list";
			}
	
	
	//이벤트 상세 조회페이지
	@RequestMapping(value = "/evnt/detail", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewEvntOnePage(Model model, HttpServletRequest httpServletRequest) {
		return "evnt/detail";
	}
	

	//이벤트 수정 페이지
	@RequestMapping(value = "/evnt/update_popup", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateEvntPage(Model model, HttpServletRequest httpServletRequest) {
		System.out.println("출력 입니다.");
		return "evnt/update_popup";
	}
	
	
	//이벤트 삭제 페이지
	@RequestMapping(value = "/evnt/updateDelete", method = { RequestMethod.GET, RequestMethod.POST })
	public String updatedeleteEvntPage(Model model, HttpServletRequest httpServletRequest) {
		return "evnt/updateDelete";
	}
	
	
}