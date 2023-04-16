package com.ktds.fr.rpl.dao;

import com.ktds.fr.rpl.vo.RplVO;

public interface RplDAO {

	public int createNewRpl(RplVO rplVO);
	
	public int updateOneRpl(RplVO rplVO);
	
	public int deleteOneRplByRplId(String rplId);
}
