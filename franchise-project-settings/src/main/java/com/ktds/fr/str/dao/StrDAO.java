package com.ktds.fr.str.dao;

import java.util.List;

import com.ktds.fr.str.vo.StrVO;

public interface StrDAO {

	public List<StrVO>readAllStrMaster(StrVO strVO);
	
	public StrVO readOneStrByMaster(String strId);

	public StrVO readOneStrByManager(String strId);

	public int readBlockStrNm(String strNm);
	
	public int readBlockStrAddr(String strAddr);
	
	public int readBlockStrCallNum(String strCallNum);
	
	public int createOneStr(StrVO strVO);
	
	public int updateOneStrByMaster(StrVO strVO);
	
	public int updateOneStrByManager(StrVO strVO);
	
	public int deleteOneStrByStrId(String strId);
	
}
