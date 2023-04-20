package com.ktds.fr.rpl.dao;

import java.util.List;

import com.ktds.fr.rpl.vo.RplVO;

public interface RplDAO {

	
	public List<RplVO> readAllRpls(RplVO rplVO);
	
	public int createNewRpl(RplVO rplVO);
	public int updateOneRpl(RplVO rplVO);
	public int deleteOneRplByRplId(String rplId);
	
	public int deleteRplBySelectedRplId(List<String> rplId);
}


