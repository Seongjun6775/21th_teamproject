package com.ktds.fr.odrlst.web;

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
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.odrlst.vo.OdrLstVO;

@RestController
public class RestOdrLstController {

	@Autowired
	private OdrLstService odrLstService;

	@PostMapping("/api/odrlst/update/{odrLstId}")
	public ApiResponseVO updateOdrPrcsToReadyByOdrLstId(@PathVariable String odrLstId,
														@SessionAttribute("__MBR__") MbrVO mbrVO,
														MbrVO mbrPyMn) {
		// 전달받은 주문서 ID를 기준으로 주문서의 정보를 읽어옵니다.
		OdrLstVO check = odrLstService.readOneOdrLstByOdrLstId(odrLstId);
		// 만약 현재 접속중인 계정이 전달받은 주문서 ID의 주인이 아닐 경우, 접근을 거부합니다.
		if (!check.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("400","권한이 없습니다.");
		}
		
		mbrVO.setMbrPyMn(mbrPyMn.getMbrPyMn());
		
		// 주문서의 상태를 '주문 접수'로 변경합니다.
		boolean isSuccess = odrLstService.updateOdrPrcsToReadyByOdrLstId(odrLstId);
		
		if (isSuccess) {
			// 상태가 성공적으로 변경되었다면, 접속 중인 계정의 페이머니 잔량을 업데이트합니다.
			odrLstService.updateRestMbrPyMn(mbrVO);
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL); 
		}
	}
	
	@PostMapping("/api/odrlst/delete")
	public ApiResponseVO deleteOdrLstBySelectedLstId(@RequestParam List<String> odrLstId) {
		
		boolean isSuccess = odrLstService.deleteOdrLstBySelectedLstId(odrLstId);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrlst/delete/{odrLstId}")
	public ApiResponseVO deleteOneOdrLstByOdrLstId(@PathVariable String odrLstId,
												   @SessionAttribute("__MBR__") MbrVO mbrVO) {
		// 삭제 요청이 들어온 주문서를 생성한 회원 ID를 받아옵니다.
		OdrLstVO mbrId = odrLstService.readOneOdrLstByOdrLstId(odrLstId);
		// 접속한 계정이 주문서를 생성한 회원 본인이 아니라면, 삭제 요청을 거부합니다.
		if (!mbrId.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		
		boolean isSuccess = odrLstService.deleteOneOdrLstByOdrLstId(odrLstId);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	

}
