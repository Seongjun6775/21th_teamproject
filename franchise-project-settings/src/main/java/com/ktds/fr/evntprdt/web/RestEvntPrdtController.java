package com.ktds.fr.evntprdt.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.evntprdt.service.EvntPrdtService;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.prdt.vo.PrdtVO;

@RestController
public class RestEvntPrdtController {

   @Autowired
   private EvntPrdtService evntPrdtService;

   //이벤트 상품 등록
   
	
	  @PostMapping("/api/evntPrdt/create") 
	  public ApiResponseVO createNewEvntPrdt(EvntPrdtVO evntPrdtVO) throws Exception {
	  
	  //실행여부 확인 System.out.println("/api/evntPrdt/create 호출 확인!!!");
		
		/*
		 * System.out.println("evntVO.getEvntId() : " + evntPrdtVO.getEvntId());
		 * System.out.println("evntVO.getEvntTtl() : " + evntPrdtVO.getPrdtId());
		 * System.out.println("evntVO.getEvntCntnt() : " +
		 * evntPrdtVO.getEvntPrdtChngPrc());
		 */
		 
		
	  boolean isSuccess = evntPrdtService.createEvntPrdt(evntPrdtVO); 
	  if (isSuccess) {
		  return new ApiResponseVO(ApiStatus.OK, "상품 등록이 정상적으로 수행되었습니다.", "200", "");
	  } else { 
		  return new ApiResponseVO(ApiStatus.FAIL, "해당 상품을 등록할 수 없습니다.", "500",""); }
	  }
	  	 
   
   //-----------------공통적용 소스----------------------------

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