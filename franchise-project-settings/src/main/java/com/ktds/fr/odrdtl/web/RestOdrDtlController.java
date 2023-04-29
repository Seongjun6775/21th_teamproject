package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.strprdt.service.StrPrdtService;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@RestController
public class RestOdrDtlController {
	
	@Autowired
	private OdrDtlService odrDtlService;
	
	@Autowired
	private StrPrdtService strPrdtService;
	
	@PostMapping("/api/odrdtl/delete/{odrLstId}")
	public ApiResponseVO deleteAllOdrDtlByOdrLstId(@PathVariable String odrLstId,
												   @SessionAttribute("__MBR__") MbrVO mbrVO, OdrDtlVO odrDtlVO) {
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrLstId(odrLstId);
		boolean isSuccess = odrDtlService.deleteAllOdrDtlByOdrLstId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/deleteone/{odrDtlId}")
	public ApiResponseVO deleteOneOdrDtlByOdrDtlId(@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId, OdrDtlVO odrDtlVO) {
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlId(odrDtlId);
		boolean isSuccess = odrDtlService.deleteOneOdrDtlByOdrDtlId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/update/{odrDtlId}")
	public ApiResponseVO updateOneOdrDtlByOdrDtlId (@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId, OdrDtlVO odrDtlVO) {
		
//		OdrDtlVO check = odrDtlService.readOneOdrDtlByOdrDtlId(odrDtlId);
//		if (!check.getMbrId().equals(mbrVO.getMbrId())) {
//			throw new ApiException("400", "권한이 없습니다.");
//		}
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlId(odrDtlId);
		boolean isSuccess = odrDtlService.updateOneOdrDtlByOdrDtlId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	@PostMapping("/api/odrdtl/create/{strPrdtId}")
	public ApiResponseVO createNewOdrDtl(@SessionAttribute("__MBR__") MbrVO mbrVO
										, @PathVariable String strPrdtId, OdrDtlVO odrDtlVO) {
		StrPrdtVO strPrdt = strPrdtService.readOneCustomerByStr(strPrdtId);
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlStrId(strPrdt.getStrId());
		odrDtlVO.setOdrDtlPrdtId(strPrdt.getPrdtId());
		
		boolean isSuccess = odrDtlService.createNewOdrDtl(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	
	
	// 매장에서 보는 주문서의 디테일 / 노 페이지네이션
	@PostMapping("/api/odrLst/odrDtl")
	@ResponseBody
	public List<OdrDtlVO> readCtyStrList(@RequestParam String odrLstId) {
		List<OdrDtlVO> odrDtlList = odrDtlService.odrDtlForOdrLst(odrLstId);
		System.out.println(odrLstId + " / " + odrDtlList.size());
		return odrDtlList;
	}
	

}
