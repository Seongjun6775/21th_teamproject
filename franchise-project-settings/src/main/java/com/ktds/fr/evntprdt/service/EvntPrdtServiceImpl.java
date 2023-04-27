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
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.readAllEvntPrdt(evntPrdtVO) ;
	}

	@Override
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.readAllPrdt(evntPrdtVO);
	}

	@Override
	public boolean createEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.createEvntPrdt(evntPrdtVO) > 0;
	}

	@Override
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.chkEvntPrdt(evntPrdtVO);
	}

	@Override
	public boolean deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList, MbrVO mbrVO) {
		if(mbrVO.getMbrLvl().equals("001-04")) {
			return evntPrdtDAO.deleteEvntPrdtListByEvntId(evntPrdtIdList) > 0;
		}
		return false;
	}

	@Override
	public boolean createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList, MbrVO mbrVO) {
		System.out.println("생성돌앗나");
		if (mbrVO.getMbrLvl().equals("001-01")) {
			System.out.println("권한확인");
			return evntPrdtDAO.createEvntPrdtListByEvntId(evntPrdtList) > 0;
		}
		return false;
	}
	
	
	

}
