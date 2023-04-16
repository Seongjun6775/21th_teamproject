package com.ktds.fr.strprdt.dao;

import java.util.List;

import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface StrPrdtDAO {
	
	// 전체 조회 (전체 / 각 매장별)
	public List<StrPrdtVO> readAll(String strPrdtId);
	
	// 메뉴등록시, 매장등록시 목록생성에 활용
	public int create(List<StrPrdtVO> strPrdtList);
	
	// 메뉴삭제시, 매장삭제시 삭제여부 변경에 활용
	public int delete(String srtPrdtId);

}
