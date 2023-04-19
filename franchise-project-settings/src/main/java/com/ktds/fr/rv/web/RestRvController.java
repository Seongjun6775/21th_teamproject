package com.ktds.fr.rv.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.service.RvService;
import com.ktds.fr.rv.vo.RvVO;

@RestController
public class RestRvController {

	@Autowired
	private RvService rvService;
		
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@PostMapping("/api/rv/create")
	public ApiResponseVO doCreateNewRv(RvVO rvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {

		String rvTtl = rvVO.getRvTtl();
		String rvCntnt = rvVO.getRvCntnt();

		rvVO.setMbrId(mbrVO.getMbrId());
		
		if (rvTtl == null || rvTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목을 입력하세요.");
		}

		if (rvCntnt == null || rvCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "내용을 입력하세요.");
		}

		boolean isSuccess = rvService.createNewRv(rvVO);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "/rv/list/", "", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "리뷰를 등록할 수 없습니다.", "500", "");
		}

	}
	
	
	// 3-1.리뷰 목록에서 리뷰 삭제 == 상위관리자, 이용자
	@PostMapping("/api/rv/delete")
	public ApiResponseVO doDeleteAllRv(@RequestParam List<String> rvIdList
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		boolean isDelete = rvService.deleteAllRvListByRvId(rvIdList, mbrVO);
		
		if (isDelete) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	// 3-2.리뷰 상세에서 리뷰 삭제 == 상위관리자, 이용자
	@PostMapping("/api/rv/delete/{rvId}")
	public ApiResponseVO doDeleteOneRv(@PathVariable String rvId
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		boolean isDelete2 = rvService.deleteOneRvVOByRvId(rvId, mbrVO);
		
		if (isDelete2) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
}
