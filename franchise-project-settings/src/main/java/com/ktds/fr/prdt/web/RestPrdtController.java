package com.ktds.fr.prdt.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;

@RestController
public class RestPrdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestPrdtController.class);
	
	@Autowired
	private PrdtService prdtService;
	
	@PostMapping("/api/prdt/create")
	public ApiResponseVO create(PrdtVO prdtVO
			, MultipartFile uploadFile
//			, @SessionAttribute("__ADMIN__") MbrVO mbrVO
			) {
		
		logger.debug("생성 돌았나");
		System.out.println("생성돌았나");
		// TODO 세션기능 생기면 밑에꺼랑 바꿀것
//		prdtVO.setPrdtRgstr(mbrVO.getMbrId());
//		prdtVO.setMdfyr(mbrVO.getMbrId());

		String nm = prdtVO.getPrdtNm();
		if (nm == null || nm.trim().length() == 0) {
			throw new ApiArgsException("400", "이름이 비었음");
		}
		int prc = prdtVO.getPrdtPrc();
		if (prc== 0) {
			throw new ApiArgsException("400", "가격이 비었음");
		}
		
		// 로그인이 없으므로 등록자/수정자 임의값 입력
		prdtVO.setPrdtRgstr("master");
		prdtVO.setMdfyr("master");
		
		boolean isSuccess = prdtService.create(prdtVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	
	
	@GetMapping("/api/prdt/update")
	public ApiResponseVO update(PrdtVO prdtVO
			, MultipartFile uploadFile
//			, @SessionAttribute("__ADMIN__") MbrVO mbrVO
			) {
		// TODO 세션기능 생기면 밑에꺼랑 바꿀것
//		prdtVO.setMdfyr(mbrVO.getMbrId());
		
		prdtVO.setPrdtSrt("테스트용분류");
		
		String srt = prdtVO.getPrdtNm();
		if (srt == null || srt.trim().length() == 0) {
			throw new ApiArgsException("400", "분류가 누락되었습니다.");
		}
		String nm = prdtVO.getPrdtNm();
		if (nm == null || nm.trim().length() == 0) {
			throw new ApiArgsException("400", "이름이 누락되었습니다.");
		}
		int prc = prdtVO.getPrdtPrc();
		if (prc== 0) {
			throw new ApiArgsException("400", "가격이 누락되었습니다.");
		}
		// 로그인이 없으므로 수정자 임의값 입력
		prdtVO.setMdfyr("mdfyr-tester");
		
		boolean isSuccess = prdtService.update(prdtVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@GetMapping("/api/prdt/delete/{prdtId}")
	public ApiResponseVO deleteOne(@PathVariable String prdtId) {
		if (prdtId==null || prdtId.trim().length() == 0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		boolean isSuccess = prdtService.deleteOne(prdtId);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/prdt/delete")
	public ApiResponseVO deleteSelectAll(@RequestParam List<String> prdtIdList) {
		if (prdtIdList.size()==0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		boolean isSuccess = prdtService.deleteSelectAll(prdtIdList);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}

}