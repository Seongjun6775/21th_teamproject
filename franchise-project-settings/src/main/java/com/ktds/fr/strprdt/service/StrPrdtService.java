package com.ktds.fr.strprdt.service;

import java.util.List;

import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface StrPrdtService {

	// 전체 조회 (전체 / 각 매장별)
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtVO);
	
	// 매장의 물품 조회 - 손님용
	public List<StrPrdtVO> readAllCustomerByStr(String strId);
	
	// 매장별 누락물품 조회
	public List<PrdtVO> missingList(String strId);
	
	// 메뉴등록시, 매장등록시 목록생성에 활용
	public boolean create(List<StrPrdtVO> strPrdtList);
		
	// 매장별 메뉴 사용유무
	public boolean update(StrPrdtVO strPrdtVO);

	
}
