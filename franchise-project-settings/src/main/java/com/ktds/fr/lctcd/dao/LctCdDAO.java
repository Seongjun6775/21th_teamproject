package com.ktds.fr.lctcd.dao;

import java.util.List;

import com.ktds.fr.lctcd.vo.LctCdVO;

public interface LctCdDAO {
	
	public List<LctCdVO> readCategory(LctCdVO lctCdVO);
	
	/**
	 * 매장조회용
	 * @return
	 */
	public List<LctCdVO> read();

}
