package com.ktds.fr.hr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.hr.service.HrService;

@RestController
public class RestHrController {
	
	@Autowired
	private HrService hrService;

}
