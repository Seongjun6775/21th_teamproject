package com.ktds.fr.lgnhist.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.lgnhist.vo.LgnHistVO;

@Repository
public class LgnHistDAOImpl extends SqlSessionDaoSupport implements LgnHistDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createMbrLgnHist(LgnHistVO lgnHistVO) {
		return getSqlSession().insert("LgnHist.createMbrLgnHist",lgnHistVO);
	}
	
	

}
