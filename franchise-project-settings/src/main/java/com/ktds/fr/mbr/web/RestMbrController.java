package com.ktds.fr.mbr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.service.MailSendServiceImple;
import com.ktds.fr.mbr.service.MbrService;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestMbrController {
	
	private static final Logger log = LoggerFactory.getLogger(RestMbrController.class);

	
	@Autowired
	private MbrService mbrService;
	
	@Autowired
	private MailSendServiceImple mailService;
	
	@PostMapping("/api/mbr/login")
	public ApiResponseVO doLogin(MbrVO mbrVO, HttpSession session,HttpServletRequest request) {
		if(mbrVO.getMbrId() == null || mbrVO.getMbrId().length() == 0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "아이디 또는 비밀번호를 확인해 주세요.");
		}
		if(mbrVO.getMbrPwd() == null || mbrVO.getMbrPwd().length() == 0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "아이디 또는 비밀번호를 확인해 주세요.");
		}
		mbrVO.setMbrRcntLgnIp(request.getRemoteAddr());
		MbrVO mbr = mbrService.readOneMbrByMbrIdAndMbrPwd(mbrVO);
		if(mbr == null) {
			throw new ApiException("403", "아이디 또는 비밀번호를 확인해 주세요. 5회이상 실패시 계정이 차단됩니다. "+ mbrVO.getMbrLgnFlCnt() + " / 5");
		}else {
			session.setAttribute("__MBR__", mbr);
		}
		return new ApiResponseVO(ApiStatus.OK, "/index");
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
		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK,"/join");
		}else {
			return new ApiResponseVO(ApiStatus.FAIL,"회원등록에 실패하였습니다.","/join");
		}
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

	//인증 메일 보내기
	@PostMapping("/api/mbr/emailSend")
	public ApiResponseVO doCheckAuthNum(@RequestParam String email) {
		log.info("확인용 {}", email);
		if(email == null || email.length() == 0) {
			return new ApiResponseVO(ApiStatus.FAIL, "메일 주소를 확인해 주세요.");
		}
		String authNumber = mailService.makeEamilForm(email);
		return new ApiResponseVO(ApiStatus.OK, authNumber, "");
	}
	
}
