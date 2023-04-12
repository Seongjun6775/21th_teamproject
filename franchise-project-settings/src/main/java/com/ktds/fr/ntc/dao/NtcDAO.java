package com.ktds.fr.ntc.dao;


import com.ktds.fr.ntc.vo.NtcVO;

public interface NtcDAO {
	
	//등록 부분(상위관리자-공지 제목)
	public int createNoticeTitle(String ntcTtl);
	
	//등록 부분(상위관리자-내용작성)
	public int createNoticeContent(String ntcCntnt);
	
	//등록 부분(상위관리자-새글표시)
	public int createNewNoticeContent(String ntcId);
	
	//수정 부분(상위관리자-공지 수정(제목))
	public int updateNoticeTitle(String ntcTtl);
	
	//수정 부분(상위관리자-공지 수정(내용))
	public int updateNoticeContent(String ntcCntnt);
	
	//삭제 부분(공지 삭제-공지 ID로 조회후 삭제)
	public int deleteNoticeByNoticeId(String ntcId);
	
	//조회부분(조회- 등록된 공지 목록을 조회하되 제목만 조회)
	public int readAllNoticeTitleByNoticeId(String ntcId);
	
	//조회부분(조회- 선택된 공지의 상세정보 조회)
	public NtcVO readSelectedNoticeContent(NtcVO ntcVO);
	
	//조회부분(조회- 전체공지 조회(최근등록일 기준)
	public int readNoticeByRegisteredDate(String ntcRgstDt);
}
