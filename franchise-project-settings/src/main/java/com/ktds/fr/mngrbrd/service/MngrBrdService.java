package com.ktds.fr.mngrbrd.service;

import java.util.List;

import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

public interface MngrBrdService {
	
	public List<MngrBrdVO> readAllMngrBrds(MngrBrdVO mngrBrdVO); // 목록
	
	public List<MngrBrdVO> readAllMngrBrdsPagination(String mngrBrdTtl); 
	
	
	public MngrBrdVO readOneMngrBrdByMngrBrdId(String mngrBrdId);
	
	public boolean createNewMngrBrd(MngrBrdVO mngrBrdVO);
	public boolean updateOneMngrBrd(MngrBrdVO mngrBrdVO);
	public boolean deleteOneMngrBrd(String mngrBrdId);
	
	public boolean deleteMngrBrdBySelectedMngrBrdId(List<String> mngrBrdId);
	

}
