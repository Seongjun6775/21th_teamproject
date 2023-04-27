package com.ktds.fr.mbr.web;

import java.util.Enumeration;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.service.MailSendService;
import com.ktds.fr.mbr.service.MbrService;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestMbrController {
	
	private static final Logger log = LoggerFactory.getLogger(RestMbrController.class);

	
	@Autowired
	private MbrService mbrService;
	
	@Autowired
	private MailSendService mailService;

	//회원 로그인
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
			mbr.setMbrRcntLgnIp(request.getRemoteAddr());
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
	//회원 정보 수정
	@PostMapping("/api/mbr/update")
	public ApiResponseVO doUpdateOneMbr(MbrVO mbrVO, @SessionAttribute("__MBR__")MbrVO mbr) {
		boolean updateResult = mbrService.updateOneMbr(mbrVO);
		if(!updateResult) {
			throw new ApiException(ApiStatus.FAIL, "회원정보 수정에 실패하였습니다.");
		}else {
			mbr.setMbrNm(mbrVO.getMbrNm());
		}
		return new ApiResponseVO(ApiStatus.OK,"/mbr/info");
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
	//회원 비밀번호 체크
	@PostMapping("/api/mbr/pwd/check")
	public ApiResponseVO doCheckMbrPwd(@SessionAttribute("__MBR__") MbrVO mbrVO, @RequestParam String mbrPwd) {
		if(mbrPwd == null || mbrPwd.length()==0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "비밀번호는 필수값 입니다.");
		}
		mbrVO.setMbrPwd(mbrPwd);
		MbrVO mbr = mbrService.readOneMbrByPwd(mbrVO);
		if(mbr == null) {
			throw new ApiException("403", "비밀번호가 맞지 않습니다.");
		}
		else {
			return new ApiResponseVO(ApiStatus.OK, "/mbr/info");
		}
	}
	//회원 비밀번호 변경
	@PostMapping("/api/mbr/pwd/update")
	public ApiResponseVO doChangeMbrPwd(@SessionAttribute("__MBR__")MbrVO mbrVO,
										@RequestParam String mbrPwd,
										@RequestParam String newMbrPwd) {
		if(mbrPwd == null || mbrPwd.length()==0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "비밀번호는 필수값 입니다.");
		}
		if(newMbrPwd == null || newMbrPwd.length()==0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "새 비밀번호는 필수값 입니다.");
		}
		mbrVO.setMbrPwd(mbrPwd);
		MbrVO mbr = mbrService.readOneMbrByPwd(mbrVO);
		if(mbr==null) {
			throw new ApiException("403", "비밀번호가 맞지 않습니다.");
		}
		else {
			mbrVO.setMbrPwd(newMbrPwd);
			boolean updateResult = mbrService.updateOneMbrPwd(mbrVO);
			if(!updateResult) {
				throw new ApiException(ApiStatus.FAIL, "비밀번호 변경에 실패하였습니다.");
			}
		}
		return new ApiResponseVO(ApiStatus.OK,"/logout");
	}
	//회원탈퇴
	@GetMapping("/api/mbr/signout")
	public ApiResponseVO doSignout(@SessionAttribute("__MBR__")MbrVO mbrVO) {
		boolean deleteResult = mbrService.deleteOneMbr(mbrVO.getMbrId());
		if(!deleteResult) {
			throw new ApiException(ApiStatus.FAIL, "회원 탈퇴에 실패했습니다. 다시 시도해주세요.");
		}else {
			return new ApiResponseVO(ApiStatus.OK,"/logout");
		}
	}
	//인증 메일 보내기
	@PostMapping("/api/mbr/emailSend")
	public ApiResponseVO doCheckAuthNum(@RequestParam String email) {
		if(email == null || email.length() == 0) {
			return new ApiResponseVO(ApiStatus.FAIL, "메일 주소를 확인해 주세요.");
		}
		String authNumber = mailService.makeEmailForm(email);
		return new ApiResponseVO(ApiStatus.OK, authNumber, "");
	}
	//ID/PW 찾기
	@PostMapping("/api/mbr/find")
	public ApiResponseVO doFindMbrId(@RequestParam String email,
									   @RequestParam String type,
									   @RequestParam(required = false) String mbrId) {
		if(email == null || email.length() == 0) {
			throw new ApiException(ApiStatus.FAIL, "메일 주소를 확인해 주세요.");
		}
		MbrVO mbrVO = new MbrVO();
		mbrVO.setMbrEml(email);
		List<MbrVO> mbrIdList = mbrService.readMbrByMbrEml(mbrVO);
		if(mbrIdList == null) {
			throw new ApiException(ApiStatus.FAIL, "메일 주소를 확인해 주세요.");
		}
		if(type.equals("id")) {
			mailService.makeFindIdEmailForm(email, mbrIdList);
			return new ApiResponseVO(ApiStatus.OK,"/join");
		}else if(type.equals("pw")) {
			if(mbrId == null || mbrId.length()==0) {
				throw new ApiArgsException(ApiStatus.MISSING_ARGS, "아이디를 확인해 주세요.");
			}
			mbrVO.setMbrId(mbrId);
			Random random = new Random();
			String randomNumber = random.nextInt(99999999)+1+"";
			mbrVO.setMbrPwd(randomNumber);
			boolean updateResult = mbrService.updateMbrPwdByMbrIdAndMbrEml(mbrVO);
			if(!updateResult) {
				throw new ApiException(ApiStatus.FAIL, "비밀번호 찾기에 실패했습니다. 다시 시도해 주세요.");
			}
			mbrVO.setMbrPwd(randomNumber);
			mailService.makeFindPwEmailForm(mbrVO);
			return new ApiResponseVO(ApiStatus.OK,"/join");
			
		}
		return new ApiResponseVO(ApiStatus.FAIL,"계정 찾기에 실패했습니다.");
	}
	//권한및 소속 변경
	@PostMapping("/api/mbr/update/admin")
	public ApiResponseVO doUpdateAdmin(MbrVO mbrVO, @SessionAttribute("__MBR__")MbrVO session){
		if((mbrVO.getStrId() == null || mbrVO.getStrId().length() == 0) && (mbrVO.getMbrLvl() == null || mbrVO.getMbrLvl().length() == 0)) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "변경하려는 값을 선택 해 주세요.");
		}
		mbrVO.setMdfyr(session.getMbrNm());
		boolean updateResult = mbrService.updateOneMbrLvlAndStrId(mbrVO);
		if(!updateResult) {
			throw new ApiException(ApiStatus.FAIL, "변경에 실패했습니다. 다시 시도해주세요.");
		}
		return new ApiResponseVO(ApiStatus.OK);
	}
	//권한 해임
	@PostMapping("/api/mbr/admin/fire")
	public ApiResponseVO doFireAdmin(@SessionAttribute("__MBR__")MbrVO mbrVO,@RequestParam List<String> mbrIdList) {
		if(mbrIdList == null || mbrIdList.size()==0) {
			throw new ApiArgsException(ApiStatus.MISSING_ARGS, "해임하려는 직원을 다시 확인해 주세요.");
		}
		boolean delResult = mbrService.deleteAllMbrAdminByMbrId(mbrVO, mbrIdList);
		if(!delResult) {
			throw new ApiException(ApiStatus.FAIL, "관리자 해임에 실패했습니다. 다시 시도해주세요."); 
		}
		return new ApiResponseVO(ApiStatus.OK);
	}
	
}
