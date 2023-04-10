package com.ktds.fr.rv.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.ktds.fr.rv.service.RvService;

@Controller
public class RvController {

	@Autowired
	private RvService rvService;
	
	@GetMapping("/rv/create")
	public String viewRvCreatePage() {
		return "/rv/create";
	}
}
