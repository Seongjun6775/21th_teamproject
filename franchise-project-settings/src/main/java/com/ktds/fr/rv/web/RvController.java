package com.ktds.fr.rv.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.service.RvService;
import com.ktds.fr.rv.vo.RvVO;

@Controller
public class RvController {
		
	@Autowired
	private RvService rvService;
	
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@GetMapping("/rv/create")
	public String viewCreateNewRvPage() {		
		return "rv/create";
	}
	
	// 2-1.리뷰 목록 조회 == 상위관리자, 중하위관리자, 이용자
	@GetMapping("/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO);
		
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		
		return "rv/list";
	}
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중하위관리자, 이용자
	@GetMapping("/rv/detail/{rvId}")
	public String viewRvDetailPage(Model model, @PathVariable String rvId
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		model.addAttribute("rvDetail", rvDetail);
		
		return "rv/detail";
	}
		
}


	

