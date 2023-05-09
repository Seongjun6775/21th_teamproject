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
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
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
	
	@Autowired
	private OdrDtlService odrDtlService;
	
	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@GetMapping("/mbr/rv/create")
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
	
	// 2-1-①.리뷰 목록 조회 == 상위관리자, 이용자 (로그인 전)
	@GetMapping("/user/rv/list")
	public String viewRvListPageForUser(Model model, RvVO rvVO, MbrVO mbrVO, SearchRvVO searchRvVO) {
		
		List<RvVO> rvList = rvService.readAllRvList(rvVO, mbrVO, searchRvVO);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("searchRvVO", searchRvVO);
		
		return "rv/listForUser";
	}
	
	// 2-1-②.리뷰 목록 조회 == 상위관리자, 이용자 (로그인 후)
	@GetMapping("/mbr/rv/list")
	public String viewRvListPageForMember(Model model, RvVO rvVO, SearchRvVO searchRvVO
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
	public String viewRvDetailPageForUser(Model model, @PathVariable String rvId
			, MbrVO mbrVO, OdrDtlVO odrDtlVO) {
		
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		odrDtlVO.setMbrId(rvDetail.getMbrId());
		odrDtlVO.setOdrLstId(rvDetail.getOdrLstId());
		List<OdrDtlVO> odrDtl = odrDtlService.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
		
		model.addAttribute("rvDetail", rvDetail);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("odrDtl", odrDtl);
		
		return "rv/detailForUser";
	}
	
	// 2-2.리뷰 상세 조회 == 상위관리자, 중간관리자, 하위관리자, 이용자 (로그인 후)
	@GetMapping("/mbr/rv/detail/{rvId}")
	public String viewRvDetailPageForMember(Model model, @PathVariable String rvId
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, HttpServletRequest request, OdrDtlVO odrDtlVO) {
		
		RvVO rvVO = new RvVO();
		rvVO.setRvId(rvId);
		RvVO rvDetail = rvService.readOneRvVO(rvVO, mbrVO);
		
		odrDtlVO.setMbrId(rvDetail.getMbrId());
		odrDtlVO.setOdrLstId(rvDetail.getOdrLstId());
		List<OdrDtlVO> odrDtl = odrDtlService.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
		
		model.addAttribute("rvDetail", rvDetail);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("rvVO", rvVO);
		model.addAttribute("odrDtl", odrDtl);
		
		return "rv/detail";
	}
		
}
