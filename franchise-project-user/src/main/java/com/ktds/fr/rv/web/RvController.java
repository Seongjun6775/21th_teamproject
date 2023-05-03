package com.ktds.fr.rv.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.service.RvService;
import com.ktds.fr.rv.vo.RvVO;
import com.ktds.fr.rv.vo.SearchRvVO;

@Controller
public class RvController {
		
	@Autowired
	private RvService rvService;
	
//	@Autowired
//	private OdrLstService odrLstService;
	
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@GetMapping("/rv/create")
	public String viewCreateNewRvPage(Model model, 
			@SessionAttribute("__MBR__") MbrVO mbrVO) {	
		
//		OdrLstVO odrLstId = odrLstService
		
		return "rv/create";
	}
	
	
	// 2-1-①.리뷰 목록 조회 == 상위관리자, 이용자 (로그인 전)
	@GetMapping("/user/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO, MbrVO mbrVO, SearchRvVO searchRvVO) {
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("searchRvVO", searchRvVO);
		
		return "rv/listForUser";
	}
	
	// 2-1-②.리뷰 목록 조회 == 상위관리자, 이용자 (로그인 후)
	@GetMapping("/mbr/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO, SearchRvVO searchRvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("searchRvVO", searchRvVO);
		
		return "rv/list";
	}
	
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중간관리자, 하위관리자, 이용자 (로그인 전)
	@GetMapping("/user/rv/detail/{rvId}")
	public String viewRvDetailPageForUser(Model model, @PathVariable String rvId, MbrVO mbrVO) {
		
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		model.addAttribute("rvDetail", rvDetail);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		
		return "rv/detailForUser";
	}
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중간관리자, 하위관리자, 이용자 (로그인 후)
	@GetMapping("/mbr/rv/detail/{rvId}")
	public String viewRvDetailPageForMember(Model model, @PathVariable String rvId
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, HttpServletRequest request) {
		
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		model.addAttribute("rvDetail", rvDetail);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		
		return "rv/detail";
	}
		
}
