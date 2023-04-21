package com.ktds.fr.hlpdsk.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.hlpdsk.service.HlpDskService;
import com.ktds.fr.hlpdsk.vo.HlpDskVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestHlpDskController {
	
	@Autowired
	private HlpDskService hlpDskService; 
	
	
	@PostMapping("/api/hlpdsk/write")
	public ApiResponseVO doWriteHlpDsk(HlpDskVO hlpDskVO,
					@SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		if(hlpDskVO.getHlpDskSbjct() ==null || hlpDskVO.getHlpDskSbjct().trim().length() ==0) {
			throw new ApiArgsException("400", "글 분류를 선택해주세요.");
		}
		if(hlpDskVO.getHlpDskTtl() ==null || hlpDskVO.getHlpDskTtl().trim().length() ==0) {
		throw new ApiArgsException("400", "제목을 입력해주세요.");
		}
		
		if(hlpDskVO.getHlpDskCntnt()==null || hlpDskVO.getHlpDskCntnt().trim().length() ==0) {
		throw new ApiArgsException("400", "본문을 입력해주세요.");
		}
		
		hlpDskVO.setMbrId(mbrVO.getMbrId());
		
		boolean createResult = hlpDskService.createNewHlpDsk(hlpDskVO);
		
		if(createResult) {
		return new ApiResponseVO(ApiStatus.OK);
		}
		else {
		return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/hlpdsk/update/{hlpDskWrtId}")
	public ApiResponseVO doUpdateHlpDskBySelectedHlpDskId(HlpDskVO hlpDskVO,
										@SessionAttribute("__MBR__") MbrVO mbrVO) {
		boolean updateResult = hlpDskService.updateNewHlpDsk(hlpDskVO);
		System.out.println(updateResult);
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	@GetMapping("/api/hlpdsk/delete/{hlpDskWrtId}")
	public ApiResponseVO doDeleteHlpDsk(@PathVariable String hlpDskWrtId,HlpDskVO hlpDskVO) {

		hlpDskVO.setMbrId(hlpDskWrtId);
		boolean deleteResult = hlpDskService.deleteOneHlpDsk(hlpDskWrtId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/hlpdsk/delete")
	public ApiResponseVO doDeleteHlpDskBySelectedHlpDskId(@RequestParam List<String> shlpDskWrtId) {
		boolean deleteResult = hlpDskService.deleteHlpDskBySelectedHlpDskId(shlpDskWrtId);
		System.out.println(deleteResult);
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	
}
