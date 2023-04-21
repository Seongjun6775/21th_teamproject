package com.ktds.fr.evntstr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evntstr.service.EvntStrService;
import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestEvntStrController {

	@Autowired
	private EvntStrService evntStrService;

	// 이벤트 등록 매장 생성

	@PostMapping("/api/evntStr/create")
	public ApiResponseVO createNewEvnt(EvntStrVO evntStrVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) throws Exception {

		// 실행여부 확인
		System.out.println("/api/evntStr/create 호출 확인!!!");
		System.out.println("EvntStrVO.getEvntStrId() : " + evntStrVO.getEvntStrId());
		System.out.println("EvntStrVO.getEvntId() : " + evntStrVO.getEvntId());
		System.out.println("EvntStrVO.getStrId() : " + evntStrVO.getStrId());
		System.out.println("EvntStrVO.getUseYn() : " + evntStrVO.getUseYn());
		System.out.println("EvntStrVO.getEvntId() : " + evntStrVO.getDelYn());

		// FIXME 나중에 중간관리자(매장권한 있을때) 있을 때 쓸것
		String strId = mbrVO.getStrId();
		
		//강제로 값 넣어놓기 (나중에 삭제)
		strId = "ST-20230419-00174";
		
		evntStrVO.setStrId(strId);
		
		boolean isSuccess = evntStrService.createEvntStr(evntStrVO);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "이벤트 참여가 완료되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "이벤트에 참여할 수 없습니다.", "500", "");
		}
	}

	// -----------------공통적용 소스----------------------------

	// 2023-04-09 -> 20230409 로 변환
	public String dateToStr(String dt) {
		return dt.replaceAll("-", "");
	}

	// true/false -> 1/0
	public String boolToNum(String bool) {
		if ("true".equals(bool)) {
			return "1";
		} else {
			return "0";
		}
	}

	// true/false -> Y/N
	public String boolToYn(String bool) {
		if ("true".equals(bool)) {
			return "Y";
		} else {
			return "N";
		}
	}

	/* null 에러 방지 */
	public String nullToStr(Object obj) {
		if (obj == null) {
			return "";
		}
		String str = obj.toString();
		if (str == null || "".equals(str)) {
			return "";
		}
		return str;
	}

}