package com.ktds.fr.hr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ktds.fr.hr.service.HrService;

@Controller
public class HrController {
	
	@Autowired
	private HrService hrService;

}
