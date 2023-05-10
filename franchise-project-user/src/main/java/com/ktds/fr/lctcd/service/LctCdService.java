package com.ktds.fr.lctcd.service;

import java.util.List;

import com.ktds.fr.lctcd.vo.LctCdVO;

public interface LctCdService {

	public List<LctCdVO> readCategory(LctCdVO lctCdVO);
	
	/**
	 * 매장조회용
	 * @return
	 */
	public List<LctCdVO> read();
	
}
