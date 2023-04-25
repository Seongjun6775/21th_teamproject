package com.ktds.fr.chsrl.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.mbr.vo.MbrVO;

@Repository
public class ChSrlDAOImpl extends SqlSessionDaoSupport implements ChSrlDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createOneChHist(MbrVO mbrVO) {
		return getSqlSession().insert("ChSrl.createOneChHist", mbrVO);
	}
}
