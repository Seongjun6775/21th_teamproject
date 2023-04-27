package com.ktds.fr.evntprdt.service;

import java.util.List;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.vo.PrdtVO;

public interface EvntPrdtService {

	// 이벤트 적용 품목 확인 ▷상위관리자,중간관리자
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO);

	// 상품등록을 위한 상품리스트 가져오기 ▶상위관리자
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO);

	// 이벤트 상품 선택하여 등록 ▶상위관리자
	public boolean createEvntPrdt(EvntPrdtVO evntPrdtVO);

	// 이벤트 상품 기간 중복 안되게 체크 ▶상위관리자
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO);

	// 이벤트 상품 등록 해제
	public boolean deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList, MbrVO mbrVO);

	// 체크된 이벤트 상품 등록
	public boolean createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList, MbrVO mbrVO);

}
