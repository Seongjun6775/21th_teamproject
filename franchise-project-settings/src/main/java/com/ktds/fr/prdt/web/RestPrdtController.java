package com.ktds.fr.prdt.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;

@RestController
public class RestPrdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestPrdtController.class);
	
	@Autowired
	private PrdtService prdtService;
	
	@PostMapping("/api/prdt/create")
	public ApiResponseVO create(PrdtVO prdtVO
			, MultipartFile uploadFile
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			) {
		if (mbrVO == null) {
			throw new ApiException("400", "세션에러");			
		}
		
		prdtVO.setPrdtRgstr(mbrVO.getMbrId());
		prdtVO.setMdfyr(mbrVO.getMbrId());

		boolean isSuccess = prdtService.create(prdtVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/prdt/update")
	public ApiResponseVO update(PrdtVO prdtVO
			, MultipartFile uploadFile
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			) {
		prdtVO.setMdfyr(mbrVO.getMbrId());
		
		boolean isSuccess = prdtService.update(prdtVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@GetMapping("/api/prdt/delete/{prdtId}")
	public ApiResponseVO deleteOne(@PathVariable String prdtId) {
		boolean isSuccess = prdtService.deleteOne(prdtId);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/prdt/delete")
	public ApiResponseVO deleteSelectAll(@RequestParam List<String> prdtId) {
		boolean isSuccess = prdtService.deleteSelectAll(prdtId);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}

}
