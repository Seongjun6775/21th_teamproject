package com.ktds.fr.strprdt.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;
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
	
	@PostMapping("/api/strprdt/listCheck")
	public ApiResponseVO listCheck(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		StrPrdtVO strPrdtVO = null;
		List<PrdtVO> missingPrdtList = null;
		List<StrPrdtVO> strPrdtList = new ArrayList<>();
		List<StrVO> strList = strService.readAll();
		
		for (StrVO str : strList) {
			// 각 매장의 누락된 상품목록 가져오기 
			missingPrdtList = strPrdtService.missingList(str.getStrId());
			if (missingPrdtList.size() == 0) {
				continue;
			}
			for (PrdtVO prdt : missingPrdtList) {
				strPrdtVO = new StrPrdtVO();
				strPrdtVO.setPrdtId(prdt.getPrdtId());
				strPrdtVO.setStrId(str.getStrId());
				strPrdtVO.setMdfyr(mbrVO.getMbrId());
				strPrdtList.add(strPrdtVO);
			}
		}
		if (strPrdtList.size() == 0) {
			throw new ApiArgsException("500", "누락 항목 없음");
		}
		
		boolean isSuccess = strPrdtService.create(strPrdtList);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "업데이트 완료 : " + strPrdtList.size() + "건", null);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	

}
