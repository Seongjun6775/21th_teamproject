package com.ktds.fr.evntprdt.service;

import java.util.List;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;

public interface EvntPrdtService {

	// 이벤트 적용 품목 확인 ▷상위관리자,중간관리자
		public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO);	
}
