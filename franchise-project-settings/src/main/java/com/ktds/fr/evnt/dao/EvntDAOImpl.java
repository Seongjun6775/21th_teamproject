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
	public int createNewEvnt(EvntVO evntVO) {
		return getSqlSession().insert("Evnt.createNewEvnt", evntVO );
	}

	@Override
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return getSqlSession().selectList("Evnt.readAllEvnt", evntVO);
	}

	@Override
	public EvntVO readOneEvnt(EvntVO evntVO) {
		return getSqlSession().selectOne("Evnt.readOneEvnt", evntVO );
	}
	
	@Override
	public int updateEvnt(EvntVO evntVO) {
		return getSqlSession().update("Evnt.updateEvnt", evntVO );
	}

	@Override
	public int updateDeleteEvnt(EvntVO evntVO) {
		return getSqlSession().update("Evnt.updateDeleteEvnt", evntVO );
	}
}