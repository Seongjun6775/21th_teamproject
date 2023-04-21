package com.ktds.fr.ctycd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.ctycd.dao.CtyCdDAO;
import com.ktds.fr.ctycd.vo.CtyCdVO;

@Service
public class CtyCdServiceImpl implements CtyCdService {

	@Autowired
	private CtyCdDAO ctyCdDAO;
	
	@Override
	public List<CtyCdVO> readCategory(CtyCdVO ctyCdVO) {
		return ctyCdDAO.readCategory(ctyCdVO);
	}

}
