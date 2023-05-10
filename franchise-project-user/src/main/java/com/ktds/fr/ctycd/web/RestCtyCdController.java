package com.ktds.fr.ctycd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.ctycd.service.CtyCdService;
import com.ktds.fr.ctycd.vo.CtyCdVO;

@RestController
public class RestCtyCdController {

	@Autowired
	private CtyCdService ctyService;
	
	@PostMapping("/api/cty/ctyInLct")
	public List<CtyCdVO> ctyList(@RequestBody CtyCdVO ctyVO) {
		List<CtyCdVO> ctyList = ctyService.readCtyInLct(ctyVO.getLctId());
		return ctyList;
	}
	
	
}
