package com.ktds.fr.ntc.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.ntc.service.NtcService;
import com.ktds.fr.ntc.vo.NtcVO;

@RestController
public class RestNtcController {
	
	@Autowired
	private NtcService ntcService;
	
	@PostMapping("/api/ntc/create/{ntcCntnt}")
	public ApiResponseVO createNewNtcContent(String ntcCntnt) {
		
		boolean createResult = ntcService.createNoticeContent(ntcCntnt);
		
		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/ntc/create/{ntcTtl}")
	public ApiResponseVO createNewNtcTitle(String ntcTtl) {
		
		boolean createResult2 = ntcService.createNoticeTitle(ntcTtl);
		
		if(createResult2) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/ntc/update/{ntcTtl}")
	public ApiResponseVO updateNoticeTitle(String ntcTtl) {
		
		boolean updateResult = ntcService.updateNoticeContent(ntcTtl);
		
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	@PostMapping("/api/ntc/update/{ntcCntnt}")
	public ApiResponseVO updateNoticeContent(String ntcCntnt) {
		
		boolean updateResult2 = ntcService.updateNoticeContent(ntcCntnt);
		
		if(updateResult2) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	@PostMapping("/api/ntc/delete/{ntcId}")
	public ApiResponseVO deleteNotice(String ntcId) {
		
		boolean deleteResult = ntcService.deleteNoticeByNoticeId(ntcId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
}
