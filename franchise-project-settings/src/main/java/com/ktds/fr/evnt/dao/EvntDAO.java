package com.ktds.fr.evnt.dao;

import java.util.List;

import com.ktds.fr.evnt.vo.EvntVO;

public interface EvntDAO {

	// 1. 이벤트 등록 ▶▶상위관리자
	public int createNewEvnt(EvntVO evntVO);
	
	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	public List<EvntVO> readAllEvnt(EvntVO evntVO);
	
	//이벤트 전체목록 페이지네이션
	//public List<EvntVO> readAllNopagintion(String );
	
	// 3. 이벤트 조회(상세조회 + 참여 여부 확인) ▶중간관리자
	public EvntVO readOneEvnt(String evntId);
	
	// 4. 이벤트 결정 전,후 내용 조회 ▷상위관리자,중간관리자
	
	// 5. 이벤트 내용 수정 ▶▶상위관리자
	public int updateEvnt(EvntVO evntVO);
	
	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자
		
	// 7. 이벤트 삭제 ▶▶상위관리자
	public int updateDeleteEvnt(String evntId);
}