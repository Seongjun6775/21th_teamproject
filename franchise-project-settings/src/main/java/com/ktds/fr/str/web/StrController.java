package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ktds.fr.str.service.StrService;

@Controller
public class StrController {

	@Autowired
	private StrService strService;
}
