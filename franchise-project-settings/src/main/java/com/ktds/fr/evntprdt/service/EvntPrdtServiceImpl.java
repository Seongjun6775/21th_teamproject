package com.ktds.fr.evntprdt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evntprdt.dao.EvntPrdtDAO;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;

@Service	
public class EvntPrdtServiceImpl implements EvntPrdtService {

	@Autowired
	private EvntPrdtDAO evntPrdtDAO;
	
	@Override
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return evntPrdtDAO.readAllEvntPrdt(evntPrdtVO) ;
	}

}
