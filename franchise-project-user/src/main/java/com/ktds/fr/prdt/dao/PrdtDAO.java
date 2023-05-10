package com.ktds.fr.prdt.dao;

import java.util.List;

import com.ktds.fr.prdt.vo.PrdtVO;

public interface PrdtDAO {
	
	public List<PrdtVO> readAll(PrdtVO prdtVO);
	public List<PrdtVO> readAllNoPagenation(PrdtVO prdtVO);
	public List<PrdtVO> readAllNoPagenationUseY(PrdtVO prdtVO);
	public List<PrdtVO> readAllCustomerNoPagenation(PrdtVO prdtVO);
	public PrdtVO readOne(String prdtId);
	public List<PrdtVO> readAllCustomer(PrdtVO prdtVO);
	
	public int create(PrdtVO prdtVO);
	public int update(PrdtVO prdtVO);
	public int updateAll(PrdtVO prdtVO);
	public int deleteOne(String prdtId);
	public int deleteSelectAll(List<String> prdtIdList);
	
	
	public List<PrdtVO> readAllNoPagenationEvnt(PrdtVO prdtVO);
	
}
