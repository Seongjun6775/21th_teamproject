package com.ktds.fr.rv.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.rv.service.RvService;

@RestController
public class RestRvController {

	@Autowired
	private RvService rvService;
		
}
