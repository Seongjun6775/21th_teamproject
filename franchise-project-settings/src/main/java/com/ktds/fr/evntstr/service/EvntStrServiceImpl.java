package com.ktds.fr.evntstr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evntstr.dao.EvntStrDAO;
import com.ktds.fr.evntstr.vo.EvntStrVO;

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
}
