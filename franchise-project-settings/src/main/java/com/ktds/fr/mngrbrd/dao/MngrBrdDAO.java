package com.ktds.fr.mngrbrd.dao;

import java.util.List;

import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

public interface MngrBrdDAO {
	
	public List<MngrBrdVO> readAllMngrBrds(); // 목록
	
	public MngrBrdVO readOneMngrBrdByMngrBrdId(String mngrBrdId);
	
	public int createNewMngrBrd(MngrBrdVO mngrBrdVO);
	public int updateOneMngrBrd(MngrBrdVO mngrBrdVO);
	public int deleteOneMngrBrd(String mngrBrdId);
	
	
	

}
