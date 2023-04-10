package com.ktds.fr.mbr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.mbr.service.MbrService;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestMbrController {
	
	@Autowired
	private MbrService mbrService;
	
	@PostMapping("/api/mbr/login")
	public ApiResponseVO doLogin(MbrVO mbrVO) {
		//TODO 필수값 체크, 세션, 
		//비밀번호 있는지 체크
		//
		return new ApiResponseVO();
	}
	//회원의 회원가입
	@PostMapping("/api/mbr/regist")
	public ApiResponseVO doMbrRegist(MbrVO mbrVO) {
		boolean createResult = mbrService.createNewMbr(mbrVO);
		return new ApiResponseVO();
	}
}
