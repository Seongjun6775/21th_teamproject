package com.ktds.fr.hlpdsk.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ktds.fr.hlpdsk.vo.HlpDskVO;

@Service
public interface HlpDskService {
	
	public List<HlpDskVO> readAllMngrBrds(HlpDskVO hlpDskVO);  
	public HlpDskVO readOneMngrBrdByMngrBrdId(String hlpDskId);
	
	public boolean createNewHlpDsk(HlpDskVO hlpDskVO);
	public boolean deleteOneHlpDsk(String hlpDskId);
	
	public boolean deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId);

}
