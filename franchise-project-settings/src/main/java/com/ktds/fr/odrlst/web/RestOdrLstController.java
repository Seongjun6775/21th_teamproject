package com.ktds.fr.odrlst.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.odrlst.service.OdrLstService;

@RestController
public class RestOdrLstController {
	
	@Autowired
	private OdrLstService odrLstService;
	
	

}
