package com.ktds.fr.common.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
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
public class RestIndexController {

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

	// index page 매장 일자별 조회용
	@PostMapping("/api/index/viewStrPayments")
	@ResponseBody
	public List<OdrDtlVO> groupStr(@RequestBody OdrDtlVO odrDtlVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (!mbrVO.getMbrLvl().equals("001-01") && "".equals(odrDtlVO.getStrVO().getStrId())) {
			// 권한 없음 에러 반환
			// 본사사용자가 아니고 화면에서 지점번호를 가져오지 못햇으면 에러 발생
			return null;
		}

		System.out.println("getStrId : " + odrDtlVO.getStrVO().getStrId());
		System.out.println("getStartDt : " + odrDtlVO.getStartDt());
		System.out.println("getEndDt : " + odrDtlVO.getEndDt());

		List<OdrDtlVO> groupStr = odrDtlService.viewStrPayments(odrDtlVO);

		for (int i = 0; i < groupStr.size(); i++) {
			System.out.println(i + " / " + groupStr.get(i).getStrVO().getStrId() + " / "
					+ groupStr.get(i).getStrVO().getStrNm() + " / " + groupStr.get(i).getMdfyDt() + " / "
					+ groupStr.get(i).getSumPrc() + " / " + groupStr.get(i).getSumCnt());
		}

		return groupStr;
	}
}
