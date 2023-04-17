package com.ktds.fr.hr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestHrController {
	
	@Autowired
	private HrService hrService;
	
	@PostMapping("/api/hr/create")
	public ApiResponseVO createNewHr(@SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO
									, MultipartFile uploadFile) {
		
		String hrTtl = hrVO.getHrTtl();
		String hrCntnt = hrVO.getHrCntnt();
		
		if (hrTtl == null || hrTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (hrCntnt == null || hrCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "본문이 누락되었습니다.");
		}
		
		
		boolean createResult = hrService.createNewHr(hrVO, uploadFile);
		
		if (createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}

}
