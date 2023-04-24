package com.ktds.fr.hlpdsk.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ktds.fr.hlpdsk.vo.HlpDskVO;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

@Service
public interface HlpDskService {
	
	public List<HlpDskVO> readAllHlpDsks(HlpDskVO hlpDskVO);  
	public List<HlpDskVO> readAllMyHlpDsks(HlpDskVO hlpDskVO);  
	
	public List<HlpDskVO> readAllHlpDsksPagination(String mngrBrdTtl);
	
	public HlpDskVO readOneHlpDskByHlpDskId(String hlpDskId);
	
	public boolean createNewHlpDsk(HlpDskVO hlpDskVO);
	public boolean updateNewHlpDsk(HlpDskVO hlpDskVO);
	public boolean deleteOneHlpDsk(String hlpDskId);
	
	
	public boolean deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId);

}
