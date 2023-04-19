package com.ktds.fr.strprdt.dao;

import java.util.List;

import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface StrPrdtDAO {
	
	// 전체 조회 (전체 / 각 매장별)
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtVO);
	
	// 메뉴등록시, 매장등록시 목록생성에 활용
	public int create(List<StrPrdtVO> strPrdtList);
	
	// 매장별 메뉴 사용유무
	public int update(StrPrdtVO strPrdtVO);
	
	// 메뉴삭제시 삭제여부 변경에 활용
	public int deletePrdtId(String prdtId);

	// 메뉴삭제시 삭제여부 변경에 활용
	public int deletePrdtList(List<String> PrdtList);
	
	// 매장삭제시 삭제여부 변경에 활용
	public int deleteStrId(String srtId);
	
	// 매장삭제시 삭제여부 변경에 활용
	public int deleteStrList(List<String> StrList);

}
