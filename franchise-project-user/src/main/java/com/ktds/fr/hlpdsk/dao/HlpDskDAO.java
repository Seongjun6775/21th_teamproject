package com.ktds.fr.hlpdsk.dao;

import java.util.List;

import com.ktds.fr.hlpdsk.vo.HlpDskVO;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

public interface HlpDskDAO {
	
	public List<HlpDskVO> readAllHlpDsks(HlpDskVO hlpDskVO); 
	public List<HlpDskVO> readAllMyHlpDsks(HlpDskVO hlpDskVO); 
	public HlpDskVO readOneHlpDskByHlpDskId(String hlpDskId);
	
	public List<HlpDskVO> readAllHlpDsksPagination(String hlpDskTtl); 
	
	public int createNewHlpDsk(HlpDskVO hlpDskVO);
	public int updateNewHlpDsk(HlpDskVO hlpDskVO);
	public int deleteOneHlpDsk(String hlpDskId);
	
	public int deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId);

	
}
