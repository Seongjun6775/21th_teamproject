package com.ktds.fr.str.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiDataResponseVO;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@RestController
public class RestStrController {

	@Autowired
	private StrService strService;
	
	@PostMapping("/api/str/create")
	public ApiResponseVO createNewStr(StrVO strVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		boolean isExistStrNm = strService.readBlockStrNm(strVO.getStrNm());
		
		if(isExistStrNm) {
			throw new ApiArgsException("400", "기존 매장명과 중복이 발생했습니다.");
		}
		
		boolean isExistStrAddr = strService.readBlockStrAddr(strVO.getStrAddr());
		
		if(isExistStrAddr) {
			throw new ApiArgsException("400", "기존 매장주소와 중복이 발생했습니다.");
		}
		
		boolean isExistStrCallNum = strService.readBlockStrCallNum(strVO.getStrCallNum());
		
		if(isExistStrCallNum) {
			throw new ApiArgsException("400", "기존 전화번호와 중복이 발생했습니다.");
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
	 public ApiResponseVO updateOneStrByMaster(StrVO strVO, String strNm, String strAddr, String strCallNum, @SessionAttribute("__MBR__")MbrVO mbrVO) {
		 
//		 boolean isExistStrNm = strService.readBlockStrNm(strNm);
//			
//			if(isExistStrNm) {
//				throw new ApiArgsException("400", "기존 매장명과 중복이 발생했습니다.");
//			}
//			
//			boolean isExistStrAddr = strService.readBlockStrAddr(strAddr);
//			
//			if(isExistStrAddr) {
//				throw new ApiArgsException("400", "기존 매장주소와 중복이 발생했습니다.");
//			}
//			
//			boolean isExistStrCallNum = strService.readBlockStrCallNum(strCallNum);
//			
//			if(isExistStrCallNum) {
//				throw new ApiArgsException("400", "기존 매장번호와 중복이 발생했습니다.");
//			}
//			
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
	 
	 @GetMapping("/api/str/changecty")
	 public ApiDataResponseVO changeCty(String lctId, Model model) {
		
		List<CtyCdVO> ctyChangedList = strService.readCategory(lctId);
		return new ApiDataResponseVO(ApiStatus.OK, ctyChangedList);
		 
	 }
	 
}
