package com.ktds.fr.prdt.dao;

import java.util.List;

import com.ktds.fr.prdt.vo.PrdtVO;

public interface PrdtDAO {
	
	public List<PrdtVO> readAll(PrdtVO prdtVO);
	public PrdtVO readOne(String prdtId);
	
	public int create(PrdtVO prdtVO);
	public int update(PrdtVO prdtVO);
	public int deleteOne(String prdtId);
	public int deleteSelectAll(List<String> prdtIdList);
	
	
	
}
