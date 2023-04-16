package com.ktds.fr.rpl.service;

import com.ktds.fr.rpl.vo.RplVO;

public interface RplService {
	
	public boolean createNewRpl(RplVO rplVO);
	
	public boolean updateOneRpl(RplVO rplVO);
	
	public boolean deleteOneRplByRplId(String rplId);

}
