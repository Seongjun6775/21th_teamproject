package com.ktds.fr.prdt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.prdt.vo.PrdtVO;

@Repository
public class PrdtDAOImpl extends SqlSessionDaoSupport implements PrdtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<PrdtVO> readAll(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAll", prdtVO);
	}

	@Override
	public PrdtVO readOne(String prdtId) {
		return getSqlSession().selectOne("Prdt.readOne", prdtId);
	}
	
	@Override
	public int create(PrdtVO prdtVO) {
		return getSqlSession().insert("Prdt.create", prdtVO);
	}

	@Override
	public int update(PrdtVO prdtVO) {
		return getSqlSession().update("Prdt.update", prdtVO);
	}

	@Override
	public int deleteOne(String prdtId) {
		return getSqlSession().update("Prdt.deleteOne", prdtId);
	}

	@Override
	public int deleteSelectAll(List<String> prdtIdList) {
		return getSqlSession().update("Prdt.deleteSelectAll", prdtIdList);
	}

}
