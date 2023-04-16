package com.ktds.fr.rpl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.rpl.dao.RplDAO;
import com.ktds.fr.rpl.vo.RplVO;

@Service
public class RplServiceImpl implements RplService {
	
	@Autowired
	private RplDAO rplDAO;
	
	@Override
	public boolean createNewRpl(RplVO rplVO) {
		return rplDAO.createNewRpl(rplVO) > 0;
	}

	@Override
	public boolean updateOneRpl(RplVO rplVO) {
		return rplDAO.updateOneRpl(rplVO) >0;
	}

	@Override
	public boolean deleteOneRplByRplId(String rplId) {
		return rplDAO.deleteOneRplByRplId(rplId) > 0;
	}

}
