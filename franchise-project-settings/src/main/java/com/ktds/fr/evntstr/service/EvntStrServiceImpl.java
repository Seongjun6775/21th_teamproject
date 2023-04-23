package com.ktds.fr.evntstr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evntstr.dao.EvntStrDAO;
import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Service
public class EvntStrServiceImpl implements EvntStrService {

	@Autowired
	private EvntStrDAO evntStrDAO;
	
	@Override
	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO) {
		return evntStrDAO.readAllEvntStr(evntStrVO);
	}

	@Override
	public boolean createEvntStr(EvntStrVO evntStrVO) {
		return evntStrDAO.createEvntStr(evntStrVO) > 0;
	}
	
	@Override
	public boolean chkAlreadyCreate(EvntStrVO evntStrVO) {
		return evntStrDAO.chkAlreadyCreate(evntStrVO) > 0;
	}

	@Override
	public boolean deleteEvntStrListByEvntId(List<String> evntStrIdList, MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01")) {
			return evntStrDAO.deleteEvntStrListByEvntId(evntStrIdList) > 0;
		}
		return false;
	}
}
