package com.ktds.fr.ctycd.dao;

import java.util.List;

import com.ktds.fr.ctycd.vo.CtyCdVO;

public interface CtyCdDAO {
	
	public List<CtyCdVO> readCategory(CtyCdVO ctyCdVO);
	
	// 지점조회
	public List<CtyCdVO> read(String lctId);

}
