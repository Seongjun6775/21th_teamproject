package com.ktds.fr.evnt.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

@RestController
public class RestEvntController {

	@Autowired
	private EvntService evntService;

	// 이벤트 생성
	@PostMapping("/api/evnt/create")
	public ApiResponseVO createNewEvnt(EvntVO evntVO, MultipartFile uploadFile) throws Exception {

		// 실행여부 확인
		System.out.println("/api/evnt/create 호출 확인!!!");
		System.out.println("evntVO.getEvntId() : " + evntVO.getEvntId());
		System.out.println("evntVO.getEvntTtl() : " + evntVO.getEvntTtl());
		System.out.println("evntVO.getEvntCntnt() : " + evntVO.getEvntCntnt());
		System.out.println("evntVO.getEvntStrtDt() : " + evntVO.getEvntStrtDt());
		System.out.println("evntVO.getEvntEndDt() : " + evntVO.getEvntEndDt());
		System.out.println("evntVO.getUseYn() : " + evntVO.getUseYn());
		System.out.println("evntVO.getDelYn() : " + evntVO.getDelYn());
		
		if (uploadFile != null) {
			System.out.println("uploadFile.getOriginalFilename() : " + uploadFile.getOriginalFilename());
			System.out.println("uploadFile.getSize() : " + uploadFile.getSize());
			System.out.println("uploadFile.getContentType() : " + uploadFile.getContentType());
		}

		boolean isSuccess = evntService.createNewEvnt(evntVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "이벤트 등록이 정상적으로 수행되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 등록할 수 없습니다.", "500", "");
		}
	}

	// 이벤트 수정
	@PostMapping("/api/evnt/update")
	public ApiResponseVO updateEvnt(EvntVO evntVO, MultipartFile uploadFile) throws Exception {

		// 실행여부 확인
		System.out.println("/api/evnt/update 호출 !!!");
		System.out.println("evntVO.getEvntId() : " + evntVO.getEvntId());
		System.out.println("evntVO.getEvntTtl() : " + evntVO.getEvntTtl());
		System.out.println("evntVO.getEvntCntnt() : " + evntVO.getEvntCntnt());
		System.out.println("evntVO.getEvntStrtDt() : " + evntVO.getEvntStrtDt());
		System.out.println("evntVO.getEvntEndDt() : " + evntVO.getEvntEndDt());
		System.out.println("evntVO.getUseYn() : " + evntVO.getUseYn());
		System.out.println("evntVO.getDelYn() : " + evntVO.getDelYn());
		
		if (uploadFile != null) {
			System.out.println("uploadFile.getOriginalFilename() : " + uploadFile.getOriginalFilename());
			System.out.println("uploadFile.getSize() : " + uploadFile.getSize());
			System.out.println("uploadFile.getContentType() : " + uploadFile.getContentType());
		}
		
		boolean isSuccess = evntService.updateEvnt(evntVO, uploadFile);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "이벤트 수정이 정상적으로 수행되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 수정 할 수 없습니다.", "500", "");
		}
	}

	// 이벤트 삭제
	@PostMapping("/api/evnt/delete")
	public ApiResponseVO updatedeleteEvntPage(String evntId) throws Exception {

		/*
		 * System.out.println("/api/evnt/update 호출 !!!");
		 * System.out.println("evntVO.getEvntId() : " + evntVO.getEvntId());
		 * System.out.println("evntVO.getEvntTtl() : " + evntVO.getEvntTtl());
		 * System.out.println("evntVO.getEvntCntnt() : " + evntVO.getEvntCntnt());
		 */

		boolean isSuccess = evntService.updateDeleteEvnt(evntId);
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "이벤트 삭제가 정상적으로 수행되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 삭제 할 수 없습니다.", "500", "");
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