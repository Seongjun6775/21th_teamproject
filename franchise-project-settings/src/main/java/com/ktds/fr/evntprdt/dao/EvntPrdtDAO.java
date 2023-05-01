package com.ktds.fr.evntprdt.dao;

import java.util.List;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.prdt.vo.PrdtVO;

public interface EvntPrdtDAO {

	
	// 1. 이벤트 적용 품목 확인  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO);	
	
	// 2. 이벤트상품 등록을 위한 전체 상품리스트 가져오기 ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO);

	// 3. 이벤트상품 등록 ▶▶최상위관리자 001-01
	public int createEvntPrdt(EvntPrdtVO evntPrdtVO);
	
	// 4. 이벤트 기간 내 동일 상품 이벤트 등록 중복 방지  ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO);
	
	// 5. 이벤트 상품 등록 해제  ▶▶최상위관리자 001-01
	public int deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList);
	
	// 6. 체크된 이벤트 상품 일괄(개별) 등록 ▶▶최상위관리자 001-01
	public int createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList);

}
