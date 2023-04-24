package com.ktds.fr.strprdt.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.strprdt.service.StrPrdtService;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@RestController
public class RestStrPrdtController {
	
	@Autowired
	private StrPrdtService strPrdtService;

	@Autowired
	private StrService strService;
	
	@Autowired
	private PrdtService prdtService;
	
	@PostMapping("/api/strprdt/update")
	public ApiResponseVO updateAll(@RequestParam List<String> strPrdtIdList
				, @RequestParam String useYn
				, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		StrPrdtVO strPrdtVO = new StrPrdtVO();
		strPrdtVO.setStrPrdtIdList(strPrdtIdList);
		strPrdtVO.setMdfyr(mbrVO.getMbrId());
		strPrdtVO.setUseYn(useYn);
		
		boolean isSuccess = strPrdtService.update(strPrdtVO);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	

}
