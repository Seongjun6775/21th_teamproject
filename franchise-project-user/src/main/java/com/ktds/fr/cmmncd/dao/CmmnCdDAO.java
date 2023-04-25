package com.ktds.fr.cmmncd.dao;

import java.util.List;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;

public interface CmmnCdDAO {
	
	public List<CmmnCdVO> readCategory(String codeId);

}
