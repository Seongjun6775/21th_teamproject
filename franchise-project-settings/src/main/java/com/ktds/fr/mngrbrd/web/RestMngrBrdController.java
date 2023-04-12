package com.ktds.fr.mngrbrd.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mngrbrd.service.MngrBrdService;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

@RestController
public class RestMngrBrdController {

	private boolean isTestMode = true;
	
	@Autowired
	private MngrBrdService mngrBrdService;
	
	@PostMapping("/mngrbrd/write")
	public ApiResponseVO doMngrBrdWrite(MngrBrdVO mngrBrdVO,
								 @SessionAttribute("__") MbrVO mbrVO) {
		mngrBrdVO.setMngrId(mbrVO.getMbrId());
		
		if (isTestMode) {
			mngrBrdVO.setMngrId("admin");
		}
		mngrBrdVO.setMdfyr(mbrVO.getMbrId());
		boolean createResult = mngrBrdService.createNewMngrBrd(mngrBrdVO);
		
		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	@GetMapping("/mngrbrd/delete/{mngrBrdId}")
	public ApiResponseVO doMngrBrdDelete(@PathVariable String mngrBrdId) {
		boolean deleteResult = mngrBrdService.deleteOneMngrBrd(mngrBrdId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
			
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	@PostMapping("mngrbrd/update")
	public ApiResponseVO doMngrBrdUpdate(@PathVariable String mngrBrdId,
								   MngrBrdVO mngrBrdVO,
								   MbrVO mbrVO) {
		boolean updateResult = mngrBrdService.updateOneMngrBrd(mngrBrdVO);
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
			
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
}
