package com.ktds.fr.evntprdt.service;

import java.util.List;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;

public interface EvntPrdtService {

	// 이벤트 적용 품목 확인 ▷상위관리자,중간관리자
		public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO);	
		
	// 상품등록을 위한 상품리스트 가져오기  ▶상위관리자
		public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO);
		
	// 이벤트 상품 선택하여 등록  ▶상위관리자
		public boolean createEvntPrdt(EvntPrdtVO evntPrdtVO);
}
