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
	
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@GetMapping("/mbr/rv/create")
	public String viewCreateNewRvPage() {		
		return "rv/create";
	}
	
	// 2-1-ⓛ.리뷰 목록 조회 == 중간관리자, 하위관리자
//	@GetMapping("/rv/list/store")
//	public String viewRvListStorePage(Model model, RvVO rvVO, SearchRvVO searchRvVO
//			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
//		
//		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
//			searchRvVO.setMbrVO(mbrVO);
//			List<RvVO> rvList = rvService.readAllRvListForManager(searchRvVO);
//
//			model.addAttribute("rvList", rvList);
//			model.addAttribute("rvVO", rvVO);
//			return "rv/listOfStore";
//		}
//		
//			return "rv/listOfStore";		
//	}
	
	// 2-1-②.리뷰 목록 조회 == 상위관리자, 이용자
	@GetMapping("/user/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO, SearchRvVO searchRvVO
			, MbrVO mbrVO) {
		
//		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
//			return this.viewRvListStorePage(model, rvVO, searchRvVO, mbrVO);
//		}	
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		/* model.addAttribute("mbr", mbr); */
				
		return "rv/list";
	}
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중하위관리자, 하위관리자, 이용자
	@GetMapping("/user/rv/detail/{rvId}")
	public String viewRvDetailPage(Model model, @PathVariable String rvId
			, MbrVO mbrVO
			,HttpServletRequest request) {
		 
			RvVO rvVO = new RvVO();
			rvVO.setRvId(rvId);
			RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
			
//			if (rvDetail != null && !rvDetail.getStrVO().getStrId().equals(mbrVO.getStrId())) {
//				return "rv/error_page";
//				
//			} else if (rvDetail == null) {
//				return "rv/error_page";
//			}
							
			model.addAttribute("rvDetail", rvDetail);
			return "rv/detail";
		}
				
	}
