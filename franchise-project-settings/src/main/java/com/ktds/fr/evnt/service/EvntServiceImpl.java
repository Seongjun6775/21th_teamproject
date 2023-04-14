package com.ktds.fr.evnt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evnt.dao.EvntDAO;
import com.ktds.fr.evnt.vo.EvntVO;

@Service
public class EvntServiceImpl implements EvntService {

	@Autowired
	private EvntDAO evntDAO;

	// 1. 이벤트 등록 ▶▶상위관리자
	@Override
	public boolean createNewEvnt(EvntVO evntVO) {
		return evntDAO.createNewEvnt(evntVO) > 0;
	}

	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	@Override
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return evntDAO.readAllEvnt(evntVO);
	}

	// 3. 이벤트 조회(상세조회 + 참여 여부 확인) ▶중간관리자
	@Override
	public EvntVO readOneEvnt(String evntId) {
		return evntDAO.readOneEvnt(evntId);
	}
	
	// 4. 이벤트 결정 전,후 내용 조회 ▷상위관리자,중간관리자
	
	
	// 5. 이벤트 내용 수정 ▶▶상위관리자
	@Override
	public boolean updateEvnt(EvntVO envtVO) {
		return evntDAO.updateEvnt(envtVO) > 0;
	}
	
	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자

	
	// 7. 이벤트 삭제 ▶▶상위관리자
	@Override
	public boolean updateDeleteEvnt(String evntId) {
		return evntDAO.updateDeleteEvnt(evntId) > 0;
	}

}