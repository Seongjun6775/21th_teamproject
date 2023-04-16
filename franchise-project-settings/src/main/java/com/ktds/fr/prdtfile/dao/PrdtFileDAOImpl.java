package com.ktds.fr.prdtfile.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.prdtfile.vo.PrdtFileVO;

@Repository
public class PrdtFileDAOImpl extends SqlSessionDaoSupport implements PrdtFileDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int create(PrdtFileVO prdtFileVO) {
		return getSqlSession().insert("PrdtFile.create", prdtFileVO);
	}

	@Override
	public int updatePrdtId(PrdtFileVO prdtFileVO) {
		return getSqlSession().update("PrdtFile.updatePrdtId", prdtFileVO);
	}
	
}
