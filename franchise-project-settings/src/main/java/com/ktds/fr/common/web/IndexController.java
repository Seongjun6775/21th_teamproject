package com.ktds.fr.common.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.ctycd.service.CtyCdService;
import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.lctcd.service.LctCdService;
import com.ktds.fr.lctcd.vo.LctCdVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class IndexController {
	
	@Autowired
	public OdrDtlService odrDtlService;
	
	@Autowired
	public OdrLstService odrLstService;

	@Autowired
	public StrService strService;
	
	@Autowired
	public CtyCdService ctyCdService;
	
	@Autowired
	public LctCdService lctCdService;
	
	@GetMapping("/index")
	public String viewIndexPage(Model model, OdrDtlVO odrDtlVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		List<StrVO> strList = new ArrayList<StrVO>();
		
		System.out.println(" mbrVO.getStrId() : " + mbrVO.getStrId());
		System.out.println(" mbrVO.getMbrLvl() : " + mbrVO.getMbrLvl());
		
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			odrDtlVO.setOdrDtlStrId(mbrVO.getStrId());
//			odrDtlVO.getStrVO().setStrId(mbrVO.getStrId());

			strList.add(strService.readOneStrByManager(mbrVO.getStrId()));
		} else {
			strList = strService.readAll();
		}

		// 매장별 주문상품 조회 
		odrDtlVO.setOrderBy("DESC");
		List<OdrDtlVO> groupPrdt = odrDtlService.groupPrdt(odrDtlVO);

		List<OdrDtlVO> startEnd = odrDtlService.startEnd(odrDtlVO);
		CtyCdVO ctyCdVO = new CtyCdVO();
		LctCdVO lctCdVO = new LctCdVO();

		List<CtyCdVO> ctyList = ctyCdService.readCategory(ctyCdVO);
		List<LctCdVO> lctList = lctCdService.readCategory(lctCdVO);

		model.addAttribute("startEnd", startEnd);

		model.addAttribute("odrDtlVO", odrDtlVO);
		model.addAttribute("strList", strList);
		model.addAttribute("groupPrdt", groupPrdt);
		model.addAttribute("ctyList", ctyList);
		model.addAttribute("lctList", lctList);

		return "index";
	}
}
