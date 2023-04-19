package com.ktds.fr.evntstr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evntstr.service.EvntStrService;
import com.ktds.fr.evntstr.vo.EvntStrVO;

@RestController
public class RestEvntStrController {

	@Autowired
	private EvntStrService EvntStrService;

	// 이벤트 생성

	@PostMapping("/api/evntStr/create")
	public ApiResponseVO createNewEvnt(EvntStrVO EvntStrVO) throws Exception {

		// 실행여부 확인
		System.out.println("/api/evntStr/create 호출 확인!!!");
		System.out.println("EvntStrVO.getEvntStrId() : " + EvntStrVO.getEvntStrId());
		System.out.println("EvntStrVO.getEvntId() : " + EvntStrVO.getEvntId());
		System.out.println("EvntStrVO.getStrId() : " + EvntStrVO.getStrId());
		System.out.println("EvntStrVO.getUseYn() : " + EvntStrVO.getUseYn());
		System.out.println("EvntStrVO.getEvntId() : " + EvntStrVO.getDelYn());

		boolean isSuccess = true;//EvntStrService.createNewEvntStr(EvntStrVO);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "이벤트 등록이 정상적으로 수행되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 등록할 수 없습니다.", "500", "");
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