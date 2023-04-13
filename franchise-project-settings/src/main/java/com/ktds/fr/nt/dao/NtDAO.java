package com.ktds.fr.nt.dao;

import java.util.List;

import com.ktds.fr.nt.vo.NtVO;

public interface NtDAO {
	
	public int createNewNt(NtVO ntVO);
	
	public List<NtVO> readAllNt(NtVO ntVO);
	
	public int updateOneNtByNtId(NtVO ntVO);
	
	public int deleteOneNtByNtId(String ntId);
	
	public int deleteNtBySelectedNtId(List<String> ntId);
	
	public NtVO readOneNtByNtId(String ntId);
	
	public List<NtVO> readAllFilteredNt(NtVO ntVO);
	
	public List<NtVO> readAllMyNt(NtVO ntVO);
	
	public int updateNtRdDtByNtId(String ntId);

}