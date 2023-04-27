package com.ktds.fr.evntprdt.dao;

import java.util.List;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.prdt.vo.PrdtVO;

public interface EvntPrdtDAO {

	
	// 이벤트 적용 품목 확인 ▷상위관리자,중간관리자
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO);	
	
	// 상품등록을 위한 상품리스트 가져오기  ▶상위관리자
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO);

	// 이벤트 상품 선택하여 등록 	 ▶상위관리자
	public int createEvntPrdt(EvntPrdtVO evntPrdtVO);
	
	// 이벤트 상품 기간 중복 안되게 체크 ▶상위관리자
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO);
	
	// 이벤트 상품 등록 해제기능
	public int deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList);
	
	// 체크된 이벤트 상품 등록
	public int createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList);

}
