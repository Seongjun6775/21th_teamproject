package com.ktds.fr.mbr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.ktds.fr.mbr.service.MbrService;

@Controller
public class MbrController {

	@Autowired
	private MbrService mbrService;
	
	@GetMapping("/login")
	public String viewLoginPage() {
		return "mbr/login";
	}
	@GetMapping("/regist")
	public String viewMbrRegistPage() {
		return "mbr/mbr_regist";
	}
	
	
	
}
