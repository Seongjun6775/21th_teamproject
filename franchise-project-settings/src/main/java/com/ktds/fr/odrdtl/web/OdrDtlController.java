package com.ktds.fr.odrdtl.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class OdrDtlController {
	
	@Autowired
	public OdrDtlService odrDtlService;
	
	@Autowired
	public OdrLstService odrLstService;

	@Autowired
	public StrService strService;
	
	@GetMapping("/odrdtl/list/{odrLstId}")
	public String viewOdrDtlListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, @PathVariable String odrLstId, OdrDtlVO odrDtlVO, Model model) {
		
		// 주문서를 작성한 회원의 ID를 받아옵니다.
		OdrLstVO lstMbrId = odrLstService.isThisMyOdrLst(odrLstId);
		
		// 주문서에 접근한 계정이 그 주문서를 작성한 계정인지 확인합니다.
		if (!lstMbrId.getMbrId().equals(mbrVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		// 접근한 계정이 주문서를 작성한 회원 본인일 경우, 회원이 주문한 물품들의 정보를 보여줍니다.
		if (mbrVO.getMbrLvl().equals("001-04")) {
			
			// 접근한 주문서의 모든 물품 목록을 가져옵니다.
			odrDtlVO.setMbrId(mbrVO.getMbrId());
			odrDtlVO.setOdrLstId(odrLstId);
			List<OdrDtlVO> odrDtlList = odrDtlService.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
			
			// 주문서의 주문 상태 역시 함께 가져옵니다. (결제 여부 확인 시에 사용합니다.)
			OdrLstVO odrPrcs = odrLstService.getOdrPrcs(odrLstId);
			
			model.addAttribute("odrDtlList", odrDtlList);
			model.addAttribute("odrLstId", odrLstId);
			model.addAttribute("odrDtlVO", odrDtlVO);
			model.addAttribute("odrPrcs", odrPrcs);
			model.addAttribute("mbrVO", mbrVO);
			
			return "odrdtl/odrdtllist";
		}
		return "redirect:/index";
	}
	
	@GetMapping("/odrdtl/{odrDtlId}")
	public String viewOrdDtlPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, @PathVariable String odrDtlId, Model model) {
		
		// 해당 주문 상세에 대한 정보를 받아옵니다.
		OdrDtlVO odrDtl = odrDtlService.readOneOdrDtlByOdrDtlId(odrDtlId);
		
		// 해당 주문이 포함된 주문서의 주문 상태도 가져옵니다.
		OdrLstVO odrPrcs = odrLstService.getOdrPrcs(odrDtl.getOdrLstId());
		
		// 접근한 계정이 해당 주문 상세의 작성자가 맞는지 확인합니다.
		if (mbrVO.getMbrLvl().equals("001-04") && odrDtl.getMbrId().equals(mbrVO.getMbrId())) {
			model.addAttribute("odrDtl", odrDtl);
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("odrPrcs", odrPrcs);
			
			return "odrdtl/odrdtl";
		}
		return "redirect:/index";
	}
	
	
	
	@GetMapping("/payment")
	public String forSale(Model model, OdrDtlVO odrDtlVO) {
		
		
		List<OdrDtlVO> odrDtlList = odrDtlService.forSale(odrDtlVO);
		
		//상품별
		odrDtlVO.setOrderBy("DESC");
		List<OdrDtlVO> groupPrdt = odrDtlService.groupPrdt(odrDtlVO);
		
		
		List<StrVO> strList = strService.readAll();
		
		
		//매장별
//		List<OdrDtlVO> groupStr = odrDtlService.groupStr(odrDtlVO);
		
		
		
		model.addAttribute("odrDtlVO", odrDtlVO);
		model.addAttribute("strList", strList);
		model.addAttribute("odrDtlList", odrDtlList);
		model.addAttribute("groupPrdt", groupPrdt);
//		model.addAttribute("strGroup", groupStr);
		
		return "odrdtl/payment";
	}

}
