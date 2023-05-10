package com.ktds.fr.odrdtl.web;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.service.OdrDtlService;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;
import com.ktds.fr.strprdt.service.StrPrdtService;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@RestController
public class RestOdrDtlController {
	
	@Autowired
	private OdrDtlService odrDtlService;
	
	@Autowired
	private StrPrdtService strPrdtService;
	
	@Autowired
	private StrService strService ;
	
	@PostMapping("/api/odrdtl/delete/{odrLstId}")
	public ApiResponseVO deleteAllOdrDtlByOdrLstId(@PathVariable String odrLstId,
												   @SessionAttribute("__MBR__") MbrVO mbrVO, OdrDtlVO odrDtlVO) {
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrLstId(odrLstId);
		boolean isSuccess = odrDtlService.deleteAllOdrDtlByOdrLstId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/deleteone/{odrDtlId}")
	public ApiResponseVO deleteOneOdrDtlByOdrDtlId(@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId, OdrDtlVO odrDtlVO) {
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlId(odrDtlId);
		boolean isSuccess = odrDtlService.deleteOneOdrDtlByOdrDtlId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/odrdtl/update/{odrDtlId}")
	public ApiResponseVO updateOneOdrDtlByOdrDtlId (@SessionAttribute("__MBR__") MbrVO mbrVO
												, @PathVariable String odrDtlId, OdrDtlVO odrDtlVO) {
		
//		OdrDtlVO check = odrDtlService.readOneOdrDtlByOdrDtlId(odrDtlId);
//		if (!check.getMbrId().equals(mbrVO.getMbrId())) {
//			throw new ApiException("400", "권한이 없습니다.");
//		}
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlId(odrDtlId);
		boolean isSuccess = odrDtlService.updateOneOdrDtlByOdrDtlId(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	@PostMapping("/api/odrdtl/create/{strPrdtId}")
	public ApiResponseVO createNewOdrDtl(@SessionAttribute("__MBR__") MbrVO mbrVO
										, @PathVariable String strPrdtId, OdrDtlVO odrDtlVO) {
		StrPrdtVO strPrdt = strPrdtService.readOneCustomerByStr(strPrdtId);
		
		odrDtlVO.setMbrId(mbrVO.getMbrId());
		odrDtlVO.setOdrDtlStrId(strPrdt.getStrId());
		odrDtlVO.setOdrDtlPrdtId(strPrdt.getPrdtId());
		
		boolean isSuccess = odrDtlService.createNewOdrDtl(odrDtlVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
	}
	
	
	
	// 매장에서 보는 주문서의 디테일 / 노 페이지네이션
	@PostMapping("/api/odrLst/odrDtl")
	@ResponseBody
	public List<OdrDtlVO> readCtyStrList(@RequestParam String odrLstId) {
		List<OdrDtlVO> odrDtlList = odrDtlService.odrDtlForOdrLst(odrLstId);
		System.out.println(odrLstId + " / " + odrDtlList.size());
		return odrDtlList;
	}
	
	
	
	// 매출조회용
	@PostMapping("/api/payment/groupPrdt")
	@ResponseBody
	public List<OdrDtlVO> groupPrdt(@RequestBody OdrDtlVO odrDtlVO) {
		List<OdrDtlVO> groupPrdt = odrDtlService.groupPrdt(odrDtlVO);
		return groupPrdt;
	}
	
	// 매장별 매출조회용
	@PostMapping("/api/payment/groupStr")
	@ResponseBody
	public List<OdrDtlVO> groupStr(@RequestBody OdrDtlVO odrDtlVO) {
		System.out.println("getLctId : " + odrDtlVO.getCtyCdVO().getLctId());
		System.out.println("getCtyId : " + odrDtlVO.getCtyCdVO().getCtyId());
		System.out.println("getStartDt : " + odrDtlVO.getStartDt());
		System.out.println("getEndDt : " + odrDtlVO.getEndDt());
		
		List<OdrDtlVO> groupStr = odrDtlService.groupStr(odrDtlVO);
		
//		for ( int i = 0 ; i < groupStr.size(); i++ ) {
//			System.out.println(i + " / " + groupStr.get(i).getLctCdVO().getLctId()
//			+ " / " + groupStr.get(i).getLctCdVO().getLctNm()
//			+ " / " + groupStr.get(i).getCtyCdVO().getCtyId()
//			+ " / " + groupStr.get(i).getCtyCdVO().getCtyNm()
//			+ " / " + groupStr.get(i).getStrVO().getStrId()
//			+ " / " + groupStr.get(i).getStrVO().getStrNm());
//		}
		
		return groupStr;
	}
	
	
	@PostMapping("/api/payment/startEnd")
	@ResponseBody
	public List<OdrDtlVO> startEnd(@RequestBody OdrDtlVO odrDtlVO) {
		List<OdrDtlVO> startEnd = odrDtlService.startEnd(odrDtlVO);
		return startEnd;
	}
	
	@PostMapping("/api/payment/sumMonth")
	@ResponseBody
	public List<OdrDtlVO> monthly(@RequestBody OdrDtlVO odrDtlVO) {
		List<OdrDtlVO> sumMonth = odrDtlService.sumMonth(odrDtlVO);
		return sumMonth;
	}
	
	@PostMapping("/api/payment/sumYear")
	@ResponseBody
	public List<OdrDtlVO> sumYear(@RequestBody OdrDtlVO odrDtlVO) {
		List<OdrDtlVO> sumYear = odrDtlService.sumYear(odrDtlVO);
		return sumYear;
	}
	
	
	@PostMapping("/api/index/paymentPrdtOneWeek")
	@ResponseBody
	public List<OdrDtlVO> groupSrtCdId(@RequestBody OdrDtlVO odrDtlVO) {
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		String strMonth = twoDigits(month);
		String strDay = twoDigits(day);
		String endDt = year + "-" + strMonth + "-" + strDay;
		odrDtlVO.setEndDt(endDt);
		
		cal.add(Calendar.DATE, -6);
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH) + 1;
		day = cal.get(Calendar.DAY_OF_MONTH);
		
		strMonth = twoDigits(month);
		strDay = twoDigits(day);
		String startDt = year+ "-" + strMonth + "-" + strDay;
		odrDtlVO.setStartDt(startDt);
		
		List<OdrDtlVO> groupPrdt;
		if(odrDtlVO.getPrdtVO().getPrdtSrt() == null || odrDtlVO.getPrdtVO().getPrdtSrt().equals("")) {
			groupPrdt = odrDtlService.groupSrtCdId(odrDtlVO);
		} else {
			groupPrdt = odrDtlService.groupPrdt(odrDtlVO);
		}
		return groupPrdt;
	}
	
	
	
	
	private String twoDigits(int num) {
		return num < 10 ? "0" + num : num + "";
	}
	
	

}
