package com.ktds.fr.lgnhist.service;

import java.util.List;

import com.ktds.fr.lgnhist.vo.LgnHistVO;

public interface LgnHistService {
	
	//회원 이력 조회용
	public List<LgnHistVO> readMbrLgnHist(String mbrId);
}
