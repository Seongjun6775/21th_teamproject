package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@RestController
public class RestOdrDtlController {
	
	@Autowired
	private OdrDtlService odrDtlService;
	
	@PostMapping("/api/odrdtl/delete")
	public ApiResponseVO deleteOdrDtlBySelectedDtlId(@RequestParam List<String> odrDtlId) {
		
		boolean isSuccess = odrDtlService.deleteOdrDtlBySelectedDtlId(odrDtlId);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/delete/{odrDtlId}")
	public ApiResponseVO deleteOneOdrDtlByOdrDtlId(@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId) {
		
		OdrDtlVO check = odrDtlService.readOneOdrDtlByOdrDtlId(odrDtlId);
		if (!check.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		
		boolean isSuccess = odrDtlService.deleteOneOdrDtlByOdrDtlId(odrDtlId);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/update/{odrDtlId}")
	public ApiResponseVO updateOneOdrDtlByOdrDtlId (@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId, OdrDtlVO odrDtlVO) {
		
		OdrDtlVO check = odrDtlService.readOneOdrDtlByOdrDtlId(odrDtlId);
		if (!check.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		odrDtlVO.setOdrDtlId(odrDtlId);
		boolean isSuccess = odrDtlService.updateOneOdrDtlByOdrDtlId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	

}
