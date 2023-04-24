package com.ktds.fr.evntstr.dao;

import java.util.List;

import com.ktds.fr.evntstr.vo.EvntStrVO;

public interface EvntStrDAO {

	//참여매장 등록하기 ▶ 중간관리자
	public int createEvntStr(EvntStrVO evntStrVO);
	
	
	// 참여매장목록 가져오기  ▷상위관리자,중간관리자
	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO);
	
}
