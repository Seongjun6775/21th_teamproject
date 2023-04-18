package com.ktds.fr.mngrbrd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mngrbrd.service.MngrBrdService;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

@RestController
public class RestMngrBrdController {
	
	@Autowired
	private MngrBrdService mngrBrdService;
	
	@PostMapping("/api/mngrbrd/write")
	public ApiResponseVO doWriteMngrBrd(MngrBrdVO mngrBrdVO,
								@SessionAttribute("__MBR__") MbrVO mbrVO) {
		if(mngrBrdVO.getMngrBrdTtl() ==null || mngrBrdVO.getMngrBrdTtl().trim().length() ==0) {
			throw new ApiArgsException("400", "제목을 입력해주세요.");
		}
		
		if(mngrBrdVO.getMngrBrdCntnt() ==null || mngrBrdVO.getMngrBrdCntnt().trim().length() ==0) {
			throw new ApiArgsException("400", "본문을 입력해주세요.");
		}
		
		mngrBrdVO.setMngrId(mbrVO.getMbrId());
		mngrBrdVO.setMdfyr(mbrVO.getMbrId());
		
		boolean createResult = mngrBrdService.createNewMngrBrd(mngrBrdVO);
		
		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	@GetMapping("/api/mngrbrd/delete/{mngrBrdId}")
	public ApiResponseVO doDeleteMngrBrd(@PathVariable String mngrBrdId,
											MngrBrdVO mngrBrdVO) {
		mngrBrdVO.setMngrBrdId(mngrBrdId);
		boolean deleteResult = mngrBrdService.deleteOneMngrBrd(mngrBrdId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
			
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/mngrbrd/delete")
	public ApiResponseVO doDeleteMngrBrdBySelectedMngrBrdId(@RequestParam List<String> mngrBrdId) {
		boolean deleteResult = mngrBrdService.deleteMngrBrdBySelectedMngrBrdId(mngrBrdId);
		System.out.println(deleteResult);
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
			
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	@PostMapping("/api/mngrbrd/update/{mngrBrdId}")
	public ApiResponseVO doMngrBrdUpdate( MngrBrdVO mngrBrdVO,
								@SessionAttribute("__MBR__") MbrVO mbrVO) {
		mngrBrdVO.setMdfyr(mbrVO.getMbrId());
		boolean updateResult = mngrBrdService.updateOneMngrBrd(mngrBrdVO);
		
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
			
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
}
