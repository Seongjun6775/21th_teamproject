package com.ktds.fr.prdt.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;

@Controller
public class PrdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdtController.class);
	
	@Autowired
	private PrdtService prdtService;
	
	@GetMapping("/prdt/list")
	public String prdtList(PrdtVO prdtVO, Model model) {
		List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
		System.out.println("배열크기는"+prdtList.size());
		
		model.addAttribute("prdtList", prdtList);
//		model.addAttribute("prdtVO", prdtVO);
		
		return "prdt/prdt_list";
	}

}
