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
	//  1. 이벤트 등록 ▶▶최상위관리자 001-01
	public int createNewEvnt(EvntVO evntVO) {
		return getSqlSession().insert("Evnt.createNewEvnt", evntVO );
	}

	@Override
	// 2. 이벤트 전체목록 조회 ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllEvnt", evntVO);
	}

	@Override
	// 3. 이벤트 상세조회 (detail page)  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public EvntVO readOneEvnt(String evntId) {
		return getSqlSession().selectOne("Evnt.readOneEvnt", evntId );
	}
		
	@Override
	// 4. 이벤트 등록 내용 수정 ▶▶최상위관리자 001-01
	public int updateEvnt(EvntVO evntVO) {
		return getSqlSession().update("Evnt.updateEvnt", evntVO );
	}
	
	@Override
	// 5. 이벤트 삭제 ▶▶최상위관리자 001-01
	public int updateDeleteEvnt(String evntId) {
		return getSqlSession().update("Evnt.updateDeleteEvnt", evntId );
	}

	
	@Override
	// 6. 이용자 페이지(첫화면 -> 현재진행중인 이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllOngoingEvnt", evntVO );
	}

	@Override
	// 7. 이용자 페이지(지난이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllPastEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllPastEvnt", evntVO);
	}

	// 8. 이용자 페이지(예정 이벤트) ★☆소비자 001-04
	@Override
	public List<EvntVO> readAllPlanEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllPlanEvnt", evntVO);
	}

}