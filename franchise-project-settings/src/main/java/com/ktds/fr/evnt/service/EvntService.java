package com.ktds.fr.evnt.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.evnt.vo.EvntVO;
import com.ktds.fr.evntstr.vo.EvntStrVO;

public interface EvntService {

	// 1. 이벤트 등록 ▶▶상위관리자
	public boolean createNewEvnt(EvntVO evntVO, MultipartFile uploadFile);
	
	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	public List<EvntVO> readAllEvnt(EvntVO evntVO);
	
	// 3. 이벤트 조회(상세조회 + 참여 여부 확인) ▶중간관리자
	public EvntVO readOneEvnt(String evntId);
	
	// 4. 이벤트 결정 전,후 내용 조회 ▷상위관리자,중간관리자

	// 5. 이벤트 내용 수정 ▶▶상위관리자
	public boolean updateEvnt(EvntVO envtVO, MultipartFile uploadFile);
	
	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자
	
	// 7. 이벤트 삭제 ▶▶상위관리자
	public boolean updateDeleteEvnt(String evntId);
	
	// 8. 이용자용 페이지
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO);
	
	// 9. 이용자용 페이지(지난이벤트)
	public List<EvntVO> readAllPastEvnt(EvntVO evntVO);
		
	// 10. 이용자용 페이지(예정 이벤트)
	public List<EvntVO> readAllPlanEvnt(EvntVO evntVO);

}