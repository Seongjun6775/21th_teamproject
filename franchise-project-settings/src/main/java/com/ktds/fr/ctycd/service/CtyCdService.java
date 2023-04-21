package com.ktds.fr.ctycd.service;

import java.util.List;

import com.ktds.fr.ctycd.vo.CtyCdVO;

public interface CtyCdService {

	public List<CtyCdVO> readCategory(String codeId);
	
}
