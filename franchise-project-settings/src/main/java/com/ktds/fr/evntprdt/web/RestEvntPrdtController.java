package com.ktds.fr.evntprdt.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evntprdt.service.EvntPrdtService;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestEvntPrdtController {

	@Autowired
	private EvntPrdtService evntPrdtService;

	// 이벤트 상품 등록

	@PostMapping("/api/evntPrdt/create")
	public ApiResponseVO createNewEvntPrdt(EvntPrdtVO evntPrdtVO) throws Exception {

		// 실행여부 확인 System.out.println("/api/evntPrdt/create 호출 확인!!!");

		/*
		 * System.out.println("evntVO.getEvntId() : " + evntPrdtVO.getEvntId());
		 * System.out.println("evntVO.getEvntTtl() : " + evntPrdtVO.getPrdtId());
		 * System.out.println("evntVO.getEvntCntnt() : " +
		 * evntPrdtVO.getEvntPrdtChngPrc());
		 */

		// boolean isSuccess = 저거를 불러오는 코드 == 0;

		System.out.println(evntPrdtVO.getPrdtId());
		System.out.println(evntPrdtVO.getEvntId());

//		evntPrdtVO.setPrdtId(null);
//		evntPrdtVO.setEvntStrtDt(null);
//		evntPrdtVO.setEvntEndDt(null);

		boolean isSuccess = evntPrdtService.chkEvntPrdt(evntPrdtVO).size() == 0;

		if (isSuccess) {
			evntPrdtService.createEvntPrdt(evntPrdtVO);
		}
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK, "상품 등록이 정상적으로 수행되었습니다.", "200", "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL, "해당 상품을 등록할 수 없습니다.", "500", "");
		}
	}

	// 이벤트상품 등록 삭제
	@PostMapping("/api/evntPrdt/delete")
	public ApiResponseVO doDeleteOurEvnt(@RequestParam List<String> evntPrdtIdList,
			@SessionAttribute("__MBR__") MbrVO mbrVO) {
		boolean isDelete = evntPrdtService.deleteEvntPrdtListByEvntId(evntPrdtIdList, mbrVO);

		if (isDelete) {
			return new ApiResponseVO(ApiStatus.OK);
		} else {
			return new ApiResponseVO(ApiStatus.FAIL);
		}
	}
	
	
	
	// 이벤트 상품 등록 2
	@PostMapping("/api/evntPrdt/createCheckedEvntPrdtList")
	public ApiResponseVO doCreateEvntPrdtList(@RequestParam List<String> prdtId, 
			@RequestParam List<String> evntPrdtChngPrc,
			@RequestParam String evntId,
			@SessionAttribute("__MBR__") MbrVO mbrVO) {
		
		List<EvntPrdtVO> listEvntPrdt = new ArrayList<>();
		EvntPrdtVO evntPrdtVO;
		
		System.out.println(prdtId.size() + "//" + evntPrdtChngPrc.size());
		
		for (int i=0 ; i<prdtId.size() ; i++) {
			evntPrdtVO = new EvntPrdtVO();
			evntPrdtVO.setEvntId(evntId);
			evntPrdtVO.setPrdtId(prdtId.get(i));
			System.out.println(evntId + "/aaaaaaa/" + prdtId.get(i) );
			if (evntPrdtService.chkEvntPrdt(evntPrdtVO).size() != 0) {
				System.out.println("continue");
				continue;
			}
			
			int price = Integer.parseInt(evntPrdtChngPrc.get(i).replaceAll("," ,  ""));
			evntPrdtVO.setEvntPrdtChngPrc(price);
			listEvntPrdt.add(evntPrdtVO);
		}
			System.out.println(listEvntPrdt.size() + "배열크기가 몇이냐");
			if (listEvntPrdt.size() == 0) {
				return new ApiResponseVO(ApiStatus.FAIL);
			}
			
		
//		for(int i = 0 ; i < evntPrdtList.size() ; i ++) {
//			EvntPrdtVO evntPrdtVO = new EvntPrdtVO();
//			evntPrdtVO.setEvntPrdtId(evntPrdtList.get(i));
//			evntPrdtVO.setEvntPrdtChngPrc(Integer.parseInt(evntPrdtPriceList.get(i)));
//			//evntPrdtVO.setEvntId();	
			
//			listEvntPrdt.add(evntPrdtVO);					
//		}
//				
//		
//		for (int i = 0 ; i < evntPrdtList.size() ; i ++ ) {
//			System.out.println("상품리스트 : " + evntPrdtList.get(i));
//			System.out.println("변경 가격 : " + evntPrdtPriceList.get(i));
//		}
		
//
	boolean isSuccess = evntPrdtService.createEvntPrdtListByEvntId(listEvntPrdt, mbrVO);
//
		if (isSuccess) {
 		return new ApiResponseVO(ApiStatus.OK, "요청량:" + prdtId.size() + " / 작업량:" + listEvntPrdt.size(), "");
		} else {
			return new ApiResponseVO(ApiStatus.FAIL);		}
	}

	// -----------------공통적용 소스----------------------------

	// 2023-04-09 -> 20230409 로 변환
	public String dateToStr(String dt) {
		return dt.replaceAll("-", "");
	}

	// true/false -> 1/0
	public String boolToNum(String bool) {
		if ("true".equals(bool)) {
			return "1";
		} else {
			return "0";
		}
	}

	// true/false -> Y/N
	public String boolToYn(String bool) {
		if ("true".equals(bool)) {
			return "Y";
		} else {
			return "N";
		}
	}

	/* null 에러 방지 */
	public String nullToStr(Object obj) {
		if (obj == null) {
			return "";
		}
		String str = obj.toString();
		if (str == null || "".equals(str)) {
			return "";
		}
		return str;
	}

}