package com.ktds.fr.str.service;

import java.util.List;

import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.str.vo.StrVO;

public interface StrService {

public List<StrVO>readAllStrMaster(StrVO strVO);
	
	public StrVO readOneStrByMaster(String strId);

	public StrVO readOneStrByManager(String strId);
	
	public boolean readBlockStrByMan(String strId);
	
	public boolean readBlockStrNm(String strNm);
	
	public boolean readBlockStrAddr(String strAddr);
	
	public boolean readBlockStrCallNum(String strCallNum);
	
	public boolean createOneStr(StrVO strVO);
	
	public boolean updateOneStrByMaster(StrVO strVO);
	
	public boolean updateOneStrByManager(StrVO strVO);
	
	public boolean deleteOneStrByStrId(String strId);
	
	/**
	 * 회원기능과 연동
	 */
	public List<StrVO>readAllStrNoPagenate(StrVO strVO);
	
	public List<CtyCdVO> readCategory(String lctId);
	public List<StrVO>readAll();
	public List<StrVO>readAllUseY(String ctyId);
	
}
