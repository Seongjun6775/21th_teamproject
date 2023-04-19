package com.ktds.fr.hr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class RestHrController {
	
	@Autowired
	private HrService hrService;
	
	@PostMapping("/api/hr/create")
	public ApiResponseVO createNewHr(@SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO
									, MultipartFile uploadFile) {
		
		String hrTtl = hrVO.getHrTtl();
		String hrCntnt = hrVO.getHrCntnt();
		String hrLvl = hrVO.getHrLvl();
		
		if (hrTtl == null || hrTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (hrCntnt == null || hrCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "본문이 누락되었습니다.");
		}
		if (hrLvl == null || hrLvl.trim().length() == 0) {
			throw new ApiArgsException("400", "지원 직군이 누락되었습니다.");
		}
		
		boolean createResult = hrService.createNewHr(hrVO, uploadFile);
		
		if (createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/hr/delete/{hrId}")
	public ApiResponseVO deleteOneHrByHrId(@PathVariable String hrId,
										   @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		HrVO mbrCheck = hrService.readOneHrByHrId(hrId);
		
		if (!mbrVO.getMbrId().equals(mbrCheck.getMbrId())) {
			throw new ApiArgsException("500", "삭제 권한이 없습니다.");
		}
		boolean deleteResult = hrService.deleteOneHrByHrId(hrId);
		
		if (deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/hr/updateapr")
	public ApiResponseVO updateHrAprByHrId(@SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO) {
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			throw new ApiException("500", "권한이 없습니다.");
		}
		
		
		boolean isSuccess = hrService.updateHrAprByHrId(hrVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	
	@PostMapping("/api/hr/update/{hrId}")
	public ApiResponseVO updateOneHrByHrId(@PathVariable String hrId,
										   @SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO) {
		
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		if (!hr.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("500", "권한이 없습니다.");
		}
		
		String hrTtl = hrVO.getHrTtl();
		String hrCntnt = hrVO.getHrCntnt();
		String hrLvl = hrVO.getHrLvl();
		
		if (hrTtl == null || hrTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (hrCntnt == null || hrCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "본문이 누락되었습니다.");
		}
		if (hrLvl == null || hrLvl.trim().length() == 0) {
			throw new ApiArgsException("400", "지원 직군이 누락되었습니다.");
		}
		
		
		boolean isSuccess = hrService.updateOneHrByHrId(hrVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
		
	}
	

}
