package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.str.service.StrService;

@RestController
public class RestStrController {

	@Autowired
	private StrService strService;
}
