package com.ktds.fr.cmmncd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.cmmncd.dao.CmmnCdDAO;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;

@Service
public class CmmnCdServiceImpl implements CmmnCdService {

	@Autowired
	private CmmnCdDAO cmmnCdDAO;
	
	@Override
	public List<CmmnCdVO> readCategory(String codeId) {
		return cmmnCdDAO.readCategory(codeId);
	}
	

}
