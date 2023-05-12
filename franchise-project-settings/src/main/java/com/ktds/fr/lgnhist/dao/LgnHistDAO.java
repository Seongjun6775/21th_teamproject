package com.ktds.fr.lgnhist.dao;

import java.util.List;

import com.ktds.fr.lgnhist.vo.LgnHistVO;

public interface LgnHistDAO {
	
	public int createMbrLgnHist(LgnHistVO lgnHistVO);
	
	//회원 이력 조회용
	public List<LgnHistVO> readMbrLgnHist(String mbrId);
}
