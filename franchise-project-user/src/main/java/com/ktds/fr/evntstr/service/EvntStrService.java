package com.ktds.fr.evntstr.service;

import java.util.List;

import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

public interface EvntStrService {

	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO);
	
	public boolean createEvntStr(EvntStrVO evntStrVO);
	
	public boolean chkAlreadyCreate(EvntStrVO evntStrVO);
	
	public boolean deleteEvntStrListByEvntId(List<String> evntStrIdList, MbrVO mbrVO);
}
