package com.ktds.fr.nt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.nt.service.NtService;
import com.ktds.fr.nt.vo.NtVO;

@RestController
public class RestNtController {
	
	@Autowired
	private NtService ntService;
	
	@PostMapping("/api/nt/delete")
	public ApiResponseVO deleteNtBySelectedNtId(@RequestParam List<String> ntId) {
		boolean deleteResult = ntService.deleteNtBySelectedNtId(ntId);
		if (deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/nt/delete/{ntId}")
	public ApiResponseVO deleteOneNtByNtId(@PathVariable String ntId) {
		boolean deleteResult = ntService.deleteOneNtByNtId(ntId);
		if (deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/nt/create")
	public ApiResponseVO createNewNt(NtVO ntVO) {
		
		String rcvrId = ntVO.getRcvrId();
		String ntTtl = ntVO.getNtTtl();
		String ntCntnt = ntVO.getNtCntnt();
		
		if (rcvrId == null || rcvrId.trim().length() == 0) {
			throw new ApiArgsException("400", "수신인이 누락되었습니다.");
		}
		if (ntTtl == null || ntTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (ntCntnt == null || ntCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "내용이 누락되었습니다.");
		}
		
		boolean isSuccess = ntService.createNewNt(ntVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	@PostMapping("/api/nt/update/{ntId}")
	public ApiResponseVO updateOneNtByNtId(@PathVariable String ntId ,NtVO ntVO) {
		
		ntVO.setNtId(ntId);
		
		String ntTtl = ntVO.getNtTtl();
		String ntCntnt = ntVO.getNtCntnt();
		
		if (ntTtl == null || ntTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		
		if (ntCntnt == null || ntCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "내용이 누락되었습니다.");
		}
		
		boolean isSuccess = ntService.updateOneNtByNtId(ntVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	

}
