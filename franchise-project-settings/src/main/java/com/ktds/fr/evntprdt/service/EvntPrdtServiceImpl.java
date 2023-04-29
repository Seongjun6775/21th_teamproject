package com.ktds.fr.evntprdt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evntprdt.dao.EvntPrdtDAO;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.vo.PrdtVO;

@Service	
public class EvntPrdtServiceImpl implements EvntPrdtService {

	@Autowired
	private EvntPrdtDAO evntPrdtDAO;
	
	@Override
	// 1. 이벤트 적용 품목 확인  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.readAllEvntPrdt(evntPrdtVO) ;
	}

	@Override
	// 2. 이벤트상품 등록을 위한 전체 상품리스트 가져오기 ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.readAllPrdt(evntPrdtVO);
	}

	@Override
	// 3. 이벤트상품 등록 ▶▶최상위관리자 001-01
	public boolean createEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.createEvntPrdt(evntPrdtVO) > 0;
	}

	@Override
	// 4. 이벤트 기간 내 동일 상품 이벤트 등록 중복 방지  ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.chkEvntPrdt(evntPrdtVO);
	}

	@Override
	// 5. 이벤트 상품 등록 해제  ▶▶최상위관리자 001-01
	public boolean deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList, MbrVO mbrVO) {
		if(mbrVO.getMbrLvl().equals("001-01")) {
			return evntPrdtDAO.deleteEvntPrdtListByEvntId(evntPrdtIdList) > 0;
		}
		return false;
	}

	@Override
	// 6. 체크된 이벤트 상품 일괄(개별) 등록 ▶▶최상위관리자 001-01
	public boolean createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList, MbrVO mbrVO) {
		System.out.println("생성돌앗나");
		if (mbrVO.getMbrLvl().equals("001-01")) {
			System.out.println("권한확인");
			return evntPrdtDAO.createEvntPrdtListByEvntId(evntPrdtList) > 0;
		}
		return false;
	}
	
	
	

}
