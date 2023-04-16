package com.ktds.fr.rpl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rpl.service.RplService;
import com.ktds.fr.rpl.vo.RplVO;

@RestController
public class RestRplController {
	
	private boolean isTestMode = true;
	
	@Autowired
	private RplService replyService;
	
	@PostMapping("/api/mngrbrd/rpl/create")
	public ApiResponseVO doCreateRpl(RplVO rplVO, MbrVO mbrVO) {
		rplVO.setMbrId(mbrVO.getMbrId());
		
		if (isTestMode) {
			rplVO.setMbrId("admin");
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
	public ApiResponseVO doUpdateRpl(@PathVariable String rplId,
									RplVO rplVO,
									MbrVO mbrVO) {
		if (isTestMode) {
			rplVO.setMbrId("admin");
		}
		
		boolean updateResult = replyService.updateOneRpl(rplVO);
		
		if(updateResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	@PostMapping("/api/mngrbrd/rpl/delete/{mngrbrdId}/{rplId}")
	public ApiResponseVO doDeleteRpl(@PathVariable String rplId, @PathVariable String mngrbrdId) {
		boolean deleteResult = replyService.deleteOneRplByRplId(rplId);
		
		if(deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
}
