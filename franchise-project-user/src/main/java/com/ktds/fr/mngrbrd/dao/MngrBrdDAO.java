package com.ktds.fr.mngrbrd.dao;

import java.util.List;

import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

public interface MngrBrdDAO {
	
	public List<MngrBrdVO> readAllMngrBrds(MngrBrdVO mngrBrdVO); // 목록
	public List<MngrBrdVO> readAllNotice(MngrBrdVO mngrBrdVO); // 목록
	public List<MngrBrdVO> readAllMngrBrdsNopagination(String mngrBrdTtl); // 목록
	
	
	public MngrBrdVO readOneMngrBrdByMngrBrdId(String mngrBrdId);
	
	public int changeCategorytoN(String mngrBrdId);
	public int changeCategorytoY(String mngrBrdId);
	
	public int createNewMngrBrd(MngrBrdVO mngrBrdVO);
	public int updateOneMngrBrd(MngrBrdVO mngrBrdVO);
	public int deleteOneMngrBrd(String mngrBrdId);
	
	
	public int deleteMngrBrdBySelectedMngrBrdId(List<String> mngrBrdId);
	
	
	


}
