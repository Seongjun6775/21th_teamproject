package com.ktds.fr.evnt.dao;

import java.util.List;

import com.ktds.fr.evnt.vo.EvntVO;

public interface EvntDAO {

	// 1. 이벤트 등록 ▶▶최상위관리자 001-01
	public int createNewEvnt(EvntVO evntVO);
	
	// 2. 이벤트 전체목록 조회 ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntVO> readAllEvnt(EvntVO evntVO);
	
	// 3. 이벤트 상세조회 (detail page)  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public EvntVO readOneEvnt(String evntId);
	
	// 4. 이벤트 등록 내용 수정 ▶▶최상위관리자 001-01
	public int updateEvnt(EvntVO evntVO);
		
	// 5. 이벤트 삭제 ▶▶최상위관리자 001-01
	public int updateDeleteEvnt(String evntId);
	
	// 6. 이용자 페이지(첫화면 -> 현재진행중인 이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO);
	
	// 7. 이용자 페이지(지난이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllPastEvnt(EvntVO evntVO);
	
	// 8. 이용자 페이지(예정 이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllPlanEvnt(EvntVO evntVO);
	
	//이벤트 전체목록 페이지네이션
		//public List<EvntVO> readAllNopagintion(String );
}
