package com.ktds.fr.hlpdsk.dao;

import java.util.List;

import com.ktds.fr.hlpdsk.vo.HlpDskVO;

public interface HlpDskDAO {
	
	public List<HlpDskVO> readAllMngrBrds(HlpDskVO hlpDskVO);  
	public HlpDskVO readOneMngrBrdByMngrBrdId(String hlpDskId);
	
	public int createNewHlpDsk(HlpDskVO hlpDskVO);
	public int deleteOneHlpDsk(String hlpDskId);
	
	public int deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId);

	
}
