package com.ktds.fr.cmmncd.service;

import java.util.List;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;

public interface CmmnCdService {

	public List<CmmnCdVO> readCategory(String codeId);
	
}
