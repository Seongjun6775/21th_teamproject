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
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.rv.service.RvService;
import com.ktds.fr.rv.vo.RvVO;
import com.ktds.fr.rv.vo.SearchRvVO;

@Controller
public class RvController {
		
	@Autowired
	private RvService rvService;
	
	@Autowired
	private OdrLstService odrLstService;
	
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@GetMapping("/rv/create")
	public String viewCreateNewRvPage(Model model,
			@SessionAttribute("__MBR__") MbrVO mbrVO) {	
		
		List<OdrLstVO> odrLst = odrLstService.getOdrLstIdForRv(mbrVO.getMbrId());
		model.addAttribute("odrLst", odrLst);
		model.addAttribute("mbrVO", mbrVO);
		
		return "rv/create";
	}
	
	// 1-2.주문 완료된 주문서에서 '리뷰 작성' 버튼을 눌러 리뷰 등록 == 이용자
		@GetMapping("/rv/create/{odrLstId}")
		public String viewCreateNewRvPage(Model model,
				@SessionAttribute("__MBR__") MbrVO mbrVO,
				@PathVariable String odrLstId) {	
			
			List<OdrLstVO> odrLst = odrLstService.getOdrLstIdForRv(mbrVO.getMbrId());
			// 주문서 페이지에서 주문서 ID를 PathVariable로 받아와 넣어줍니다. 이외에는 1-1과 같습니다.
			model.addAttribute("odrLstId", odrLstId);
			model.addAttribute("odrLst", odrLst);
			model.addAttribute("mbrVO", mbrVO);
			
			return "rv/create";
		}
	
	// 2-1-ⓛ.리뷰 목록 조회 == 중간관리자, 하위관리자
	@GetMapping("/rv/list/store")
	public String viewRvListStorePage(Model model, RvVO rvVO, SearchRvVO searchRvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			searchRvVO.setMbrVO(mbrVO);
			List<RvVO> rvList = rvService.readAllRvListForManager(searchRvVO);

			model.addAttribute("rvList", rvList);
			model.addAttribute("rvVO", rvVO);
			return "rv/listOfStore";
		}
		
			return "rv/listOfStore";		
	}
	
	// 2-1-②.리뷰 목록 조회 == 상위관리자, 이용자
	@GetMapping("/rv/list")
	public String viewRvListPage(Model model, RvVO rvVO, SearchRvVO searchRvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("searchRvVO", searchRvVO);
		
		return "rv/list";
	}
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중간관리자, 하위관리자, 이용자
	@GetMapping("/rv/detail/{rvId}")
	public String viewRvDetailPage(Model model, @PathVariable String rvId
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			,HttpServletRequest request) {
		
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			RvVO rvVO = new RvVO();
			rvVO.setRvId(rvId);
			RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
			
			if (rvDetail != null && !rvDetail.getStrVO().getStrId().equals(mbrVO.getStrId())) {
				return "rv/error_page";
				
			} else if (rvDetail == null) {
				return "rv/error_page";
			}
							
			model.addAttribute("rvDetail", rvDetail);
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("rvVO", rvVO);
			
			return "rv/detail";
		}
		
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		model.addAttribute("rvDetail", rvDetail);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("rvVO", rvVO);
		
		return "rv/detail";
	}
		

	// ★★★★★ 여기서부터는 이용자 페이지입니다. ★★★★★
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
		@GetMapping("/user/rv/create")
		public String viewCreateNewRvPage2(Model model,
				@SessionAttribute("__MBR__") MbrVO mbrVO) {	
			
			List<OdrLstVO> odrLst = odrLstService.getOdrLstIdForRv(mbrVO.getMbrId());
			model.addAttribute("odrLst", odrLst);
			model.addAttribute("mbrVO", mbrVO);
			
			return "rv/create2";
		}
	//2-1-①.리뷰 목록 조회 == 상위관리자, 이용자 (로그인 후)
	@GetMapping("/user/rv/list")
	public String viewRvListPage2(Model model, RvVO rvVO, SearchRvVO searchRvVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("searchRvVO", searchRvVO);
		
		return "rv/list2";
	}
	// 2-2.리뷰 상세 조회 == 상위관리자, 중간관리자, 하위관리자, 이용자 (로그인 후)
		@GetMapping("/user/rv/detail/{rvId}")
		public String viewRvDetailPage2(Model model, @PathVariable String rvId
				, @SessionAttribute("__MBR__") MbrVO mbrVO
				, HttpServletRequest request) {
			
			RvVO rvVO = new RvVO();
			rvVO.setRvId(rvId);
			RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
			
			model.addAttribute("rvDetail", rvDetail);
			model.addAttribute("rvVO", rvVO);
			model.addAttribute("mbrVO", mbrVO);
			
			return "rv/detail2";
		}

}
	

