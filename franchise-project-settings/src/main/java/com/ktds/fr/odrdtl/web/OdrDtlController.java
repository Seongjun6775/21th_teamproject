package com.ktds.fr.odrdtl.web;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
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
	
	@Autowired
	public CmmnCdService cmmnCdService;
	
	@GetMapping("/odrdtl/list/{odrLstId}")
	public String viewOdrDtlListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, @PathVariable String odrLstId, OdrDtlVO odrDtlVO, Model model) {
		
		// 주문서를 작성한 회원의 ID를 받아옵니다.
		OdrLstVO lstMbrId = odrLstService.isThisMyOdrLst(odrLstId);
		
		// 주문서에 접근한 계정이 그 주문서를 작성한 계정인지 확인합니다.
		if (!lstMbrId.getMbrId().equals(mbrVO.getMbrId())) {
			return "odrdtl/500cannot";
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
	public String forSale(Model model, OdrDtlVO odrDtlVO
						, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			odrDtlVO.setOdrDtlStrId(mbrVO.getStrId());
		}
		
		if(odrDtlVO.getStartDt() == null || odrDtlVO.getStartDt().length()==0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year+ "-" + strMonth + "-" + strDay;
			odrDtlVO.setStartDt(startDt);
		}
		if(odrDtlVO.getEndDt() == null || odrDtlVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + strMonth + "-" + strDay;
			odrDtlVO.setEndDt(endDt);
		}
		
		// 검색용 셀렉트박스 목록... 상품분류 / 매장목록(useYN 둘다)
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		List<StrVO> strList = strService.readAll();
		
		model.addAttribute("odrDtlVO", odrDtlVO);
		model.addAttribute("srtList", srtList);
		model.addAttribute("strList", strList);
		
		
		
		
//		List<OdrDtlVO> odrDtlList = odrDtlService.forSale(odrDtlVO);
//		model.addAttribute("odrDtlList", odrDtlList);
		
		//상품별
		List<OdrDtlVO> groupPrdt = odrDtlService.groupPrdt(odrDtlVO);
		model.addAttribute("groupPrdt", groupPrdt);
		
		//매장별
//		List<OdrDtlVO> groupStr = odrDtlService.groupStr(odrDtlVO);
//		model.addAttribute("strGroup", groupStr);
		
//		List<OdrDtlVO> startEnd = odrDtlService.startEnd(odrDtlVO);
//		model.addAttribute("startEnd", startEnd);
		
		
		
		
		
		return "odrdtl/payment";
	}
	
	
	
	@GetMapping("/payment/monthly")
	public String monthly(Model model, OdrDtlVO odrDtlVO
						, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			odrDtlVO.setOdrDtlStrId(mbrVO.getStrId());
		}
		
		// 검색용 셀렉트박스 목록... 상품분류 / 매장목록(useYN 둘다)
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		List<StrVO> strList = strService.readAll();
		
		model.addAttribute("odrDtlVO", odrDtlVO);
		model.addAttribute("srtList", srtList);
		model.addAttribute("strList", strList);
		
		List<String> monthly = odrLstService.monthly();
		System.out.println(monthly.size());
		model.addAttribute("monthly", monthly);
		
		
		return "odrdtl/payment_monthly";
	}

}
