package com.ktds.fr.evnt.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;

@RestController
public class RestEvntController {

	@Autowired
	private EvntService evntService;

	//이벤트 생성
	// @PostMapping("/api/evnt/createNewEvnt")
	@RequestMapping(value = "/api/evnt/createNewEvnt", method = { RequestMethod.GET, RequestMethod.POST })
	public ApiResponseVO createNewEvnt(Model model, HttpServletRequest httpServletRequest) throws Exception {

		try {
			EvntVO evntVO = new EvntVO();

			// create화면으로부터 파라미터 가져오기
			String evntId = httpServletRequest.getParameter("evntId");
			String evntTtl = httpServletRequest.getParameter("evntTtl");
			String evntCntnt = httpServletRequest.getParameter("evntCntnt");
			String evntStrtDt = dateToStr(httpServletRequest.getParameter("evntStrtDt"));
			String evntEndDt = dateToStr(httpServletRequest.getParameter("evntEndDt"));
			String evntPht = httpServletRequest.getParameter("evntPht");
			String useYn = boolToNum(httpServletRequest.getParameter("useYn"));
			String delYn = boolToNum(httpServletRequest.getParameter("delYn"));

			// evntVO 데이터 세팅
			evntVO.setEvntId(evntId);
			evntVO.setEvntTtl(evntTtl);
			evntVO.setEvntCntnt(evntCntnt);
			evntVO.setEvntStrtDt(evntStrtDt);
			evntVO.setEvntEndDt(evntEndDt);
			evntVO.setEvntPht(evntPht);
			evntVO.setUseYn(useYn);
			evntVO.setDelYn(delYn);

			System.out.println("evntId = " + evntId);
			System.out.println("evntTtl = " + evntTtl);
			System.out.println("evntCntnt = " + evntCntnt);
			System.out.println("evntStrtDt = " + evntStrtDt);
			System.out.println("evntEndDt = " + evntEndDt);
			System.out.println("evntPht = " + evntPht);
			System.out.println("useYn = " + useYn);
			System.out.println("delYn = " + delYn);

			boolean isSuccess = evntService.createNewEvnt(evntVO);
			if (isSuccess) {
				return new ApiResponseVO(ApiStatus.OK, "이벤트 등록이 정상적으로 수행되었습니다.", "200", "");
			} else {
				return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 등록할 수 없습니다.", "500", "");
			}
		} catch (Exception e) {
			return new ApiResponseVO(ApiStatus.FAIL, e.toString(), "500", "");
		}
	}
	
	
	//이벤트 수정
	@RequestMapping(value = "/api/evnt/updateEvnt", method = { RequestMethod.GET, RequestMethod.POST })
	public ApiResponseVO updateEvnt(Model model, HttpServletRequest httpServletRequest) throws Exception {
		
		try {
			EvntVO evntVO = new EvntVO();
			
			// create화면으로부터 파라미터 가져오기
			String evntId = httpServletRequest.getParameter("evntId");
			String evntTtl = httpServletRequest.getParameter("evntTtl");
			String evntCntnt = httpServletRequest.getParameter("evntCntnt");
			String evntStrtDt = dateToStr(httpServletRequest.getParameter("evntStrtDt"));
			String evntEndDt = dateToStr(httpServletRequest.getParameter("evntEndDt"));
			String evntPht = httpServletRequest.getParameter("evntPht");
			String useYn = boolToNum(httpServletRequest.getParameter("useYn"));
			String delYn = boolToNum(httpServletRequest.getParameter("delYn"));

			// evntVO 데이터 세팅
			evntVO.setEvntId(evntId);
			evntVO.setEvntTtl(evntTtl);
			evntVO.setEvntCntnt(evntCntnt);
			evntVO.setEvntStrtDt(evntStrtDt);
			evntVO.setEvntEndDt(evntEndDt);
			evntVO.setEvntPht(evntPht);
			evntVO.setUseYn(useYn);
			evntVO.setDelYn(delYn);
			
			System.out.println("evntId = " + evntId);
			System.out.println("evntTtl = " + evntTtl);
			System.out.println("evntCntnt = " + evntCntnt);
			System.out.println("evntStrtDt = " + evntStrtDt);
			System.out.println("evntEndDt = " + evntEndDt);
			System.out.println("evntPht = " + evntPht);
			System.out.println("useYn = " + useYn);
			System.out.println("delYn = " + delYn);

			boolean isSuccess = evntService.updateEvnt(evntVO);
			if (isSuccess) {
				return new ApiResponseVO(ApiStatus.OK, "이벤트 수정이 정상적으로 수행되었습니다.", "200", "");
			} else {
				return new ApiResponseVO(ApiStatus.FAIL, "이벤트를 수정 할 수 없습니다.", "500", "");
			}
		} catch (Exception e) {
			return new ApiResponseVO(ApiStatus.FAIL, e.toString(), "500", "");
		}
			
			
		}
		
	
	
	
	
	//-----------------공통적용 소스---------------------------------------------------------------------------------------

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