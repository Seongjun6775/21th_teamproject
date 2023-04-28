package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.str.vo.StrVO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

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
			// 삭제가 성공했을 때, 남아있는 주문 상품이 없다면 주문서도 삭제합니다.
			List<OdrDtlVO> restList = odrDtlService.readAllOdrDtlByOdrLstIdAndMbrId(check);
			if (restList.size() == 0) {
				odrDtlService.deleteOneOdrLstByOdrLstId(check.getOdrLstId());
			}
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
	
	@PostMapping("/api/odrdtl/create/{strPrdtId}")
	public ApiResponseVO createNewOdrDtl(@SessionAttribute("__MBR__") MbrVO mbrVO
										, @PathVariable String strPrdtId, OdrDtlVO odrDtlVO) {
		StrPrdtVO strPrdt = odrDtlService.readOneCustomerByStr(strPrdtId);
		
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
