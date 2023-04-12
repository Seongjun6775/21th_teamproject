package com.ktds.fr.evnt.dao;

import java.util.List;

import com.ktds.fr.evnt.vo.EvntVO;

public interface EvntDAO {

	//이벤트 등록
	public int createNewEvnt(EvntVO evntVO);
	
	//이벤트 전체목록 조회
	public List<EvntVO> readAllEvnt(EvntVO evntVO);
	
	//이벤트 조회(상세조회)
	public EvntVO readOneEvnt(EvntVO evntVO);
	
	//이벤트 수정
	public int updateEvnt(EvntVO evntVO);

	//이벤트 삭제
	public int updateDeleteEvnt(EvntVO evntVO);
}