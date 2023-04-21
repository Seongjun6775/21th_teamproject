package com.ktds.fr.lctcd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.lctcd.dao.LctCdDAO;
import com.ktds.fr.lctcd.vo.LctCdVO;

@Service
public class LctCdServiceImpl implements LctCdService {

	@Autowired
	private LctCdDAO lctCdDAO;
	
	@Override
	public List<LctCdVO> readCategory(LctCdVO lctCdVO) {
		return lctCdDAO.readCategory(lctCdVO);
	}

}
