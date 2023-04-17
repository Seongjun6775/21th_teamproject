package com.ktds.fr.ntc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ktds.fr.ntc.vo.NtcVO;

@Service
public interface NtcService {

	//등록 부분(상위관리자-내용,제목 등록)
	public boolean createNotice(NtcVO ntcVO);

	//수정 부분(상위관리자-공지 수정(제목))
	public boolean updateNotice(NtcVO ntcVO);

	//삭제 부분(공지 삭제-공지 ID로 조회후 삭제)
	public boolean deleteNotice(String ntcId);

	//조회부분(공지 전체 조회)
	public List<NtcVO> readTotalNotice(NtcVO ntcVO);
	
	//조회부분(공지 상세 조회)
	public List<NtcVO> readDetailNotice(NtcVO ntcVO);
}
