package com.ktds.fr.nt.service;

import java.util.List;

import com.ktds.fr.nt.vo.NtVO;

public interface NtService {
	
	public boolean createNewNt(NtVO ntVO);
	
	public List<NtVO> readAllNt(NtVO ntVO);
	
	public boolean updateOneNtByNtId(NtVO ntVO);
	
	public boolean deleteOneNtByNtId(String ntId);
	
	public boolean deleteNtBySelectedNtId(List<String> ntId);
	
	public NtVO readOneNtByNtId(String ntId);

}