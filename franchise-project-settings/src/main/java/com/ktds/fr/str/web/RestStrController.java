package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@RestController
public class RestStrController {

	@Autowired
	private StrService strService;
	
	@PostMapping("/api/str/create")
	public ApiResponseVO createNewStr(StrVO strVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
//		String strNm = strVO.getStrNm();
//		String strAddr = strVO.getStrAddr();
//		String strStrCallNum = strVO.getStrCallNum();
//		
//		if(strNm == null || strNm.trim().length() == 1) {
//			throw new ApiArgsException("400", "매장명이 중복되었습니다.");
//		}
//		if(strAddr == null || strAddr.trim().length() == 1) {
//			throw new ApiArgsException("400", "매장주소가 중복되었습니다.");
//		}
//		if(strStrCallNum == null || strStrCallNum.trim().length() == 1) {
//			throw new ApiArgsException("400", "전화번호가 중복되었습니다.");
//		}
//		
		boolean isExist1 = strService.readBlockStrNm(strVO);
		
		if(isExist1) {
			throw new ApiArgsException("400", "기존 매장과 중복이 발생했습니다.");
		}
		
		boolean isExist2 = strService.readBlockStrAddr(strVO);
		
		if(isExist2) {
			throw new ApiArgsException("400", "기존 매장과 중복이 발생했습니다.");
		}
		
		boolean isExist3 = strService.readBlockStrCallNum(strVO);
		
		if(isExist3) {
			throw new ApiArgsException("400", "기존 매장과 중복이 발생했습니다.");
		}
		
		boolean createResult = strService.createOneStr(strVO);
		 if(createResult) {
			 return new ApiResponseVO(ApiStatus.OK);
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
	 @PostMapping("/api/str/update")
	 public ApiResponseVO updateOneStrByMaster(StrVO strVO, @SessionAttribute("__MBR__")MbrVO mbrVO) {
		 
		 boolean updateResult = strService.updateOneStrByMaster(strVO);
		 if(updateResult) {
			 return new ApiResponseVO(ApiStatus.OK);
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
	 @PostMapping("/api/str/update/{strId}")
	 public ApiResponseVO updateOneStrByManager(StrVO strVO, @SessionAttribute("__MBR__")MbrVO mbrVO) {
		 
		 boolean updateResult = strService.updateOneStrByManager(strVO);
		 if(updateResult) {
			 return new ApiResponseVO(ApiStatus.OK);
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
	 @PostMapping("/api/str/delete/{strId}")
	 public ApiResponseVO deleteOneStrByStrId(@PathVariable String strId) {
		 boolean deleteResult = strService.deleteOneStrByStrId(strId);
		 if(deleteResult) {
			 return new ApiResponseVO(ApiStatus.OK);
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
}
