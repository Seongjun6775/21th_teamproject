package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@RestController
public class RestOdrDtlController {
	
	@Autowired
	private OdrDtlService odrDtlService;
	
	@PostMapping("/api/odrdtl/delete/{odrLstId}")
	public ApiResponseVO deleteAllOdrDtlByOdrLstId(@PathVariable String odrLstId,
												   @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		// 삭제 요청이 들어온 주문서를 생성한 계정의 ID를 받아옵니다.
		OdrLstVO mbrId = odrDtlService.isThisMyOdrLst(odrLstId);
		// 주문서를 생성한 사람과 삭제를 요청한 사람이 같은 사람인지 확인합니다.
		if (!mbrId.getMbrId().equals(mbrVO.getMbrId())) {
			// 만약 다르다면, 요청을 거부합니다.
			throw new ApiException("400", "권한이 없습니다.");
		}
		
		boolean isSuccess = odrDtlService.deleteAllOdrDtlByOdrLstId(odrLstId);
		
		if (isSuccess) {
			odrDtlService.deleteOneOdrLstByOdrLstId(odrLstId);
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/deleteone/{odrDtlId}")
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
	

}
