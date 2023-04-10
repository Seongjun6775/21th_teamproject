package com.ktds.fr.mngrbrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.mngrbrd.dao.MngrBrdDAO;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

@Service
public class MngrBrdServiceImpl implements MngrBrdService {

	@Autowired
	private MngrBrdDAO mngrBrdDAO;
	
	@Override
	public List<MngrBrdVO> readAllMngrBrds() {
		// TODO Auto-generated method stub
		return mngrBrdDAO.readAllMngrBrds();
	}

	@Override
	public MngrBrdVO readOneMngrBrdByMngrBrdId(String mngrBrdId) {
		MngrBrdVO brdVO = mngrBrdDAO.readOneMngrBrdByMngrBrdId(mngrBrdId);
		if(brdVO == null) {
			throw new RuntimeException("잘못된 접근입니다.");
		}
		return mngrBrdDAO.readOneMngrBrdByMngrBrdId(mngrBrdId);
	}

	@Override
	public boolean createNewMngrBrd(MngrBrdVO mngrBrdVO) {
		
		boolean createResult = mngrBrdDAO.createNewMngrBrd(mngrBrdVO) > 0;
		
		return createResult;
	}

	@Override
	public boolean updateOneMngrBrd(MngrBrdVO mngrBrdVO) {
		// TODO Auto-generated method stub
		return mngrBrdDAO.updateOneMngrBrd(mngrBrdVO) > 0 ;
	}

	@Override
	public boolean deleteOneMngrBrd(String mngrBrdId) {
		// TODO Auto-generated method stub
		return mngrBrdDAO.deleteOneMngrBrd(mngrBrdId) > 0;
	}
		
}
