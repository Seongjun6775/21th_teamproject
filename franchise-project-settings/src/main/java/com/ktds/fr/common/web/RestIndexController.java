package com.ktds.fr.common.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.ctycd.service.CtyCdService;
import com.ktds.fr.lctcd.service.LctCdService;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.str.service.StrService;

@Controller
public class RestIndexController {
	
	
	private static final Logger log = LoggerFactory.getLogger(RestIndexController.class);

	
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
	public Map<String, List<OdrDtlVO>> groupStr(@RequestBody OdrDtlVO odrDtlVO, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (!mbrVO.getMbrLvl().equals("001-01") && "".equals(odrDtlVO.getStrVO().getStrId())) {
			// 권한 없음 에러 반환
			// 본사사용자가 아니고 화면에서 지점번호를 가져오지 못햇으면 에러 발생
			return null;
		}

		System.out.println("getStrId : " + odrDtlVO.getStrVO().getStrId());
		System.out.println("getStartDt : " + odrDtlVO.getStartDt());
		System.out.println("getEndDt : " + odrDtlVO.getEndDt());

		List<OdrDtlVO> groupStr = odrDtlService.viewStrPayments(odrDtlVO);
		List<OdrDtlVO> sumYearOfStr = odrDtlService.sumYearOfStr();
		
		for (OdrDtlVO odrDtlVO2 : sumYearOfStr) {
			log.info("매장명 : {}", odrDtlVO2.getStrVO().getStrNm());
			log.info("매출액 {}", odrDtlVO2.getSumPrc());
		}
		
		
		for (int i = 0; i < groupStr.size(); i++) {
			System.out.println(i + " / " + groupStr.get(i).getStrVO().getStrId() + " / "
					+ groupStr.get(i).getStrVO().getStrNm() + " / " + groupStr.get(i).getMdfyDt() + " / "
					+ groupStr.get(i).getSumPrc() + " / " + groupStr.get(i).getSumCnt());
		}
		Map<String, List<OdrDtlVO>> dataGroup = new HashMap<>();
		dataGroup.put("groupStr", groupStr);
		dataGroup.put("sumYearOfStr", sumYearOfStr);
		
		return dataGroup;
	}
}
