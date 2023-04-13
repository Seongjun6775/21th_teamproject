package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

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
