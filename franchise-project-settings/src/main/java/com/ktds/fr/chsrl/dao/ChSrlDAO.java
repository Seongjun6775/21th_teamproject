package com.ktds.fr.chsrl.dao;

import java.util.List;

import com.ktds.fr.mbr.vo.MbrVO;

public interface ChSrlDAO {
	
	public int createOneChHist(MbrVO mbrVO);
	
	public int createAllChHist(List<MbrVO> mbrVOList);
	
}
