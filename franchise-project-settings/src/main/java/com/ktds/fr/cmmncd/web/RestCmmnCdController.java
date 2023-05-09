package com.ktds.fr.cmmncd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;

@RestController
public class RestCmmnCdController {

	@Autowired
	private CmmnCdService cmmnCdService;
	
	@GetMapping("/api/cmmnCd/prdtSrt") 
	public List<CmmnCdVO> prdtSrt() {
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		return srtList;
	}
	
}
