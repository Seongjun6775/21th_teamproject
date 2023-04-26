package com.ktds.fr.rpl.web;

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
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rpl.service.RplService;
import com.ktds.fr.rpl.vo.RplVO;

@RestController
public class RestRplController {
	
	@Autowired
	private RplService replyService;
	
	@PostMapping("/api/mngrbrd/rpl/create")
	public ApiResponseVO doCreateRpl(RplVO rplVO, 
							@SessionAttribute("__MBR__") MbrVO mbrVO) {
		rplVO.setMbrId(mbrVO.getMbrId());
		
		if(rplVO.getRplCntnt() ==null || rplVO.getRplCntnt().trim().length() ==0) {
			throw new ApiArgsException("400", "내용을 입력해주세요.");
		}
		boolean createResult = replyService.createNewRpl(rplVO);

		if(createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/mngrbrd/rpl/update/{rplId}")
	public ApiResponseVO doUpdateRpl(RplVO rplVO,
						@SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		boolean updateResult = replyService.updateOneRpl(rplVO);
		
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@GetMapping("/api/mngrbrd/rpl/delete/{rplId}")
	public ApiResponseVO doDeleteRpl(@PathVariable String rplId) {
		boolean deleteResult = replyService.deleteOneRplByRplId(rplId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/rpl/delete")
	public ApiResponseVO doDeleteRplBySelectedRplId(@RequestParam List<String> rplId) {
		boolean deleteResult = replyService.deleteRplBySelectedRplId(rplId);
		System.out.println(deleteResult);
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
}
