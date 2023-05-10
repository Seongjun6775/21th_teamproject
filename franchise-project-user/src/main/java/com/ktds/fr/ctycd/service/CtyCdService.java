package com.ktds.fr.ctycd.service;

import java.util.List;

import com.ktds.fr.ctycd.vo.CtyCdVO;

public interface CtyCdService {

	public List<CtyCdVO> readCategory(CtyCdVO ctyCdVO);
	
	// 지점조회
	public List<CtyCdVO> read(String lctId);
	public List<CtyCdVO> readCtyInLct(String lctId);
	
}
