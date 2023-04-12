package com.ktds.fr.str.web;

import org.springframework.beans.factory.annotation.Autowired;
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
	public ApiResponseVO createNewStr(StrVO strVO, MultipartFile uploadFile , @SessionAttribute("__ADMIN__") MbrVO mbrVO) {
		
		boolean ctrateResult = strService.createOneStr(strVO, uploadFile);
		 if(ctrateResult) {
			 return new ApiResponseVO(ApiStatus.OK, "/str/detail/" + strVO.getStrId());
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
	 @PostMapping("/api/str/update")
	 public ApiResponseVO updateOneStrByMaster(StrVO strVO, MultipartFile uploadFile, @SessionAttribute("__ADMIN__")MbrVO mbrVO) {
		 
		 boolean updateResult = strService.updateOneStrByMaster(strVO, uploadFile);
		 if(updateResult) {
			 return new ApiResponseVO(ApiStatus.OK, "/str/detail/" + strVO.getStrId());
		 }
		 else{
			 return new ApiResponseVO(ApiStatus.FAIL);
		 }
	 }
	 
}
