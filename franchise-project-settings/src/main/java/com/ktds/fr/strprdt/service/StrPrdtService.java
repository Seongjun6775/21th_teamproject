package com.ktds.fr.strprdt.service;

import java.util.List;

import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface StrPrdtService {

	// 전체 조회 (전체 / 각 매장별)
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtVO);
	
	// 매장별 메뉴 사용유무
	public boolean update(StrPrdtVO strPrdtVO);

	// 매장별 메뉴 사용유무 일괄
	public boolean updateSelectAll(List<StrPrdtVO> strPrdtVOList);
	
	
}
