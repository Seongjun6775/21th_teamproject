package com.ktds.fr.evnt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.evnt.vo.EvntVO;

@Repository
public class EvntDAOImpl extends SqlSessionDaoSupport implements EvntDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	// 1. 이벤트 등록 ▶▶상위관리자
	public int createNewEvnt(EvntVO evntVO) {
		return getSqlSession().insert("Evnt.createNewEvnt", evntVO );
	}

	@Override
	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllEvnt", evntVO);
	}

	@Override
	// 3. 이벤트 조회(상세조회 + 참여 여부 확인) ▶중간관리자
	public EvntVO readOneEvnt(String evntId) {
		return getSqlSession().selectOne("Evnt.readOneEvnt", evntId );
	}
		
	// 4. 이벤트 결정 전,후 내용 조회 ▷상위관리자,중간관리자
	
	@Override
	// 5. 이벤트 내용 수정 ▶▶상위관리자
	public int updateEvnt(EvntVO evntVO) {
		return getSqlSession().update("Evnt.updateEvnt", evntVO );
	}
	
	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자
	
	@Override
	// 7. 이벤트 삭제 ▶▶상위관리자
	public int updateDeleteEvnt(String evntId) {
		return getSqlSession().update("Evnt.updateDeleteEvnt", evntId );
	}

	//이용자용 페이지
	@Override
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllOngoingEvnt", evntVO );
	}

}