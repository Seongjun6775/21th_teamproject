package com.ktds.fr.mbr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
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
		MbrVO mbr = mbrService.readOneMbrByMbrIdAndMbrPwd(mbrVO);
		if(mbr == null) {
			throw new ApiException("403", "아이디 또는 비밀번호를 확인해 주세요");
		}else {
			
		}
		return new ApiResponseVO(ApiStatus.OK);
	}
	//회원의 회원가입
	@PostMapping("/api/mbr/regist")
	public ApiResponseVO doMbrRegist(MbrVO mbrVO) {
		if( mbrVO.getMbrId()==null || mbrVO.getMbrId().length() == 0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "아이디는 필수값 입니다.");
		}
		if( mbrVO.getMbrPwd() == null || mbrVO.getMbrPwd().length() == 0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "비밀번호는 필수값 입니다.");
		}
		if( mbrVO.getMbrEml() == null || mbrVO.getMbrEml().length() == 0 ) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "이메일은 필수값 입니다.");
		}
		if( mbrVO.getMbrNm() == null || mbrVO.getMbrNm().length() == 0 ) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "이름을 입력해주세요.");
		}
		
		boolean createResult = mbrService.createNewMbr(mbrVO);
		return new ApiResponseVO();
	}
	//회원 아이디 체크
	@GetMapping("/api/mbr/check/{mbrId}")
	public ApiResponseVO doCheckMbrId(@PathVariable String mbrId) {
		if( mbrId ==null || mbrId.length() == 0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "아이디는 필수값 입니다.");
		}
		boolean readResult = mbrService.readCountMbrById(mbrId);
		if(!readResult) {
			//중복아이디 없음
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
}
