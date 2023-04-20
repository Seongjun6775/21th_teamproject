package com.ktds.fr.rpl.service;

import java.util.List;

import com.ktds.fr.rpl.vo.RplVO;

public interface RplService {
	
	public List<RplVO> readAllRpls(RplVO rplVO);
	
	public boolean createNewRpl(RplVO rplVO);
	
	public boolean updateOneRpl(RplVO rplVO);
	
	public boolean deleteOneRplByRplId(String rplId);
	
	public boolean deleteRplBySelectedRplId(List<String> rplId);

}
