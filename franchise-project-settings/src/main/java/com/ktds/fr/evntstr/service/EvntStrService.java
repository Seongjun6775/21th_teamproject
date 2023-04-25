package com.ktds.fr.evntstr.service;

import java.util.List;

import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

public interface EvntStrService {

	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO);
	
	public boolean createEvntStr(EvntStrVO evntStrVO);
	
	public boolean chkAlreadyCreate(EvntStrVO evntStrVO);
	
	public boolean deleteEvntStrListByEvntId(List<String> evntStrIdList, MbrVO mbrVO);
	
	//이벤트 생성 시 모든 매장 자동 이벤트참여되도록
	public boolean insertAllEvntStr(EvntStrVO evntStrVO);

}
