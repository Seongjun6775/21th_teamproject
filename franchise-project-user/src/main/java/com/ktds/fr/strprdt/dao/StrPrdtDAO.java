package com.ktds.fr.strprdt.dao;

import java.util.List;

import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface StrPrdtDAO {
	
	// 전체 조회 (전체 / 각 매장별)
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtVO);
	public List<StrPrdtVO> readAllNOPagenation(StrPrdtVO strPrdtVO);
	
	// 매장의 물품 조회 - 손님용
	public List<StrPrdtVO> readAllCustomerByStr(StrPrdtVO strPrdtVO);
	// 매장의 물품 상세 조회 - 손님용
	public StrPrdtVO readOneCustomerByStr(String strPrdtId);
	
	// 매장별 누락물품 조회
	public List<PrdtVO> missingList(String strId);
	
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
