package com.ktds.fr.str.service;

import java.util.List;

import com.ktds.fr.str.vo.StrVO;

public interface StrService {

public List<StrVO>readAllStrMaster(StrVO strVO);
	
	public StrVO readOneStrByMaster(String strId);

	public StrVO readOneStrByManager(String strId);
	
	public boolean readBlockStrNm(StrVO strVO);
	
	public boolean readBlockStrAddr(StrVO strVO);
	
	public boolean readBlockStrCallNum(StrVO strVO);
	
	public boolean createOneStr(StrVO strVO);
	
	public boolean updateOneStrByMaster(StrVO strVO);
	
	public boolean updateOneStrByManager(StrVO strVO);
	
	public boolean deleteOneStrByStrId(String strId);
	
}
