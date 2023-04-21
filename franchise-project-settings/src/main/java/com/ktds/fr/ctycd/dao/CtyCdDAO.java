package com.ktds.fr.ctycd.dao;

import java.util.List;

import com.ktds.fr.ctycd.vo.CtyCdVO;

public interface CtyCdDAO {
	
	public List<CtyCdVO> readCategory(String codeId);

}
