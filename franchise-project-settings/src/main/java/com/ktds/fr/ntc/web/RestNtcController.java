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
	
	@PostMapping("/api/ntc/create")
	public ApiResponseVO createContent(NtcVO ntcVO) {
		
		boolean createResult = ntcService.createNotice(ntcVO);
		
		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	@PostMapping("/api/ntc/update")
	public ApiResponseVO updateNotice(NtcVO ntcVO) {
		
		boolean updateResult = ntcService.updateNotice(ntcVO);
		
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	
	@PostMapping("/api/ntc/delete/{ntcId}")
	public ApiResponseVO deleteNotice(String ntcId) {
		
		boolean deleteResult = ntcService.deleteNotice(ntcId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
}
